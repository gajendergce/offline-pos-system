#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/offline/setup-from-github.sh <zip_url> [target_dir]
# Example:
#   ./scripts/offline/setup-from-github.sh https://example.com/offline-pos-system.zip /opt/offlinepos

ZIP_URL="${1:-}"
TARGET_DIR="${2:-./offlinepos}"

if [[ -z "$ZIP_URL" ]]; then
  echo "Usage: $0 <zip_url> [target_dir]"
  exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "Downloading ZIP from $ZIP_URL ..."
curl -fsSL "$ZIP_URL" -o "$TMP_DIR/source.zip"
unzip -q "$TMP_DIR/source.zip" -d "$TMP_DIR/unpacked"

SOURCE_DIR="$(find "$TMP_DIR/unpacked" -mindepth 1 -maxdepth 1 -type d | head -n 1)"
if [[ -z "$SOURCE_DIR" ]]; then
  echo "Error: ZIP file did not contain a valid project folder."
  exit 1
fi

mkdir -p "$TARGET_DIR"
find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
cp -a "$SOURCE_DIR"/. "$TARGET_DIR"/

echo "Starting Docker stack..."
docker compose -f "$TARGET_DIR/docker-compose.offline.yml" up -d --build

echo "Done. App should be available at http://localhost:8080"
