#!/usr/bin/env bash
set -euo pipefail

# Runs delta inventory sync via Laravel artisan command.
# Usage:
#   ./scripts/offline/sync-inventory-delta.sh [store_id] [since]
# Example:
#   ./scripts/offline/sync-inventory-delta.sh 123 "2026-05-13 00:00:00"
# Values are loaded from .env.offline by default.

STORE_ID_INPUT="${1:-}"
SINCE_INPUT="${2:-}"

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
OFFLINE_STORE_ID="${STORE_ID_INPUT:-${OFFLINE_STORE_ID:-}}"
OFFLINE_TOKEN="${OFFLINE_TOKEN:-}"
OFFLINE_API_BASE_URL="${OFFLINE_API_BASE_URL:-}"
APP_VERSION_URL="${APP_VERSION_URL:-}"
OFFLINE_INVENTORY_SINCE="${SINCE_INPUT:-${OFFLINE_INVENTORY_SINCE:-}}"

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
  echo "Error: store_id and token are required."
  echo "Provide store_id as argument or set OFFLINE_STORE_ID and OFFLINE_TOKEN in $OFFLINE_ENV_FILE."
  exit 1
fi

if [[ -z "$OFFLINE_API_BASE_URL" ]]; then
  echo "Error: OFFLINE_API_BASE_URL is required."
  echo "Set OFFLINE_API_BASE_URL (or POS_OFFLINE_SYNC_SOURCE_URL) in $OFFLINE_ENV_FILE."
  exit 1
fi

if [[ -z "$OFFLINE_INVENTORY_SINCE" ]]; then
  echo "Error: since timestamp is required for delta sync."
  echo "Pass it as second argument or set OFFLINE_INVENTORY_SINCE in $OFFLINE_ENV_FILE."
  exit 1
fi

cd "$PROJECT_ROOT"

echo "Running offline:sync-inventory delta for store_id=$OFFLINE_STORE_ID since=$OFFLINE_INVENTORY_SINCE"
docker compose -f "$COMPOSE_FILE" exec -T \
  -e OFFLINE_STORE_ID="$OFFLINE_STORE_ID" \
  -e OFFLINE_TOKEN="$OFFLINE_TOKEN" \
  -e OFFLINE_API_BASE_URL="$OFFLINE_API_BASE_URL" \
  -e OFFLINE_INVENTORY_SINCE="$OFFLINE_INVENTORY_SINCE" \
  app sh -lc '
cd /var/www/html
if [ ! -f artisan ]; then
  echo "Error: artisan not found in /var/www/html"
  exit 1
fi

mkdir -p storage/framework/sessions \
         storage/framework/views \
         storage/framework/cache/data \
         storage/logs \
         bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache || true
chmod -R ug+rwX storage bootstrap/cache

php artisan offline:sync-inventory "$OFFLINE_STORE_ID" --delta=1 --since="$OFFLINE_INVENTORY_SINCE" --base-url="$OFFLINE_API_BASE_URL" --token="$OFFLINE_TOKEN"
'

echo "offline:sync-inventory (delta) completed."
