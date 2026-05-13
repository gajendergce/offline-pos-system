#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"
DEFAULT_ZIP_URL="http://taxnomist.busywizzy.com/pos_1.0.zip"

cd "$PROJECT_DIR"

"$PROJECT_DIR/scripts/offline/setup-full-offline.sh" "$DEFAULT_ZIP_URL"

echo
echo "Setup finished. Open: http://localhost:8080/login"
echo "Press Enter to close this window..."
read -r
