#!/bin/bash
set -euo pipefail

PROJECT_DIR="$(cd "$(dirname "$0")" && pwd)"

cd "$PROJECT_DIR"

"$PROJECT_DIR/scripts/offline/setup-full-offline.sh"

echo
echo "Setup finished. Open: http://localhost:8080/login"
echo "Press Enter to close this window..."
read -r
