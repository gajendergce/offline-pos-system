# Offline POS — Deployment & Setup Steps

---

## 1. Docker Compose Stack

### a. PHP 7.4-FPM
- Laravel 5.8 application container
- Extensions: pdo_mysql, mbstring, gd (freetype+jpeg), redis, bcmath, opcache, zip, xml, exif, pcntl
- Composer 2.2 (last version supporting PHP 7.4)
- Queue worker container (same image)
- Scheduler container (same image)

### b. Apache 2.4
- Reverse proxy to PHP-FPM on port 9000
- Serves Laravel `public/` directory
- Max upload size: 50MB
- Static asset caching (30 days)
- Blocks access to `.env`, `.git`, `storage/`, `bootstrap/cache/`

### c. MySQL 5.7.44
- Default database: `agrtl_offline`
- Port mapping: 3308 (host) → 3306 (container)
- Persistent volume for data retention
- Optional: SQL init scripts via `docker/mysql/` directory

### d. Application Code Deployment (choose one)
- **Option 1:** Download Laravel app ZIP from hosted URL during container startup (`APP_ZIP_URL`)
- **Option 2:** Use pre-mounted local source with `docker-compose.offline.yml`
- Clone/download should include only selected modules, controllers, and menus relevant to offline operation

### e. Composer Dependencies
- `vendor/` folder is not required in source ZIP
- Runtime startup runs `composer install --no-interaction --prefer-dist --optimize-autoloader`

### f. Environment Configuration (`.env.offline`)
- `STORE_ID` — unique store identifier for API sync
- `API_BASE_URL` — central server URL for push/pull
- `API_TOKEN` — authentication token for API calls
- `SYNC_INTERVAL` — auto-sync frequency (in minutes)
- Database credentials (`DB_HOST=db`, `DB_PORT=3306`, etc.)
- Queue, cache, and session drivers

---

## 2. Sample Database Import

- Provide a base `.sql` dump with required master data
- Auto-import on first `docker compose up` via `docker/mysql/` init directory
- Should include:
  - Default admin user
  - Default roles and permissions
  - Store-specific configuration
  - Tax rates, payment methods, and other lookup tables
  - Sample inventory (optional, for testing)

---

## 3. Sync API — Pull & Push

### a. Pull API (Central Server → Offline Store)
Download latest data from central server to the offline store:

| #  | Entity              | Description                          | Priority |
|----|---------------------|--------------------------------------|----------|
| 1  | Users               | Staff accounts & credentials         | High     |
| 2  | Security            | Roles, permissions, access control   | High     |
| 3  | Station             | POS station/terminal configuration   | High     |
| 4  | Inventory           | Product master data                  | High     |
| 5  | InvenPlu            | PLU codes / barcode mappings         | High     |
| 6  | Kit Items           | Combo/bundle product definitions     | Medium   |
| 7  | Customers           | Customer master list                 | Medium   |
| 8  | Recurring           | Recurring billing/subscription data  | Low      |
| 9  | Promotions/Discounts| Active offers & discount rules       | Medium   |
| 10 | Tax Configuration   | Tax rates, rules, exemptions         | High     |
| 11 | Payment Methods     | Accepted payment types               | High     |
| 12 | Categories/Menus    | Product categories & menu layouts    | High     |

### b. Push API (Offline Store → Central Server)
Upload locally created data back to the central server:

| #  | Entity              | Description                          | Priority |
|----|---------------------|--------------------------------------|----------|
| 1  | Invoice             | Sales transaction headers            | High     |
| 2  | Invoice Items       | Line items per invoice               | High     |
| 3  | Inventory History   | Stock movements, adjustments         | High     |
| 4  | Customers           | Newly created local customers        | Medium   |
| 5  | Shift Reports       | Staff shift summaries                | Medium   |
| 6  | Void/Refund Logs    | Cancelled or refunded transactions   | High     |
| 7  | Sync Logs           | Sync status, errors, timestamps      | Medium   |

### c. Sync Mechanism
- Every sync request includes `STORE_ID` in the header/payload
- Use `last_synced_at` timestamp for delta/incremental sync
- Queue-based sync via Laravel queue worker (retries on failure)
- Conflict resolution: central server wins for pull, offline store wins for push (or timestamp-based merge)
- Offline-first: app works fully without internet; queues sync when connection is restored

---

## 4. Store Identification & Security

- Each offline installation has a unique `STORE_ID` in `.env.offline`
- API authentication via `API_TOKEN` (per-store token issued by central server)
- All API calls include:
  - `X-Store-ID` header
  - `Authorization: Bearer <API_TOKEN>` header
- Token rotation/refresh mechanism for long-running deployments

---

## 5. Data Tables for Sync

| #  | Table               | Sync Direction      | Notes                                      |
|----|---------------------|---------------------|--------------------------------------------|
| 1  | Users               | Pull ↓              | Synced from central, not editable locally   |
| 2  | Security            | Pull ↓              | Roles & permissions from central            |
| 3  | Station             | Pull ↓              | Terminal config from central                |
| 4  | Invoice             | Push ↑              | Created locally, pushed to central          |
| 5  | Invoice Items       | Push ↑              | Created locally, pushed to central          |
| 6  | Inventory           | Pull ↓              | Product master from central                 |
| 7  | InvenPlu            | Pull ↓              | PLU/barcode data from central               |
| 8  | Inventory History   | Push ↑              | Stock changes pushed to central             |
| 9  | Kit Items           | Pull ↓              | Combo definitions from central              |
| 10 | Customers           | Pull ↓ / Push ↑     | Bidirectional — new local customers pushed  |
| 11 | Recurring           | Pull ↓              | Subscription data from central              |
| 12 | VFD                 | Pull ↓              | Subscription data from central              |
| 13 | Contract            | Pull ↓              | Subscription data from central              |
| 14 | Recurring           | Pull ↓              | Subscription data from central              |
| 15 | Vendor              | Pull ↓              | Subscription data from central              |
| 16 | Category            | Pull ↓              | Subscription data from central              |
| 17 | Look up Code        | Pull ↓              | Subscription data from central              |
| 18 | Accounts            | Pull ↓              | Subscription data from central              |



---

## 6. Post-Deployment Checklist

- [ ] Docker Compose stack builds successfully
- [ ] All 5 containers running (`web`, `app`, `queue`, `scheduler`, `db`)
- [ ] `.env.offline` configured with correct `STORE_ID`, `API_BASE_URL`, `API_TOKEN`
- [ ] Sample database imported and migrations run
- [ ] App accessible at `http://localhost:8080`
- [ ] Admin user can log in
- [ ] POS screen loads with inventory/menu items
- [ ] Test transaction (create invoice) works offline
- [ ] Pull API: can fetch latest data from central server
- [ ] Push API: can send invoices/inventory to central server
- [ ] Queue worker is processing sync jobs
- [ ] Scheduler is running periodic sync
- [ ] Storage permissions correct (no write errors)
- [ ] Logs are accessible and not throwing errors

---

## 7. Maintenance & Updates

- **Code update:** Rebuild Docker images (`docker compose build --no-cache`) to pull latest from repo
- **Database migration:** Run `docker compose exec app php artisan migrate --force` after updates
- **Clear cache:** Run `docker compose exec app php artisan config:clear && php artisan cache:clear`
- **Backup DB:** `docker compose exec db mysqldump -u agrtl -pagrtl123 agrtl_offline > backup.sql`
- **Restore DB:** `docker compose exec -T db mysql -u agrtl -pagrtl123 agrtl_offline < backup.sql`
- **View logs:** `docker compose logs -f app` or via VS Code Docker sidebar
