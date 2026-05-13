#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_ZIP_URL="http://taxnomist.busywizzy.com/pos_1.0.zip"
DEFAULT_VERSION_URL=""
DEFAULT_TARGET_VERSION=""

APP_VERSION_URL="${APP_VERSION_URL:-$DEFAULT_VERSION_URL}"
APP_TARGET_VERSION="${APP_TARGET_VERSION:-$DEFAULT_TARGET_VERSION}"

cd "$PROJECT_DIR"

APP_SYNC_ZIP_ON_START=1 \
APP_VERSION_URL="$APP_VERSION_URL" \
APP_TARGET_VERSION="$APP_TARGET_VERSION" \
"$PROJECT_DIR/scripts/offline/setup-full-offline.sh" "$DEFAULT_ZIP_URL"

echo
echo "Setup finished. Open: http://localhost:8080/login"
echo "Tip: ZIP sync runs once on first startup and skips on restart."
echo "Tip: if APP_VERSION_URL is configured, ZIP sync happens only when API version changes."
echo "To force sync every start, run with APP_SYNC_ZIP_ON_START=always."
read -r -p "Press Enter to close this window..." _
