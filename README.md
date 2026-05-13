# Offline POS Docker Setup (ZIP URL Laravel Source)

This setup runs a Laravel app in Docker, where application code is downloaded from a ZIP URL during container startup.

## What This Stack Runs

- `web` (Apache) on `http://localhost:8080`
- `app` (PHP-FPM + Laravel bootstrap)
- `queue` (Laravel queue worker)
- `scheduler` (Laravel scheduler loop)
- `db` (MySQL 5.7)

## Prerequisites

Install on the new computer:

1. Docker Desktop (running)
2. curl + unzip (usually preinstalled on macOS/Linux)

## Clone This Scaffold

```bash
git clone <this-repo-url>
cd offline-pos-docker
```

## Configure Offline Sync Credentials

Before first setup, configure [.env.offline](.env.offline):

- `OFFLINE_STORE_ID`
- `OFFLINE_TOKEN`
- `APP_VERSION_URL`
- `APP_ZIP_URL`

You can update this file any time and re-run daily sync.

## Required Environment Values

You pass these values in the startup command:

- `APP_ZIP_URL`: ZIP URL of Laravel application source
- `DB_DATABASE`: MySQL database name
- `DB_PASSWORD`: MySQL root password
- `DB_APP_USER`: app DB user
- `DB_APP_PASSWORD`: app DB password
- `DB_PORT_HOST`: host port mapped to MySQL container 3306

## First-Time Start

Run from this folder:

```bash
APP_ZIP_URL=https://example.com/your-laravel-app.zip \
DB_DATABASE=agrtl_offline \
DB_PASSWORD=root123 \
DB_APP_USER=app \
DB_APP_PASSWORD=app123 \
DB_PORT_HOST=3310 \
docker compose -f docker-compose.github.yml up -d --build
```

What this does:

1. Builds Docker images.
2. Starts containers.
3. Downloads and extracts Laravel code from ZIP inside the app container.
4. Syncs `DB_*` and `DB_READ_*` values into Laravel `.env`.
5. Runs `composer install` automatically (for projects where `vendor/` is not included in ZIP).
6. Runs `php artisan migrate --force` automatically (with retries while DB becomes ready).
7. Starts web/app/queue/scheduler/db.

## Verify Setup

```bash
docker compose -f docker-compose.github.yml ps
```

Open:

- `http://localhost:8080`

## One-Click Launchers

Repository root includes launchers for each OS with default ZIP URL:

- macOS: `Setup_Offline_POS.command` or `Setup_Offline_POS.app`
- Ubuntu/Linux: `Setup_Offline_POS_Ubuntu.sh` (or desktop shortcut `Setup_Offline_POS_Ubuntu.desktop`)
- Windows: `Setup_Offline_POS_Windows.bat`

Behavior for all launchers:

- `APP_SYNC_ZIP_ON_START=1` (sync once on first startup, skip on restart)
- Default DB values are pre-filled (same as script defaults)
- Ubuntu/Windows launchers can pass `APP_VERSION_URL` / `APP_TARGET_VERSION` for API-version sync (edit launcher defaults or set env before launch)

Ubuntu first use:

```bash
chmod +x Setup_Offline_POS_Ubuntu.sh
chmod +x Setup_Offline_POS_Ubuntu.desktop
```

## Version-Based Code Sync (API Driven)

By default, first-time setup pulls code from ZIP and then skips re-sync on container restarts.

Use API-version sync through the daily script (cron), not normal startup.

Version source:

- `APP_VERSION_URL` default: `https://agretail.ddev.site/api/offline/version`

Inputs supported by daily sync script:

- `APP_VERSION_URL`: HTTP endpoint called with GET + JSON body (`store_id`, `offline_token`)
- `APP_TARGET_VERSION`: explicit version value passed from caller
- `APP_ZIP_URL`: supports `APP_VERSION` placeholder (example: `https://taxnomist.busywizzy.com/pos_APP_VERSION.zip`)

Behavior:

- If target version differs from local stored version, app ZIP is downloaded and synced.
- If version matches, ZIP sync is skipped.
- Version value is stored in `/var/www/html/.zip_sync_version`.

Example:

```bash
APP_VERSION_URL=https://agretail.ddev.site/api/offline/version \
APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_APP_VERSION.zip \
./scripts/offline/sync-daily.sh
```

API request format used by sync script:

```bash
curl --location --request GET 'https://agretail.ddev.site/api/offline/version' \
--header 'Content-Type: application/json' \
--data '{"store_id":100,"offline_token":"<token>"}'
```

## Daily Sync Script (Run Once Per Day)

Use this when you want:

- First-time setup from your original ZIP URL
- Future syncs via API version check in a separate scheduled script

Script:

- `scripts/offline/sync-daily.sh`

Run manually:

```bash
APP_VERSION_URL=https://agretail.ddev.site/api/offline/version \
APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_APP_VERSION.zip \
./scripts/offline/sync-daily.sh
```

What it does:

- Reads target version from `APP_VERSION_URL` (or `APP_TARGET_VERSION`)
- Compares with current local version from `/var/www/html/.zip_sync_version`
- If version changed, recreates `app queue scheduler` and syncs ZIP using existing download approach
- If version same, exits without changes

Cron example (daily at 2:00 AM):

```bash
0 2 * * * cd /path/to/offline-pos-docker && APP_VERSION_URL=https://agretail.ddev.site/api/offline/version APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_APP_VERSION.zip ./scripts/offline/sync-daily.sh >> /var/log/offline-pos-sync.log 2>&1
```

## Migrations

Migrations are run automatically during `app` container startup.

If you still need to run them manually:

```bash
docker compose -f docker-compose.github.yml exec -T app sh -lc "php artisan migrate --force"
```

## Offline Mode Env Flag

Setup/startup/sync scripts now ensure `POS_OFFLINE_MODE=true` in app `.env`.

## Useful Commands

Rebuild and restart:

```bash
docker compose -f docker-compose.github.yml up -d --build
```

View app logs:

```bash
docker compose -f docker-compose.github.yml logs --tail=200 app
```

View web logs:

```bash
docker compose -f docker-compose.github.yml logs --tail=200 web
```

Stop stack:

```bash
docker compose -f docker-compose.github.yml down
```

Stop and remove volumes (data reset):

```bash
docker compose -f docker-compose.github.yml down -v
```

## Troubleshooting

### 1) MySQL port already in use

Change `DB_PORT_HOST` (example: `3311`) in startup command.

### 2) ZIP download failure

- Ensure `APP_ZIP_URL` is reachable from your machine/container.
- Ensure ZIP contains a Laravel root with `artisan` and `composer.json`.

### 3) SQL access denied

- Ensure you pass both app DB values:
  - `DB_APP_USER=app`
  - `DB_APP_PASSWORD=app123`
- Re-run with `--build`.

### 4) HTTP 500 from Laravel

Inspect logs:

```bash
docker compose -f docker-compose.github.yml logs --tail=300 app
```

## Note on Dependencies

`vendor/` is intentionally not required in the ZIP package. The `app` container runs `composer install` during startup.
