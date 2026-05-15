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

if [[ -z "$OFFLINE_INVENTORY_SINCE" ]]; then
  # Default to one hour back; support both BSD date (macOS) and GNU date.
  OFFLINE_INVENTORY_SINCE="$(date -u -v-1H '+%Y-%m-%d %H:%M:%S' 2>/dev/null || date -u -d '1 hour ago' '+%Y-%m-%d %H:%M:%S')"
fi

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

cd "$PROJECT_ROOT"

echo "Running offline:sync-inventory delta for store_id=$OFFLINE_STORE_ID since=$OFFLINE_INVENTORY_SINCE"
docker compose -f "$COMPOSE_FILE" exec -T \
  -e OFFLINE_STORE_ID="$OFFLINE_STORE_ID" \
  -e OFFLINE_TOKEN="$OFFLINE_TOKEN" \
  -e OFFLINE_API_BASE_URL="$OFFLINE_API_BASE_URL" \
  -e OFFLINE_INVENTORY_SINCE="$OFFLINE_INVENTORY_SINCE" \
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

set_kv() {
  key="$1"; val="$2"
  [ -z "$val" ] && return 0
  case "$key" in OFFLINE_API_BASE_URL|POS_OFFLINE_SYNC_SOURCE_URL)
    val="${val%/}/" ;;
  esac
  grep -v "^${key}=" .env > /tmp/.env_kv_tmp 2>/dev/null || true
  echo "${key}=${val}" >> /tmp/.env_kv_tmp
  cp /tmp/.env_kv_tmp .env
}
set_kv OFFLINE_API_BASE_URL "$OFFLINE_API_BASE_URL"
set_kv OFFLINE_TOKEN "$OFFLINE_TOKEN"
set_kv OFFLINE_STORE_ID "$OFFLINE_STORE_ID"
set_kv POS_OFFLINE_SYNC_SOURCE_URL "$OFFLINE_API_BASE_URL"
set_kv POS_OFFLINE_SYNC_TOKEN "$OFFLINE_TOKEN"
set_kv POS_OFFLINE_SYNC_STORE_ID "$OFFLINE_STORE_ID"

php artisan config:clear 2>/dev/null || true

php artisan offline:sync-inventory "$OFFLINE_STORE_ID" --delta=1 --since="$OFFLINE_INVENTORY_SINCE" 
'

echo "offline:sync-inventory (delta) completed."
