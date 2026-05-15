#!/usr/bin/env bash
set -euo pipefail

# Runs users+security data sync via Laravel artisan command.
# Values are loaded from .env.offline by default.

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
OFFLINE_STORE_ID="${OFFLINE_STORE_ID:-}"
OFFLINE_TOKEN="${OFFLINE_TOKEN:-}"
OFFLINE_API_BASE_URL="${OFFLINE_API_BASE_URL:-}"
APP_VERSION_URL="${APP_VERSION_URL:-}"

if [[ -z "$OFFLINE_API_BASE_URL" ]]; then
  OFFLINE_API_BASE_URL="${POS_OFFLINE_SYNC_SOURCE_URL:-}"
fi

if [[ -z "$OFFLINE_API_BASE_URL" && -n "$APP_VERSION_URL" ]]; then
  OFFLINE_API_BASE_URL="$(printf '%s' "$APP_VERSION_URL" | sed 's#/api/offline/version/?$##')"
fi

if ! command -v docker >/dev/null 2>&1; then
  echo "Error: docker is not installed or not in PATH."
  exit 1
fi

if [[ -z "$OFFLINE_STORE_ID" || -z "$OFFLINE_TOKEN" ]]; then
  echo "Error: OFFLINE_STORE_ID and OFFLINE_TOKEN are required."
  echo "Set them in $OFFLINE_ENV_FILE or export before running this script."
  exit 1
fi

if [[ -z "$OFFLINE_API_BASE_URL" ]]; then
  echo "Error: OFFLINE_API_BASE_URL is required."
  echo "Set OFFLINE_API_BASE_URL (or POS_OFFLINE_SYNC_SOURCE_URL) in $OFFLINE_ENV_FILE."
  exit 1
fi

cd "$PROJECT_ROOT"

echo "Running offline:sync-users-security using values from $OFFLINE_ENV_FILE"
docker compose -f "$COMPOSE_FILE" exec -T \
  -e OFFLINE_STORE_ID="$OFFLINE_STORE_ID" \
  -e OFFLINE_TOKEN="$OFFLINE_TOKEN" \
  -e OFFLINE_API_BASE_URL="$OFFLINE_API_BASE_URL" \
  app sh -lc '
APP_ROOT="/var/www/html"
if [ -f /var/www/html/pos/artisan ]; then
  APP_ROOT="/var/www/html/pos"
fi

cd "$APP_ROOT"
if [ ! -f artisan ]; then
  echo "Error: artisan not found in $APP_ROOT"
  exit 1
fi

php artisan offline:sync-users-security "$OFFLINE_STORE_ID" --token="$OFFLINE_TOKEN" --base-url="$OFFLINE_API_BASE_URL"
'

echo "offline:sync-users-security completed."
