#!/usr/bin/env bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$PROJECT_DIR"

"$PROJECT_DIR/scripts/offline/setup-full-offline.sh"

echo
echo "Setup finished. Open: http://localhost:8080/login"
echo "Tip: ZIP sync runs once on first startup and skips on restart."
echo "Tip: if APP_VERSION_URL is configured, ZIP sync happens only when API version changes."
echo "To force sync every start, run with APP_SYNC_ZIP_ON_START=always."
read -r -p "Press Enter to close this window..." _
