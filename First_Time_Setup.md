# First Time Setup — Offline POS (Windows)

Step-by-step guide for setting up the Offline POS Docker stack on a Windows computer for the first time.

---

## Step 1: Install Prerequisites

Install the following before anything else:

### Docker Desktop
1. Download from [docker.com](https://www.docker.com/products/docker-desktop/)
2. Run the installer and restart when prompted
3. After restart, Docker Desktop should start automatically (whale icon in the system tray)
4. Wait until Docker Desktop shows **"Engine running"**

### Git for Windows
1. Download from [git-scm.com](https://git-scm.com/download/win)
2. Run the installer with default options

Verify both are working — open **Command Prompt** and run:

```cmd
docker --version
docker compose version
git --version
```

---

## Step 2: Get the Project Files

Open **Command Prompt** and run:

```cmd
git clone https://github.com/gajendergce/offline-pos-system
cd offline-pos-system
```

Or double-click **[Pull_Repo_Windows.bat](Pull_Repo_Windows.bat)** — it will clone the repo automatically (requires `GIT_USERNAME` and `GIT_TOKEN` in `.env.offline`, see Step 3).

---

## Step 3: Create `.env.offline`

Create a file named `.env.offline` in the project folder with the credentials for this store:

```env
POS_OFFLINE_SYNC_STORE_ID=<store id>
POS_OFFLINE_SYNC_TOKEN=<auth token>
POS_OFFLINE_SYNC_SOURCE_URL=https://<central-server>/public/
POS_OFFLINE_MODE=true

# GitHub repo credentials (used by Pull_Repo_Windows.bat)
GIT_REPO_URL=https://github.com/gajendergce/offline-pos-system
GIT_USERNAME=<github username>
GIT_TOKEN=<github personal access token>
```

| Variable | Purpose |
| --- | --- |
| `POS_OFFLINE_SYNC_STORE_ID` | Store ID assigned by the central system |
| `POS_OFFLINE_SYNC_TOKEN` | Auth token for this store |
| `POS_OFFLINE_SYNC_SOURCE_URL` | Base URL of the central server |
| `POS_OFFLINE_MODE` | Always `true` for offline stores |
| `GIT_REPO_URL` | GitHub repository URL |
| `GIT_USERNAME` | GitHub username for private repo access |
| `GIT_TOKEN` | GitHub personal access token (needs `repo` scope) |

> **`APP_VERSION_URL`** is derived automatically from `POS_OFFLINE_SYNC_SOURCE_URL + /api/offline/version` — do not set it manually.
>
> **`APP_ZIP_URL`** is returned by the version API (`POS_OFFLINE_ZIP_URL` in the response) — do not set it manually.

**Important:** `.env.offline` is in `.gitignore` and is never committed to the repository. Each store must create its own copy.

---

## Step 4: Run the First-Time Setup

Double-click **[Setup_Offline_POS_Windows.bat](Setup_Offline_POS_Windows.bat)**.

If Windows SmartScreen blocks it:
1. Click **More info**
2. Click **Run anyway**

The script will:
1. Read `.env.offline`
2. Derive the version API URL from `POS_OFFLINE_SYNC_SOURCE_URL`
3. Call the API to get the current app bundle version and ZIP URL
4. Check the ZIP is reachable before starting
5. Run `docker compose up -d --build` to pull images and start all containers
6. Wait for MySQL to be ready and grant database privileges
7. Wait for the app to bootstrap (ZIP download + `composer install`)
8. Generate `APP_KEY` if not already set
9. Stamp the installed version into `.zip_sync_version`

---

## Step 5: Watch the Progress

The Command Prompt window shows live progress. A successful setup ends with:

```
ZIP is available (HTTP 200).
...
Setup complete. App is reachable at http://localhost:8080/login
Stamped installed version (x.x.x) into .env and .zip_sync_version.
```

First run takes **5–15 minutes** because Docker pulls base images and the ZIP is downloaded and extracted.

---

## Step 6: Verify the Stack

Open a new **Command Prompt** and run:

```cmd
docker compose -f docker-compose.github.yml ps
```

All five services should be `running`:

| Service | Role |
| --- | --- |
| `web` | Apache / Nginx reverse proxy (port 8080) |
| `app` | PHP-FPM Laravel application |
| `queue` | Laravel queue worker |
| `scheduler` | Laravel task scheduler |
| `db` | MySQL 5.7 database |

Open the app in a browser:

- **http://localhost:8080**
- **http://localhost:8080/login**

If the page does not load, check the logs:

```cmd
docker compose -f docker-compose.github.yml logs --tail=200 app
docker compose -f docker-compose.github.yml logs --tail=200 web
```

---

## Step 7: Run Initial Data Sync

After the app is up, run a full initial sync of all store data from the central server.

**Easiest way — Docker Desktop:**

1. Open **Docker Desktop**
2. Go to **Containers**
3. Click on **offline-pos-system-scheduler-1**
4. Click the **Exec** tab (opens a terminal inside the container)
5. Run each command below,

```sh
php artisan offline:sync-store-data
php artisan offline:sync-users-security 
php artisan offline:sync-invoices 
php artisan offline:sync-inventory
```



| Command | Schedule | Purpose |
| --- | --- | --- |
| `offline:sync-store-data` | Every hour | Store configuration and settings |
| `offline:sync-users-security` | Every hour | Users and security roles |
| `offline:sync-invoices` | Every 15 minutes | Invoice data |
| `offline:sync-inventory` | Daily at 03:00 | Full inventory sync |
| `offline:sync-inventory --delta=1` | Every 15 minutes | Incremental inventory changes |

---

## Step 8: Schedule Daily App Version Sync

Set up Windows Task Scheduler to run **[Sync_Daily_Windows.bat](Sync_Daily_Windows.bat)** once per day so the app stays up to date automatically.

1. Open **Task Scheduler** (search in Start menu)
2. Click **Create Basic Task...**
3. Name: `Offline POS Daily Sync`
4. Trigger: **Daily** at a quiet time (e.g. 2:00 AM)
5. Action: **Start a program**
6. Program: `cmd.exe`
7. Arguments: `/c "cd /d C:\path\to\offline-pos-system && Sync_Daily_Windows.bat"`
8. Click **Finish**

The sync script checks the version API and only downloads a new ZIP when the installed version differs from the server version.

---

## Updating the Code (Pull Latest)

To pull the latest project files from GitHub, double-click **[Pull_Repo_Windows.bat](Pull_Repo_Windows.bat)**.

It reads `GIT_USERNAME` and `GIT_TOKEN` from `.env.offline`, authenticates to GitHub, and runs `git pull`. After pulling, restart the Docker stack to apply any compose or Dockerfile changes:

```cmd
docker compose -f docker-compose.github.yml up -d --build
```

---

## Troubleshooting

| Symptom | Action |
| --- | --- |
| Docker not found | Install Docker Desktop and ensure it is running (whale in system tray) |
| `SmartScreen blocked` | Click **More info → Run anyway** |
| Port 8080 already in use | Stop the other service, or change the `web` port mapping in `docker-compose.github.yml` |
| Port 3308 already in use | Set `DB_PORT_HOST` to a free port before running setup |
| ZIP availability check fails | Verify `POS_OFFLINE_SYNC_SOURCE_URL` is correct and the machine has internet access |
| `POS_OFFLINE_SYNC_TOKEN` error | Check the token value in `.env.offline` — no trailing spaces |
| App returns 500 | Run: `docker compose -f docker-compose.github.yml logs --tail=200 app` |
| Migrations failed | Run: `docker compose -f docker-compose.github.yml exec -T app sh -lc "php artisan migrate --force"` |
| Need a clean rebuild | `docker compose -f docker-compose.github.yml up -d --build --force-recreate` |
| Want to wipe DB and start fresh | `docker compose -f docker-compose.github.yml down -v` then re-run setup (**destroys all data**) |

---

## Reference Files

| File | Purpose |
| --- | --- |
| [Setup_Offline_POS_Windows.bat](Setup_Offline_POS_Windows.bat) | First-time Docker setup |
| [Sync_Daily_Windows.bat](Sync_Daily_Windows.bat) | Daily version sync |
| [Pull_Repo_Windows.bat](Pull_Repo_Windows.bat) | Pull latest code from GitHub |
| [docker-compose.github.yml](docker-compose.github.yml) | Docker Compose configuration |
| [.env.offline](.env.offline) | Store credentials *(not in git)* |
| [docker/offline/php/start-app.sh](docker/offline/php/start-app.sh) | Container bootstrap script |
