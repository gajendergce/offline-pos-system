#!/usr/bin/env bash
set -euo pipefail

# Usage:
#   ./scripts/offline/setup-laravel-from-github.sh <laravel_zip_url> [target_dir]
# Example:
#   ./scripts/offline/setup-laravel-from-github.sh https://example.com/your-laravel-app.zip ~/projects/your-laravel-app

LARAVEL_ZIP_URL="${1:-}"
TARGET_DIR="${2:-$HOME/projects/laravel-app}"

if [[ -z "$LARAVEL_ZIP_URL" ]]; then
  echo "Usage: $0 <laravel_zip_url> [target_dir]"
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCAFFOLD_ROOT="$(cd "$SCRIPT_DIR/../.." && pwd)"
COMPOSE_FILE="$SCAFFOLD_ROOT/docker-compose.offline.yml"

if [[ ! -f "$COMPOSE_FILE" ]]; then
  echo "Error: compose file not found at $COMPOSE_FILE"
  exit 1
fi

TMP_DIR="$(mktemp -d)"
cleanup() {
  rm -rf "$TMP_DIR"
}
trap cleanup EXIT

echo "Downloading Laravel ZIP from $LARAVEL_ZIP_URL ..."
curl -fsSL "$LARAVEL_ZIP_URL" -o "$TMP_DIR/app.zip"
unzip -q "$TMP_DIR/app.zip" -d "$TMP_DIR/unpacked"

SOURCE_DIR="$(find "$TMP_DIR/unpacked" -type f -name artisan -exec dirname {} \; | head -n 1)"
if [[ -z "$SOURCE_DIR" ]]; then
  SOURCE_DIR="$(find "$TMP_DIR/unpacked" -type f -name composer.json -exec dirname {} \; | head -n 1)"
fi

if [[ -z "$SOURCE_DIR" ]]; then
  echo "Error: ZIP does not contain a Laravel app (artisan/composer.json missing)."
  exit 1
fi

mkdir -p "$TARGET_DIR"
find "$TARGET_DIR" -mindepth 1 -maxdepth 1 -exec rm -rf {} +
cp -a "$SOURCE_DIR"/. "$TARGET_DIR"/

if [[ ! -f "$TARGET_DIR/composer.json" ]]; then
  echo "Error: $TARGET_DIR does not look like a Laravel/PHP project (composer.json missing)."
  exit 1
fi

if [[ ! -d "$TARGET_DIR/public" ]]; then
  echo "Error: $TARGET_DIR/public not found."
  exit 1
fi

if [[ ! -f "$TARGET_DIR/.env.offline" ]]; then
  if [[ -f "$TARGET_DIR/.env" ]]; then
    cp "$TARGET_DIR/.env" "$TARGET_DIR/.env.offline"
    echo "Created $TARGET_DIR/.env.offline from .env"
  elif [[ -f "$TARGET_DIR/.env.example" ]]; then
    cp "$TARGET_DIR/.env.example" "$TARGET_DIR/.env.offline"
    echo "Created $TARGET_DIR/.env.offline from .env.example"
  else
    : > "$TARGET_DIR/.env.offline"
    echo "Created empty $TARGET_DIR/.env.offline"
  fi
fi

echo "Starting Docker stack using local scaffold + Laravel app source..."
BUILD_CONTEXT="$TARGET_DIR" \
NGINX_DOCKERFILE="$SCAFFOLD_ROOT/docker/offline/apache/Dockerfile" \
PHP_DOCKERFILE="$SCAFFOLD_ROOT/docker/offline/php/Dockerfile" \
APP_PUBLIC_DIR="$TARGET_DIR/public" \
APP_ENV_FILE="$TARGET_DIR/.env.offline" \
docker compose -f "$COMPOSE_FILE" up -d --build

echo "Done."
echo "Laravel source: $TARGET_DIR"
echo "App URL: http://localhost:8080"
