#!/usr/bin/env bash
set -euo pipefail

# Daily sync script for ZIP-based Laravel source.
# This script is intended to be run by cron/task scheduler once per day.
# It syncs only when target version changes.

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"

OFFLINE_ENV_FILE="${OFFLINE_ENV_FILE:-$PROJECT_ROOT/.env.offline}"
if [[ -f "$OFFLINE_ENV_FILE" ]]; then
  set -a
  # shellcheck disable=SC1090
  source "$OFFLINE_ENV_FILE"
  set +a
fi

COMPOSE_FILE="${COMPOSE_FILE:-$PROJECT_ROOT/docker-compose.github.yml}"
APP_ZIP_URL="${APP_ZIP_URL:-https://taxnomist.busywizzy.com/pos_APP_VERSION.zip}"
APP_VERSION_URL="${APP_VERSION_URL:-https://agretail.ddev.site/api/offline/version}"
APP_TARGET_VERSION="${APP_TARGET_VERSION:-}"
OFFLINE_STORE_ID="${OFFLINE_STORE_ID:-}"
OFFLINE_TOKEN="${OFFLINE_TOKEN:-}"
SYNC_SERVICES="${SYNC_SERVICES:-app queue scheduler}"
READY_CHECK_ATTEMPTS="${READY_CHECK_ATTEMPTS:-300}"

usage() {
  echo "Usage: APP_VERSION_URL=<url> [APP_ZIP_URL=<zip>] $0"
  echo "   or: APP_TARGET_VERSION=<version> [APP_ZIP_URL=<zip>] $0"
  echo "Config can be stored in .env.offline (OFFLINE_STORE_ID, OFFLINE_TOKEN, APP_VERSION_URL, APP_ZIP_URL)."
}

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker is not installed or not in PATH."
  exit 1
fi

if [[ -z "$APP_TARGET_VERSION" && -z "$APP_VERSION_URL" ]]; then
  echo "Error: APP_VERSION_URL or APP_TARGET_VERSION is required."
  usage
  exit 1
fi

fetch_target_version() {
  if [[ -n "$APP_TARGET_VERSION" ]]; then
    printf "%s" "$APP_TARGET_VERSION"
    return 0
  fi

  if [[ -z "$OFFLINE_STORE_ID" || -z "$OFFLINE_TOKEN" ]]; then
    echo "Error: OFFLINE_STORE_ID and OFFLINE_TOKEN are required for API version fetch." >&2
    return 1
  fi

  payload="$(printf '{"store_id": %s, "offline_token":"%s"}' "$OFFLINE_STORE_ID" "$OFFLINE_TOKEN")"

  response="$(curl -fsSL --request GET "$APP_VERSION_URL" --header 'Content-Type: application/json' --data "$payload" || true)"
  if [[ -z "$response" ]]; then
    return 1
  fi

  compact="$(printf "%s" "$response" | tr -d '\r\n')"
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

cd "$PROJECT_ROOT"

new_version="$(fetch_target_version || true)"
if [[ -z "$new_version" ]]; then
  echo "Error: could not resolve target version from APP_VERSION_URL/APP_TARGET_VERSION."
  exit 1
fi

new_version="$(printf "%s" "$new_version" | tr -d '\r\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
echo "New version from API/input: $new_version"

old_version="$(docker compose -f "$COMPOSE_FILE" exec -T app sh -lc 'cat /var/www/html/.zip_sync_version 2>/dev/null || true' || true)"
old_version="$(printf "%s" "$old_version" | tr -d '\r\n' | sed 's/^[[:space:]]*//; s/[[:space:]]*$//')"
echo "Old version from local marker: ${old_version:-none}"

if [[ -n "$old_version" && "$old_version" == "$new_version" ]]; then
  echo "Version matches. No code pull needed."
  exit 0
fi

echo "Version mismatch (${old_version:-none} -> $new_version). Forcing full code sync from ZIP..."

resolved_zip_url="$APP_ZIP_URL"
if [[ "$resolved_zip_url" == *APP_VERSION* ]]; then
  resolved_zip_url="${resolved_zip_url//APP_VERSION/$new_version}"
fi

echo "Using ZIP URL: $resolved_zip_url"

APP_ZIP_URL="$resolved_zip_url" \
APP_TARGET_VERSION="$new_version" \
APP_SYNC_ZIP_ON_START=always \
APP_ENABLE_VERSION_SYNC_ON_START=0 \
docker compose -f "$COMPOSE_FILE" up -d --build --force-recreate $SYNC_SERVICES

echo "Applying post-sync Laravel maintenance..."
maintenance_ok=0
for i in {1..180}; do
  if docker compose -f "$COMPOSE_FILE" exec -T app sh <<'APP_MAINTENANCE'; then
cd /var/www/html

if [ ! -f artisan ]; then
  echo "artisan not found yet; waiting for app bootstrap..."
  exit 1
fi

if [ ! -f vendor/autoload.php ]; then
  echo "vendor/autoload.php not found yet; waiting for composer install..."
  exit 1
fi

if [ -f .env ]; then
  if grep -q '^POS_OFFLINE_MODE=' .env; then
    sed -i 's|^POS_OFFLINE_MODE=.*|POS_OFFLINE_MODE=true|' .env
  else
    echo 'POS_OFFLINE_MODE=true' >> .env
  fi
fi

mkdir -p storage/framework/sessions \
         storage/framework/views \
         storage/framework/cache/data \
         storage/logs \
         bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache
chmod -R ug+rwX storage bootstrap/cache

php artisan optimize:clear
APP_MAINTENANCE
    maintenance_ok=1
    echo "Post-sync Laravel maintenance completed."
    break
  fi
  sleep 2
done

if [[ "${maintenance_ok:-0}" -ne 1 ]]; then
  echo "Warning: post-sync Laravel maintenance could not be completed yet."
fi

docker compose -f "$COMPOSE_FILE" exec -T app sh -lc "
cd /var/www/html
if [ -f .env ]; then
  if grep -q '^POS_OFFLINE_BUNDLE_APP_VERSION=' .env; then
    sed -i 's|^POS_OFFLINE_BUNDLE_APP_VERSION=.*|POS_OFFLINE_BUNDLE_APP_VERSION=${new_version}|' .env
  else
    echo 'POS_OFFLINE_BUNDLE_APP_VERSION=${new_version}' >> .env
  fi
fi
printf '%s' '${new_version}' > .zip_sync_version
"
echo "Stamped synced version (${new_version}) into .env and .zip_sync_version"

echo "Waiting for app endpoint to become ready..."
for ((i=1; i<=READY_CHECK_ATTEMPTS; i++)); do
  status_code="$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/login || true)"
  if [[ "$status_code" == "200" || "$status_code" == "302" ]]; then
    echo "Daily sync complete. App is reachable at http://localhost:8080/login (HTTP $status_code)."
    exit 0
  fi
  sleep 2
done

echo "Sync finished, but app is not ready yet."
echo "Run: docker compose -f $COMPOSE_FILE logs --tail=200 app web"
exit 1
