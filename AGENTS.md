# AGENTS.md

Operational guidance for AI coding agents in this repository.

## Project Snapshot

- Purpose: Docker scaffold that boots an offline Laravel POS stack where app source is pulled from a ZIP URL at container startup.
- Primary compose file: `docker-compose.github.yml`.
- Main services: `web` (Apache), `app` (PHP-FPM bootstrap), `queue`, `scheduler`, `db` (MySQL 5.7).

## First Commands To Run

From repository root:

```bash
docker compose -f docker-compose.github.yml ps
docker compose -f docker-compose.github.yml logs --tail=200 app
docker compose -f docker-compose.github.yml logs --tail=200 web
```

Bring stack up (example):

```bash
APP_ZIP_URL=https://example.com/your-laravel-app.zip \
DB_DATABASE=agrtl_offline \
DB_PASSWORD=root123 \
DB_APP_USER=app \
DB_APP_PASSWORD=app123 \
DB_PORT_HOST=3310 \
docker compose -f docker-compose.github.yml up -d --build
```

Manual migration fallback:

```bash
docker compose -f docker-compose.github.yml exec -T app sh -lc "php artisan migrate --force"
```

## Where Behavior Lives

- Startup/bootstrap logic: `docker/offline/php/start-app.sh`
- Runtime PHP image: `docker/offline/php/Dockerfile.runtime`
- Web proxy config: `docker/offline/apache/httpd-app.conf`
- Orchestration and env wiring: `docker-compose.github.yml`
- One-command local bootstrap: `scripts/offline/setup-full-offline.sh`

## Important Conventions

- Treat `docker-compose.github.yml` as the default compose entrypoint for this repo.
- App code is expected to come from `APP_ZIP_URL`; ZIP must contain a Laravel root (`artisan` and `composer.json`).
- `APP_SYNC_ZIP_ON_START=1` means app source is refreshed from ZIP on each startup.
- `storage/` is preserved via volume during code refresh; most other app files are replaced.
- Queue and scheduler intentionally wait for `vendor/autoload.php` before running.
- `.env` is created from `.env.example` if missing, then DB values are written by startup script.
- Local HTTP is expected on `:8080`; forced HTTPS in Laravel app service provider is disabled by startup script.

## Safety And Pitfalls

- Do not run destructive Docker cleanup (`down -v`) unless explicitly requested.
- Changing DB env defaults in compose impacts both app and read-replica env keys; keep them in sync.
- If app is unreachable, inspect `app` logs first, then `web` logs.
- If ZIP download fails, verify URL reachability from container context and ZIP structure.

## Testing And Validation

- No automated test suite is present in this repository.
- Validate changes by:
  1. `docker compose -f docker-compose.github.yml config`
  2. `docker compose -f docker-compose.github.yml up -d --build`
  3. `docker compose -f docker-compose.github.yml ps`
  4. Checking `http://localhost:8080` (or `/login`) and relevant logs.

## Documentation Links (Source Of Truth)

- Primary runbook: [README.md](README.md)
- Deployment details and sync design: [Offline_POS_Deployment_Steps.md](Offline_POS_Deployment_Steps.md)
- Iteration scope and entity sync map: [First_Iteration_Scope.md](First_Iteration_Scope.md)
