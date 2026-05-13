# Offline POS — First Iteration Scope

---

## 1. Overview

The first iteration focuses on setting up the core offline POS infrastructure and enabling bidirectional data sync between the **Central Server** and **Offline Store** for 11 key entities.

---

## 2. Docker Stack

| Component  | Version         | Role                          |
|------------|-----------------|-------------------------------|
| PHP        | 7.4-FPM         | Laravel 5.8 application       |
| Nginx      | 1.25 Alpine     | Reverse proxy                 |
| MySQL      | 5.7.44          | Database                      |
| Queue      | PHP 7.4-FPM     | Background job processing     |
| Scheduler  | PHP 7.4-FPM     | Periodic sync trigger         |

---

## 3. Application Code Deployment

Two options for getting application code into the container:

- **Option A:** Git clone from private GitHub repo (using PAT + branch)
- **Option B:** Download ZIP from a hosted URL

---

## 4. Store Configuration

Each offline store will have the following in its `.env.offline`:

```
STORE_ID=STORE_001
API_BASE_URL=https://central-server.com/api
API_TOKEN=your-api-token-here
SYNC_INTERVAL=5
```

- `STORE_ID` — unique identifier for each store location
- `API_BASE_URL` — central server endpoint
- `API_TOKEN` — per-store authentication token
- `SYNC_INTERVAL` — how often (in minutes) auto-sync runs

---

## 5. First Iteration — Entities

| #  | Entity            | Sync Direction | Description                              |
|----|-------------------|----------------|------------------------------------------|
| 1  | Users             | Pull ↓         | Staff accounts synced from central       |
| 2  | Security          | Pull ↓         | Roles, permissions, access control       |
| 3  | Station           | Pull ↓         | POS terminal configuration               |
| 4  | Invoice           | Push ↑         | Sales transactions created offline       |
| 5  | Invoice Items     | Push ↑         | Line items per invoice                   |
| 6  | Inventory         | Pull ↓         | Product master data                      |
| 7  | InvenPlu          | Pull ↓         | PLU codes / barcode mappings             |
| 8  | Inventory History | Push ↑         | Stock movements and adjustments          |
| 9  | Kit Items         | Pull ↓         | Combo/bundle product definitions         |
| 10 | Customers         | Pull ↓ Push ↑  | Bidirectional — new customers pushed up  |
| 11 | Recurring         | Pull ↓         | Recurring billing/subscription data      |

---

## 6. API Sync Flow

### a. Pull Flow (Central → Offline Store)

```
Offline Store                          Central Server
     |                                       |
     |  1. POST /api/sync/pull               |
     |  Headers:                             |
     |    X-Store-ID: STORE_001              |
     |    Authorization: Bearer <token>      |
     |  Body:                                |
     |    { "last_synced_at": "2026-05-01" } |
     | ------------------------------------> |
     |                                       |
     |  2. Response:                         |
     |    { "users": [...],                  |
     |      "inventory": [...],              |
     |      "security": [...],               |
     |      ... }                            |
     | <------------------------------------ |
     |                                       |
     |  3. Upsert received data locally      |
     |  4. Update last_synced_at timestamp   |
     |                                       |
```

**Pull entities:** Users, Security, Station, Inventory, InvenPlu, Kit Items, Customers, Recurring

### b. Push Flow (Offline Store → Central)

```
Offline Store                          Central Server
     |                                       |
     |  1. POST /api/sync/push               |
     |  Headers:                             |
     |    X-Store-ID: STORE_001              |
     |    Authorization: Bearer <token>      |
     |  Body:                                |
     |    { "invoices": [...],               |
     |      "invoice_items": [...],          |
     |      "inventory_history": [...],      |
     |      "customers": [...] }             |
     | ------------------------------------> |
     |                                       |
     |  2. Central processes & stores data   |
     |  3. Response:                         |
     |    { "status": "success",             |
     |      "synced_ids": { ... } }          |
     | <------------------------------------ |
     |                                       |
     |  4. Mark local records as synced      |
     |                                       |
```

**Push entities:** Invoice, Invoice Items, Inventory History, Customers (new)

### c. Combined Sync Cycle

```
┌─────────────────────────────────────────────┐
│              Scheduler (every 5 min)        │
│                     │                       │
│                     ▼                       │
│           ┌─── Check Internet ───┐          │
│           │                      │          │
│         Online               Offline        │
│           │                      │          │
│     ┌─────┴─────┐          Queue jobs       │
│     │           │          for later         │
│   Pull ↓     Push ↑                         │
│     │           │                           │
│  Upsert     Mark as                         │
│  locally    synced                          │
│     │           │                           │
│     └─────┬─────┘                           │
│           │                                 │
│     Update sync                             │
│     timestamp                               │
└─────────────────────────────────────────────┘
```

---

## 7. Sync Rules

- **Delta sync only** — each request sends `last_synced_at` to fetch only changed records
- **Offline-first** — app works fully without internet; jobs are queued and processed when connection is restored
- **Retry on failure** — queue worker retries failed sync jobs up to 3 times
- **Conflict resolution:**
  - Pull: central server data overwrites local
  - Push: offline store data is appended to central
  - Customers: if same record modified both sides, `updated_at` timestamp wins
- **Each record tracks:**
  - `is_synced` — whether it has been pushed/pulled
  - `synced_at` — last successful sync timestamp
  - `store_id` — which store the record belongs to

---

## 8. API Endpoints (First Iteration)

| Method | Endpoint              | Direction | Description                     |
|--------|-----------------------|-----------|---------------------------------|
| POST   | `/api/sync/pull`      | Pull ↓    | Fetch latest data from central  |
| POST   | `/api/sync/push`      | Push ↑    | Send local data to central      |
| GET    | `/api/sync/status`    | —         | Check last sync time & status   |
| POST   | `/api/sync/full-pull` | Pull ↓    | Force full data pull (no delta) |

---

## 9. Database Changes for Sync

Add these columns to all synced tables:

```sql
ALTER TABLE <table_name> ADD COLUMN is_synced TINYINT(1) DEFAULT 0;
ALTER TABLE <table_name> ADD COLUMN synced_at TIMESTAMP NULL;
ALTER TABLE <table_name> ADD COLUMN store_id VARCHAR(50) NULL;
```

New table for tracking sync history:

```sql
CREATE TABLE sync_logs (
    id BIGINT AUTO_INCREMENT PRIMARY KEY,
    store_id VARCHAR(50) NOT NULL,
    direction ENUM('pull', 'push') NOT NULL,
    entity VARCHAR(100) NOT NULL,
    records_count INT DEFAULT 0,
    status ENUM('success', 'failed', 'partial') NOT NULL,
    error_message TEXT NULL,
    started_at TIMESTAMP NOT NULL,
    completed_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

---

## 10. Sample DB Import

- A base `.sql` dump will be provided with:
  - Default admin user
  - Default roles and permissions
  - Store-specific configuration
  - Tax rates, payment methods, lookup tables
- Auto-imports on first `docker compose up` via `docker/mysql/` init directory

---

