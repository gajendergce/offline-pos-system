#!/usr/bin/env bash
set -euo pipefail

# Full setup in one command for ZIP-based Laravel source.
# Usage:
#   ./scripts/offline/setup-full-offline.sh [laravel_zip_url]
# Example:
#   ./scripts/offline/setup-full-offline.sh http://taxnomist.busywizzy.com/pos_1.0.zip
# If URL is not passed, script resolves version via API and builds ZIP URL from .env.offline.

APP_ZIP_URL_INPUT="${1:-}"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

OFFLINE_ENV_FILE="${OFFLINE_ENV_FILE:-$PROJECT_ROOT/.env.offline}"
if [[ -f "$OFFLINE_ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$OFFLINE_ENV_FILE"
  set +a
fi

APP_ZIP_URL="${APP_ZIP_URL_INPUT:-${APP_ZIP_URL:-}}"
APP_VERSION_URL="${APP_VERSION_URL:-}"
OFFLINE_STORE_ID="${POS_OFFLINE_SYNC_STORE_ID:-${OFFLINE_STORE_ID:-}}"
OFFLINE_TOKEN="${POS_OFFLINE_SYNC_TOKEN:-${OFFLINE_TOKEN:-}}"
OFFLINE_API_BASE_URL="${POS_OFFLINE_SYNC_SOURCE_URL:-${OFFLINE_API_BASE_URL:-}}"

# Derive APP_VERSION_URL from POS_OFFLINE_SYNC_SOURCE_URL when not explicitly set.
if [[ -z "$APP_VERSION_URL" && -n "$OFFLINE_API_BASE_URL" ]]; then
  APP_VERSION_URL="$(printf '%s' "$OFFLINE_API_BASE_URL" | sed 's|/*$||')/api/offline/version"
fi

sync_offline_env_into_app_env() {
  docker compose -f "$COMPOSE_FILE" exec -T app sh -lc '
cd /var/www/html

store_id="$1"
token="$2"
base_url="$3"
version_url="$4"
zip_url="$5"

if [ ! -f .env ]; then
  exit 0
fi

set_kv() {
  key="$1"
  val="$(printf '%s' "$2" | sed 's/[[:space:]]*$//')"
  if [ -z "$val" ]; then
    return 0
  fi

  if grep -q "^${key}=" .env; then
    sed -i "s|^${key}=.*|${key}=${val}|" .env
  else
    echo "${key}=${val}" >> .env
  fi
}

set_kv POS_OFFLINE_MODE true
set_kv POS_OFFLINE_SYNC_STORE_ID "$store_id"
set_kv OFFLINE_TOKEN "$token"
set_kv POS_OFFLINE_SYNC_SOURCE_URL "$base_url"
set_kv POS_OFFLINE_SYNC_STORE_ID "$store_id"
set_kv POS_OFFLINE_SYNC_TOKEN "$token"
set_kv POS_OFFLINE_SYNC_SOURCE_URL "$base_url"
set_kv APP_VERSION_URL "$version_url"
set_kv APP_ZIP_URL "$zip_url"
' sh "$OFFLINE_STORE_ID" "$OFFLINE_TOKEN" "$OFFLINE_API_BASE_URL" "$APP_VERSION_URL" "$APP_ZIP_URL"
}

FETCHED_ZIP_URL=""

fetch_target_version() {
  FETCHED_ZIP_URL=""
  if [[ -z "$OFFLINE_STORE_ID" || -z "$OFFLINE_TOKEN" ]]; then
    return 1
  fi

  payload="$(printf '{"store_id": %s, "offline_token":"%s"}' "$OFFLINE_STORE_ID" "$OFFLINE_TOKEN")"

  response="$(curl -fsSL --request GET "$APP_VERSION_URL" --header 'Content-Type: application/json' --data "$payload" || true)"
  if [[ -z "$response" ]]; then
    return 1
  fi

  compact="$(printf "%s" "$response" | tr -d '\r\n')"

  # Extract ZIP URL from API response.
  FETCHED_ZIP_URL="$(printf "%s" "$compact" | sed -n 's/.*"POS_OFFLINE_ZIP_URL"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' | sed 's/\\\//\//g')"

  parsed="$(printf "%s" "$compact" | sed -n 's/.*"POS_OFFLINE_BUNDLE_APP_VERSION"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"

  if [[ -z "$parsed" ]]; then
    parsed="$(printf "%s" "$compact" | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"
  fi

  if [[ -n "$parsed" ]]; then
    printf "%s" "$parsed"
  else
    printf "%s" "$compact" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
  fi
}

# Fetch APP_ZIP_URL from the version API when not explicitly provided.
if [[ -z "$APP_ZIP_URL" ]] && [[ -n "$APP_VERSION_URL" ]]; then
  fetch_target_version > /dev/null || true
  if [[ -n "$FETCHED_ZIP_URL" ]]; then
    APP_ZIP_URL="$FETCHED_ZIP_URL"
    echo "ZIP URL from API: $APP_ZIP_URL"
  fi
fi

COMPOSE_FILE="${COMPOSE_FILE:-$PROJECT_ROOT/docker-compose.github.yml}"
APP_SYNC_ZIP_ON_START="${APP_SYNC_ZIP_ON_START:-1}"
DB_SETUP_MODE="${DB_SETUP_MODE:-structure}"

if [[ "$DB_SETUP_MODE" == "structure" ]] && compgen -G "$PROJECT_ROOT/docker/mysql/*.sql" >/dev/null; then
  DB_SETUP_MODE="sql"
fi

# Defaults can be overridden via env vars while running this script.
DB_DATABASE="${DB_DATABASE:-agrtl_offline}"
DB_PASSWORD="${DB_PASSWORD:-root123}"
DB_APP_USER="${DB_APP_USER:-app}"
DB_APP_PASSWORD="${DB_APP_PASSWORD:-app123}"
DB_PORT_HOST="${DB_PORT_HOST:-3308}"
READY_CHECK_ATTEMPTS="${READY_CHECK_ATTEMPTS:-300}"

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker is not installed or not in PATH."
  exit 1
fi

echo "Starting full offline setup..."
echo "Project root: $PROJECT_ROOT"
echo "Compose file: $COMPOSE_FILE"
echo "DB setup mode: $DB_SETUP_MODE"

cd "$PROJECT_ROOT"

APP_ZIP_URL="$APP_ZIP_URL" \
APP_VERSION_URL="$APP_VERSION_URL" \
APP_SYNC_ZIP_ON_START="$APP_SYNC_ZIP_ON_START" \
DB_SETUP_MODE="$DB_SETUP_MODE" \
DB_DATABASE="$DB_DATABASE" \
DB_PASSWORD="$DB_PASSWORD" \
DB_APP_USER="$DB_APP_USER" \
DB_APP_PASSWORD="$DB_APP_PASSWORD" \
DB_PORT_HOST="$DB_PORT_HOST" \
docker compose -f "$COMPOSE_FILE" up -d --build

echo "Applying post-setup Laravel maintenance..."
maintenance_ok=0
for i in {1..180}; do
  if docker compose -f "$COMPOSE_FILE" exec -T -u root app sh -lc '
cd /var/www/html

if [ ! -f artisan ]; then
  echo "artisan not found yet; waiting for app bootstrap..."
  exit 1
fi

if [ -f .env ]; then
    if grep -q "^POS_OFFLINE_MODE=" .env; then
      sed -i "s|^POS_OFFLINE_MODE=.*|POS_OFFLINE_MODE=true|" .env
  else
      echo "POS_OFFLINE_MODE=true" >> .env
  fi
fi

mkdir -p storage/framework/sessions \
         storage/framework/views \
         storage/framework/cache/data \
         storage/logs \
         bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache
chmod -R ug+rwX storage bootstrap/cache
chmod -R 777 storage

if grep -q "^APP_KEY=$" .env 2>/dev/null || ! grep -q "^APP_KEY=" .env 2>/dev/null; then
  _key="base64:$(php -r "echo base64_encode(random_bytes(32));" 2>/dev/null)"
  if [ -n "$_key" ] && [ "$_key" != "base64:" ]; then
    if grep -q "^APP_KEY=" .env; then
      sed -i "s|^APP_KEY=.*|APP_KEY=${_key}|" .env
    else
      printf '\nAPP_KEY=%s\n' "$_key" >> .env
    fi
  fi
fi

php artisan optimize:clear
php artisan migrate --path=database/offline_migrations --force --no-interaction || true
'; then
    maintenance_ok=1
    echo "Post-setup Laravel maintenance completed."
    break
  fi
  sleep 2
done

if [[ "$maintenance_ok" -ne 1 ]]; then
  echo "Warning: post-setup Laravel maintenance could not be completed yet."
fi

echo "Syncing .env.offline values into app .env..."
sync_offline_env_into_app_env

echo "Waiting for app endpoint to become ready..."
for ((i=1; i<=READY_CHECK_ATTEMPTS; i++)); do
  status_code="$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/login || true)"
  if [[ "$status_code" == "200" || "$status_code" == "302" ]]; then
    echo "Ensuring encryption key is set..."
    docker compose -f "$COMPOSE_FILE" exec -T app php -r \
      "\$e=file_get_contents('/var/www/html/.env');if(preg_match('/^APP_KEY=\S/m',\$e))exit;\$k='base64:'.base64_encode(random_bytes(32));\$e=preg_match('/^APP_KEY=/m',\$e)?preg_replace('/^APP_KEY=.*/m','APP_KEY='.\$k,\$e):\$e.chr(10).'APP_KEY='.\$k;file_put_contents('/var/www/html/.env',\$e);" \
      >/dev/null 2>&1 || true
    echo "Setup complete. App is reachable at http://localhost:8080/login (HTTP $status_code)."
    echo "Tip: code sync runs once on first startup and skips on container restarts by default."
    echo "To force sync every start, run with APP_SYNC_ZIP_ON_START=always."
    exit 0
  fi
  sleep 2
done

echo "Setup finished, but app is not ready yet."
echo "Run: docker compose -f $COMPOSE_FILE logs --tail=200 app web"
exit 1
