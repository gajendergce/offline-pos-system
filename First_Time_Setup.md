# First Time Setup — Offline POS

Step-by-step guide for setting up the Offline POS Docker stack on a brand new computer.

Use the launcher for your operating system, or follow the manual steps at the end.

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

Either clone the repository or copy the `offline-pos-docker` folder onto the new computer.

```bash
git clone <this-repo-url>
cd offline-pos-docker
```

After this you should see [docker-compose.github.yml](docker-compose.github.yml), [.env.offline](.env.offline), and the OS launcher files in the project root.

---

## Step 3: Configure Store Credentials

Open [.env.offline](.env.offline) and set values for **this specific store**:

| Variable | Purpose |
| --- | --- |
| `OFFLINE_STORE_ID` | Store ID assigned by the central system |
| `OFFLINE_TOKEN` | Auth token for this store |
| `APP_VERSION_URL` | API endpoint that returns current app bundle version |
| `APP_ZIP_URL` | ZIP URL template (keep the `APP_VERSION` placeholder) |
| `OFFLINE_API_BASE_URL` | Base URL of the central API |
| `POS_OFFLINE_SYNC_STORE_ID` | Same as `OFFLINE_STORE_ID` |
| `POS_OFFLINE_SYNC_TOKEN` | Same as `OFFLINE_TOKEN` |

Save the file. These values are read by the launcher and the daily sync scripts.

---

## Step 4: Run the First-Time Setup

Pick the launcher that matches your operating system. Run it from the project root.

### macOS

Double-click [Setup_Offline_POS.command](Setup_Offline_POS.command) (or [Setup_Offline_POS.app](Setup_Offline_POS.app)).

If macOS blocks it the first time:

1. Right-click the file → **Open** → **Open** again in the dialog, or
2. Run once from Terminal:
   ```bash
   chmod +x Setup_Offline_POS.command
   ./Setup_Offline_POS.command
   ```

### Ubuntu / Linux

```bash
chmod +x Setup_Offline_POS_Ubuntu.sh
./Setup_Offline_POS_Ubuntu.sh
```

Optional desktop shortcut:

```bash
chmod +x Setup_Offline_POS_Ubuntu.desktop
```

### Windows

Double-click [Setup_Offline_POS_Windows.bat](Setup_Offline_POS_Windows.bat).

If SmartScreen blocks it, click **More info** → **Run anyway**.

---

## Step 5: Watch the First Build

The launcher will:

1. Read `.env.offline`.
2. Call `APP_VERSION_URL` to resolve the current app bundle version.
3. Replace `APP_VERSION` in `APP_ZIP_URL` with that version.
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

Linux/macOS cron example (2:00 AM daily):

```bash
0 2 * * * cd /path/to/offline-pos-docker && ./scripts/offline/sync-daily.sh >> /var/log/offline-pos-sync.log 2>&1
```

The script reads `.env.offline`, calls `APP_VERSION_URL`, and only re-syncs when the version differs from the locally stored one.

---

## Manual Setup (No Launcher)

If you cannot use the OS launcher, run from the project root:

```bash
APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_<VERSION>.zip \
DB_DATABASE=agrtl_offline \
DB_PASSWORD=root123 \
DB_APP_USER=app \
DB_APP_PASSWORD=app123 \
DB_PORT_HOST=3310 \
docker compose -f docker-compose.github.yml up -d --build
```

Replace `<VERSION>` with the current bundle version returned by the API.

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
| Port 3310 already in use | Set `DB_PORT_HOST` to a free port in the launcher |
| ZIP download fails | Verify `APP_VERSION_URL` and `APP_ZIP_URL` reachable from this machine and `OFFLINE_TOKEN` is valid |
| App returns 500 | Check `docker compose -f docker-compose.github.yml logs --tail=200 app` |
| Migrations failed | Run the manual migration command above after DB is fully up |
| Need a clean rebuild | `docker compose -f docker-compose.github.yml up -d --build --force-recreate` (do **not** use `down -v` unless you want to wipe the DB) |

---

## Reference Files

- Compose file: [docker-compose.github.yml](docker-compose.github.yml)
- Store credentials: [.env.offline](.env.offline)
- Bootstrap script: [docker/offline/php/start-app.sh](docker/offline/php/start-app.sh)
- Full setup script: [scripts/offline/setup-full-offline.sh](scripts/offline/setup-full-offline.sh)
- Daily sync script: [scripts/offline/sync-daily.sh](scripts/offline/sync-daily.sh)
- Full runbook: [README.md](README.md)
- Deployment details: [Offline_POS_Deployment_Steps.md](Offline_POS_Deployment_Steps.md)
