# First Time Setup — Offline POS

Step-by-step guide for setting up the Offline POS Docker stack on a brand new computer.

---

## Step 1: Install Prerequisites

Install these on the target computer before anything else:

1. **Docker Desktop** — download from [docker.com](https://www.docker.com/products/docker-desktop/) and make sure it is running (whale icon in the menu bar / system tray).
2. **Git** (only if cloning the repo). On macOS/Linux it is usually preinstalled.
3. **curl** and **unzip** — preinstalled on macOS/Linux; on Windows the launcher uses PowerShell instead.

Verify Docker is working:

```bash
docker --version
docker compose version
```

---

## Step 2: Get the Project Files

Either clone the repository or copy the `offline-pos-system` folder onto the new computer.

```bash
git clone <this-repo-url>
cd offline-pos-system
```

After this you should see [docker-compose.github.yml](docker-compose.github.yml) and the OS launcher files in the project root.

---

## Step 3: Configure Store Credentials

Create a file named `.env.offline` in the project root with values for **this specific store**:

```env
POS_OFFLINE_SYNC_STORE_ID=<store id>
POS_OFFLINE_SYNC_TOKEN=<auth token>
POS_OFFLINE_SYNC_SOURCE_URL=https://<central-server>/public/
POS_OFFLINE_MODE=true
```

| Variable | Purpose |
| --- | --- |
| `POS_OFFLINE_SYNC_STORE_ID` | Store ID assigned by the central system |
| `POS_OFFLINE_SYNC_TOKEN` | Auth token for this store |
| `POS_OFFLINE_SYNC_SOURCE_URL` | Base URL of the central server |
| `POS_OFFLINE_MODE` | Always `true` for offline stores |
| `GIT_REPO_URL` | GitHub repository URL (used by `Pull_Repo_Windows.bat`) |
| `GIT_USERNAME` | GitHub username for private repo access |
| `GIT_TOKEN` | GitHub personal access token (needs `repo` scope) |

> **`APP_VERSION_URL` is derived automatically** from `POS_OFFLINE_SYNC_SOURCE_URL + /api/offline/version` — do not set it manually.
>
> **`APP_ZIP_URL` is returned by the version API** (`POS_OFFLINE_ZIP_URL` in the response) — do not set it manually.

`.env.offline` is listed in `.gitignore` and is never committed to the repository.

---

## Step 4: Run the First-Time Setup

### macOS / Linux

```bash
chmod +x scripts/offline/setup-full-offline.sh
./scripts/offline/setup-full-offline.sh
```

### Windows

Double-click [Setup_Offline_POS_Windows.bat](Setup_Offline_POS_Windows.bat).

If SmartScreen blocks it, click **More info** → **Run anyway**.

---

## Step 5: Watch the First Build

The launcher will:

1. Read `.env.offline`.
2. Derive `APP_VERSION_URL` from `POS_OFFLINE_SYNC_SOURCE_URL`.
3. Call the version API to get the current bundle version (`POS_OFFLINE_BUNDLE_APP_VERSION`) and ZIP URL (`POS_OFFLINE_ZIP_URL`).
4. Run `docker compose -f docker-compose.github.yml up -d --build`.
5. Download Laravel source from the ZIP into the `app` container.
6. Write DB credentials into Laravel `.env`.
7. Run `composer install` (if `vendor/` is missing).
8. Run `php artisan migrate --force` with retries while MySQL boots.
9. Start `web`, `app`, `queue`, `scheduler`, `db`.

First run takes longer because Docker pulls base images and the ZIP is downloaded.

---

## Step 6: Verify the Stack

Check container status:

```bash
docker compose -f docker-compose.github.yml ps
```

All five services (`web`, `app`, `queue`, `scheduler`, `db`) should be `running` / `healthy`.

Open the app:

- http://localhost:8080
- http://localhost:8080/login

If the page does not load, check logs:

```bash
docker compose -f docker-compose.github.yml logs --tail=200 app
docker compose -f docker-compose.github.yml logs --tail=200 web
```

---

## Step 7: (Optional) Schedule Daily Version Sync

Set up a cron job (Linux/macOS) or Task Scheduler entry (Windows) to pull new app versions once per day.

### Linux / macOS — cron (2:00 AM daily)

```bash
0 2 * * * cd /path/to/offline-pos-system && ./scripts/offline/sync-daily.sh >> /var/log/offline-pos-sync.log 2>&1
```

### Windows — Task Scheduler

Create a basic task that runs daily and executes:

```
cmd /c "cd /d C:\path\to\offline-pos-system && Sync_Daily_Windows.bat"
```

The sync script reads `.env.offline`, calls the version API, and only downloads a new ZIP when the version differs from the locally installed one.

---

## Manual Setup (No Launcher)

If you cannot use the OS launcher, run from the project root:

```bash
./scripts/offline/setup-full-offline.sh
```

Or pass a specific ZIP URL directly:

```bash
./scripts/offline/setup-full-offline.sh https://<central-server>/pos_<VERSION>.zip
```

Manual migration (only if needed):

```bash
docker compose -f docker-compose.github.yml exec -T app sh -lc "php artisan migrate --force"
```

---

## Troubleshooting

| Symptom | Action |
| --- | --- |
| Docker not found | Install Docker Desktop and ensure it is running |
| Port 8080 already in use | Stop the other service, or change the `web` port mapping in `docker-compose.github.yml` |
| Port 3308 already in use | Set `DB_PORT_HOST` to a free port when running the setup script |
| ZIP download fails | Verify `POS_OFFLINE_SYNC_SOURCE_URL` is reachable and `POS_OFFLINE_SYNC_TOKEN` is valid |
| App returns 500 | Check `docker compose -f docker-compose.github.yml logs --tail=200 app` |
| Migrations failed | Run the manual migration command above after DB is fully up |
| Need a clean rebuild | `docker compose -f docker-compose.github.yml up -d --build --force-recreate` (do **not** use `down -v` unless you want to wipe the DB) |

---

## Reference Files

- Compose file: [docker-compose.github.yml](docker-compose.github.yml)
- Store credentials: [.env.offline](.env.offline) *(not in git)*
- Bootstrap script: [docker/offline/php/start-app.sh](docker/offline/php/start-app.sh)
- Full setup script: [scripts/offline/setup-full-offline.sh](scripts/offline/setup-full-offline.sh)
- Pull latest code (Windows): [Pull_Repo_Windows.bat](Pull_Repo_Windows.bat)
- Daily sync script (Mac/Linux): [scripts/offline/sync-daily.sh](scripts/offline/sync-daily.sh)
- Daily sync script (Windows): [Sync_Daily_Windows.bat](Sync_Daily_Windows.bat)
- Full runbook: [README.md](README.md)
- Deployment details: [Offline_POS_Deployment_Steps.md](Offline_POS_Deployment_Steps.md)
