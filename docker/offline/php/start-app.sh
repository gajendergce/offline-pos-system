#!/usr/bin/env sh
set -eu

APP_ZIP_URL="${APP_ZIP_URL:-}"
APP_SYNC_ZIP_ON_START="${APP_SYNC_ZIP_ON_START:-1}"
SYNC_MARKER_FILE="${APP_SYNC_MARKER_FILE:-/var/www/html/.zip_sync_done}"
APP_VERSION_URL="${APP_VERSION_URL:-}"
APP_TARGET_VERSION="${APP_TARGET_VERSION:-}"
VERSION_MARKER_FILE="${APP_VERSION_MARKER_FILE:-/var/www/html/.zip_sync_version}"
APP_ENABLE_VERSION_SYNC_ON_START="${APP_ENABLE_VERSION_SYNC_ON_START:-0}"
DB_SETUP_MODE="${DB_SETUP_MODE:-structure}"

cd /var/www/html
if [ -z "$APP_ZIP_URL" ]; then
  if [ ! -f artisan ]; then
    echo "APP_ZIP_URL is required for first startup when app code is missing"
    exit 1
  fi
  echo "APP_ZIP_URL not provided; using existing app code in volume."
fi

download_and_extract_zip() {
  _dl_url="${1:-$APP_ZIP_URL}"
  tmp_dir="$(mktemp -d)"
  zip_file="${tmp_dir}/app.zip"

  echo "Downloading Laravel ZIP from ${_dl_url}..."
  if ! curl -fsSL "$_dl_url" -o "$zip_file"; then
    echo "Failed to download ZIP from ${_dl_url}"
    rm -rf "$tmp_dir"
    exit 1
  fi

  unzip -q "$zip_file" -d "$tmp_dir/unpacked"

  src_dir="$(find "$tmp_dir/unpacked" -type f -name artisan -exec dirname {} \; | head -n 1)"
  if [ -z "$src_dir" ]; then
    src_dir="$(find "$tmp_dir/unpacked" -type f -name composer.json -exec dirname {} \; | head -n 1)"
  fi

  if [ -z "$src_dir" ]; then
    echo "ZIP does not contain a Laravel application root (artisan/composer.json not found)."
    rm -rf "$tmp_dir"
    exit 1
  fi

  # Keep mounted storage volume intact while replacing application source.
  find /var/www/html -mindepth 1 -maxdepth 1 ! -name storage -exec rm -rf {} +
  cp -a "$src_dir"/. /var/www/html/
  rm -rf "$tmp_dir"
}

fetch_target_version() {
  if [ -n "$APP_TARGET_VERSION" ]; then
    printf "%s" "$APP_TARGET_VERSION"
    return 0
  fi

  if [ -z "$APP_VERSION_URL" ]; then
    return 0
  fi

  response="$(curl -fsSL "$APP_VERSION_URL" || true)"
  if [ -z "$response" ]; then
    return 0
  fi

  compact="$(printf "%s" "$response" | tr -d '\r\n')"
  parsed="$(printf "%s" "$compact" | sed -n 's/.*"POS_OFFLINE_BUNDLE_APP_VERSION"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"

  if [ -z "$parsed" ]; then
    parsed="$(printf "%s" "$compact" | sed -n 's/.*"version"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p')"
  fi

  if [ -n "$parsed" ]; then
    printf "%s" "$parsed"
  else
    printf "%s" "$compact" | sed 's/^[[:space:]]*//; s/[[:space:]]*$//'
  fi
}

sync_from_version_if_needed() {
  target_version="$(fetch_target_version)"
  if [ -z "$target_version" ]; then
    return 1
  fi

  current_version=""
  if [ -f "$VERSION_MARKER_FILE" ]; then
    current_version="$(cat "$VERSION_MARKER_FILE" || true)"
  fi

  if [ "$target_version" = "$current_version" ] && [ -f artisan ]; then
    echo "App version ${target_version} already synced; skipping ZIP sync."
    return 0
  fi

  if [ -z "$APP_ZIP_URL" ]; then
    echo "APP_ZIP_URL is required to sync code for target version ${target_version}."
    exit 1
  fi

  _versioned_url="$(printf '%s' "$APP_ZIP_URL" | sed "s/APP_VERSION/${target_version}/g")"
  echo "Target app version ${target_version} differs from local version; syncing ZIP."
  download_and_extract_zip "$_versioned_url"
  printf "%s" "$target_version" > "$VERSION_MARKER_FILE"
  touch "$SYNC_MARKER_FILE"
  return 0
}

should_sync_zip=0
always_sync_zip=0
case "$APP_SYNC_ZIP_ON_START" in
  1|true|TRUE|yes|YES)
    should_sync_zip=1
    ;;
  always|ALWAYS)
    should_sync_zip=1
    always_sync_zip=1
    ;;
esac

version_sync_on_start=0
case "$APP_ENABLE_VERSION_SYNC_ON_START" in
  1|true|TRUE|yes|YES)
    version_sync_on_start=1
    ;;
esac
# Auto-enable version sync when APP_VERSION_URL is configured.
if [ "$version_sync_on_start" -eq 0 ] && [ -n "$APP_VERSION_URL" ]; then
  version_sync_on_start=1
fi

_zip_has_placeholder=0
case "$APP_ZIP_URL" in
  *APP_VERSION*) _zip_has_placeholder=1 ;;
esac

if [ "$version_sync_on_start" -eq 1 ] && ! sync_from_version_if_needed; then
  # Version API failed to return a version.
  # Skip download if URL still contains unresolved APP_VERSION placeholder.
  if [ "$_zip_has_placeholder" -eq 0 ] && [ -n "$APP_ZIP_URL" ] && [ "$should_sync_zip" -eq 1 ]; then
    if [ "$always_sync_zip" -eq 1 ] || [ ! -f "$SYNC_MARKER_FILE" ]; then
      echo "Syncing app code from ZIP."
      download_and_extract_zip
      touch "$SYNC_MARKER_FILE"
    else
      echo "ZIP sync already completed once; skipping re-sync on restart."
    fi
  elif [ ! -f artisan ] && [ "$_zip_has_placeholder" -eq 0 ] && [ -n "$APP_ZIP_URL" ]; then
    download_and_extract_zip
    touch "$SYNC_MARKER_FILE"
  elif [ ! -f artisan ]; then
    echo "Version API unavailable and APP_ZIP_URL contains unresolved APP_VERSION; cannot bootstrap app."
    exit 1
  fi
elif [ "$version_sync_on_start" -eq 0 ]; then
  if [ -n "$APP_ZIP_URL" ] && [ "$should_sync_zip" -eq 1 ]; then
    if [ "$always_sync_zip" -eq 1 ] || [ ! -f "$SYNC_MARKER_FILE" ]; then
      echo "Syncing app code from ZIP."
      download_and_extract_zip
      touch "$SYNC_MARKER_FILE"
    else
      echo "ZIP sync already completed once; skipping re-sync on restart."
    fi
  elif [ ! -f artisan ] && [ -n "$APP_ZIP_URL" ]; then
    download_and_extract_zip
    touch "$SYNC_MARKER_FILE"
  fi
fi

if [ ! -f .env ] && [ -f .env.example ]; then
  cp .env.example .env
fi
# Strip Windows CRLF from .env — a trailing \r on APP_KEY makes Laravel
# treat the key as invalid even though it looks correct.
sed -i 's/\r$//' .env 2>/dev/null || true

# Local docker runs plain HTTP on :8080; prevent app-level forced HTTPS redirects.
if [ -f app/Providers/AppServiceProvider.php ]; then
  sed -i "s#^[[:space:]]*\\\\URL::forceScheme('https');#        // forceScheme disabled for local docker HTTP#" app/Providers/AppServiceProvider.php
fi

set_env_value() {
  key="$1"
  value="$2"
  if grep -q "^${key}=" .env; then
    sed -i "s|^${key}=.*|${key}=${value}|" .env
  else
    echo "${key}=${value}" >> .env
  fi
}

set_env_value "DB_HOST" "${DB_HOST:-db}"
set_env_value "DB_PORT" "${DB_PORT:-3306}"
set_env_value "DB_DATABASE" "${DB_DATABASE:-agrtl_offline}"
set_env_value "DB_USERNAME" "${DB_USERNAME:-app}"
set_env_value "DB_PASSWORD" "${DB_PASSWORD:-app123}"
set_env_value "DB_READ_HOST" "${DB_READ_HOST:-${DB_HOST:-db}}"
set_env_value "DB_READ_PORT" "${DB_READ_PORT:-${DB_PORT:-3306}}"
set_env_value "DB_READ_DATABASE" "${DB_READ_DATABASE:-${DB_DATABASE:-agrtl_offline}}"
set_env_value "DB_READ_USERNAME" "${DB_READ_USERNAME:-${DB_USERNAME:-app}}"
set_env_value "DB_READ_PASSWORD" "${DB_READ_PASSWORD:-${DB_PASSWORD:-app123}}"
set_env_value "POS_OFFLINE_MODE" "${POS_OFFLINE_MODE:-true}"
[ -n "${OFFLINE_API_BASE_URL:-}" ]        && set_env_value "OFFLINE_API_BASE_URL"        "$OFFLINE_API_BASE_URL"
[ -n "${POS_OFFLINE_SYNC_STORE_ID:-}" ]   && set_env_value "POS_OFFLINE_SYNC_STORE_ID"   "$POS_OFFLINE_SYNC_STORE_ID"
[ -n "${POS_OFFLINE_SYNC_SOURCE_URL:-}" ] && set_env_value "POS_OFFLINE_SYNC_SOURCE_URL" "$POS_OFFLINE_SYNC_SOURCE_URL"
[ -n "${POS_OFFLINE_SYNC_TOKEN:-}" ]      && set_env_value "POS_OFFLINE_SYNC_TOKEN"      "$POS_OFFLINE_SYNC_TOKEN"

mkdir -p storage/framework/sessions \
         storage/framework/views \
         storage/framework/cache/data \
         storage/logs \
         bootstrap/cache

# Laravel app references /var/www/html/pos/storage internally; keep dirs in sync.
mkdir -p /var/www/html/pos/storage/framework/sessions \
         /var/www/html/pos/storage/framework/views \
         /var/www/html/pos/storage/framework/cache/data \
         /var/www/html/pos/storage/logs \
         /var/www/html/pos/bootstrap/cache

chown -R www-data:www-data storage bootstrap/cache \
                            /var/www/html/pos/storage /var/www/html/pos/bootstrap/cache
chmod -R 777 storage /var/www/html/pos/storage

# Generate APP_KEY using PHP built-ins before composer install.
# php artisan key:generate cannot be used here because it boots Laravel, which
# throws the same "no key" exception before the generate command can set one.
# random_bytes() and base64_encode() are PHP core — no vendor or artisan needed.
if grep -q "^APP_KEY=$" .env 2>/dev/null || ! grep -q "^APP_KEY=" .env 2>/dev/null; then
  _key="base64:$(php -r 'echo base64_encode(random_bytes(32));' 2>/dev/null)"
  if [ -n "$_key" ] && [ "$_key" != "base64:" ]; then
    if grep -q "^APP_KEY=" .env; then
      sed -i "s|^APP_KEY=.*|APP_KEY=${_key}|" .env
    else
      printf '\nAPP_KEY=%s\n' "$_key" >> .env
    fi
    echo "APP_KEY generated."
  fi
fi

composer install --no-interaction --prefer-dist --optimize-autoloader

# Fallback: artisan key:generate now that vendor/ exists (handles any edge case above).
if grep -q "^APP_KEY=$" .env 2>/dev/null || ! grep -q "^APP_KEY=" .env 2>/dev/null; then
  php artisan key:generate --force --no-interaction
fi

# Replace any amd64 wkhtmltopdf vendor binary with the native system binary.
# Packages like h4cc/wkhtmltopdf-amd64 bundle an x86_64 ELF which crashes on arm64.
WKHTML_SYS="$(command -v wkhtmltopdf 2>/dev/null || true)"
if [ -n "$WKHTML_SYS" ]; then
  find vendor -type f -name 'wkhtmltopdf*' ! -name '*.php' ! -name '*.json' 2>/dev/null | while read -r bin; do
    cp "$WKHTML_SYS" "$bin"
    chmod +x "$bin"
    echo "Replaced vendor wkhtmltopdf binary: $bin"
  done
fi

attempt=1
max_attempts=20
case "$DB_SETUP_MODE" in
  sql|SQL|schema|SCHEMA)
    echo "DB_SETUP_MODE=${DB_SETUP_MODE}; skipping Laravel migrate (expecting DB initialized via SQL files)."
    ;;
  *)
    migrate_cmd="php artisan migrate --force --no-interaction"
    case "$DB_SETUP_MODE" in
      full|FULL|seed|SEED)
        migrate_cmd="php artisan migrate --force --seed --no-interaction"
        ;;
    esac

    until sh -lc "$migrate_cmd"; do
      if [ "$attempt" -ge "$max_attempts" ]; then
        echo "Migration failed after ${max_attempts} attempts."
        exit 1
      fi
      echo "Migration attempt ${attempt}/${max_attempts} failed. Retrying in 3 seconds..."
      attempt=$((attempt + 1))
      sleep 3
    done
    ;;
esac

php artisan config:clear || true
php artisan view:clear || true
php artisan cache:clear || true
php artisan optimize:clear || true

exec php-fpm
