@echo off
setlocal enableextensions enabledelayedexpansion

set "PROJECT_DIR=%~dp0"
set "COMPOSE_FILE=%PROJECT_DIR%docker-compose.github.yml"

cd /d "%PROJECT_DIR%"
if errorlevel 1 (
  echo Failed to enter project directory: %PROJECT_DIR%
  goto :end
)

where docker >nul 2>&1
if errorlevel 1 (
  echo Docker is not installed or not in PATH.
  goto :end
)

REM Load .env.offline values.
REM PowerShell strips CRLF automatically -- a trailing \r corrupts API calls.
set "OFFLINE_ENV=%PROJECT_DIR%.env.offline"
if not exist "%OFFLINE_ENV%" (
  echo Error: .env.offline not found at %OFFLINE_ENV%
  goto :end
)
for /f "usebackq delims=" %%L in (`powershell -NoProfile -Command "Get-Content -LiteralPath '%OFFLINE_ENV%' | ForEach-Object { $_.TrimEnd() } | Where-Object { $_ -notmatch '^\s*#' -and $_.Trim() -ne '' }"`) do (
  for /f "tokens=1,* delims==" %%A in ("%%L") do (
    if not "%%A"=="" set "%%A=%%B"
  )
)

if not defined POS_OFFLINE_SYNC_STORE_ID (
  echo Error: POS_OFFLINE_SYNC_STORE_ID is required in .env.offline
  goto :end
)
if not defined OFFLINE_TOKEN (
  echo Error: OFFLINE_TOKEN is required in .env.offline
  goto :end
)
if not defined APP_VERSION_URL (
  echo Error: APP_VERSION_URL is required in .env.offline
  goto :end
)
if not defined APP_ZIP_URL set "APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_APP_VERSION.zip"

echo Daily sync starting...
echo Version API : %APP_VERSION_URL%
echo ZIP template: %APP_ZIP_URL%

REM ── Read current version from container marker file first ──────────────────
REM Sent to the API as current_version so the server knows what is installed.
set "OLD_VERSION="
for /f "usebackq delims=" %%V in (`docker compose -f "%COMPOSE_FILE%" exec -T app sh -c "cat /var/www/html/.zip_sync_version 2>/dev/null || true" 2^>nul`) do set "OLD_VERSION=%%V"
if defined OLD_VERSION (
  for /f "tokens=* delims=" %%V in ("!OLD_VERSION!") do set "OLD_VERSION=%%V"
)
if not defined OLD_VERSION set "OLD_VERSION="
echo Current installed version: !OLD_VERSION!

REM ── Fetch target version from API ──────────────────────────────────────────
echo Fetching latest app version from API...
set "_BODY_TMP=%TEMP%\pos_body_%RANDOM%.json"
set "_VER_TMP=%TEMP%\pos_ver_%RANDOM%.json"
powershell -NoProfile -Command "$body = ConvertTo-Json @{store_id = [int]%POS_OFFLINE_SYNC_STORE_ID%; offline_token = '%POS_OFFLINE_SYNC_TOKEN%'; current_version = '!OLD_VERSION!'}; [IO.File]::WriteAllText('%_BODY_TMP%', $body)"
curl.exe -s --ssl-no-revoke --location --request GET "%APP_VERSION_URL%" --header "Content-Type: application/json" --data @"%_BODY_TMP%" --output "%_VER_TMP%"
del "%_BODY_TMP%" >nul 2>&1

if not exist "%_VER_TMP%" (
  echo Error: API request failed. Check network and APP_VERSION_URL in .env.offline.
  goto :end
)
for /f "usebackq delims=" %%V in (`powershell -NoProfile -Command "(Get-Content -LiteralPath '%_VER_TMP%' -Raw | ConvertFrom-Json).POS_OFFLINE_BUNDLE_APP_VERSION.Trim()"`) do set "NEW_VERSION=%%V"
del "%_VER_TMP%" >nul 2>&1

if not defined NEW_VERSION (
  echo Error: could not parse POS_OFFLINE_BUNDLE_APP_VERSION from API response.
  echo Check APP_VERSION_URL, POS_OFFLINE_SYNC_STORE_ID and POS_OFFLINE_SYNC_TOKEN in .env.offline.
  goto :end
)
echo New version from API: %NEW_VERSION%

REM ── Compare versions ────────────────────────────────────────────────────────
if "!OLD_VERSION!"=="%NEW_VERSION%" (
  echo Version matches ^(%NEW_VERSION%^). No ZIP download needed.
  echo Syncing .env.offline values into app .env...
  call :sync_env_offline
  echo Daily sync complete -- nothing to update.
  goto :end
)

echo Version mismatch ^(!OLD_VERSION! -^> %NEW_VERSION%^). Downloading new ZIP...

REM ── Resolve ZIP URL ─────────────────────────────────────────────────────────
set "RESOLVED_ZIP=!APP_ZIP_URL:APP_VERSION=%NEW_VERSION%!"
echo Using ZIP URL: !RESOLVED_ZIP!

REM ── Force-recreate app services with new version ────────────────────────────
REM APP_ENABLE_VERSION_SYNC_ON_START=0 tells start-app.sh to use the URL we
REM provide directly instead of re-calling the version API itself.
set "APP_ZIP_URL=!RESOLVED_ZIP!"
set "APP_TARGET_VERSION=%NEW_VERSION%"
set "APP_SYNC_ZIP_ON_START=always"
set "APP_ENABLE_VERSION_SYNC_ON_START=0"
docker compose -f "%COMPOSE_FILE%" up -d --build --force-recreate app queue scheduler
if errorlevel 1 (
  echo Failed to restart services.
  goto :end
)

REM ── Wait for app to bootstrap (artisan + vendor present) ────────────────────
echo Waiting for app to bootstrap...
set /a _BOOT_TRIES=0
:boot_wait
docker compose -f "%COMPOSE_FILE%" exec -T app sh -c "test -f /var/www/html/artisan && test -f /var/www/html/vendor/autoload.php" >nul 2>&1
if not errorlevel 1 goto :boot_ready
set /a _BOOT_TRIES+=1
if %_BOOT_TRIES% geq 180 (
  echo WARNING: App did not bootstrap in 6 minutes -- proceeding anyway.
  goto :after_maintenance
)
powershell -NoProfile -Command "Start-Sleep -Seconds 2" >nul
goto :boot_wait

:boot_ready
REM Regenerate APP_KEY using PHP built-ins if not already set.
REM php artisan key:generate cannot run if .env is invalid (catch-22), so we
REM use raw PHP file I/O which requires no Laravel bootstrap at all.
echo Generating encryption key if not set...
docker compose -f "%COMPOSE_FILE%" exec -T app php -r "$e=file_get_contents('/var/www/html/.env');if(preg_match('/^APP_KEY=\S/m',$e))exit;$k='base64:'.base64_encode(random_bytes(32));$e=preg_match('/^APP_KEY=/m',$e)?preg_replace('/^APP_KEY=.*/m','APP_KEY='.$k,$e):$e.chr(10).'APP_KEY='.$k;file_put_contents('/var/www/html/.env',$e);" 2>nul

echo Running post-sync maintenance ^(migrations, cache clear^)...
docker compose -f "%COMPOSE_FILE%" exec -T -u root app sh -lc "cd /var/www/html && if [ -f .env ]; then if grep -q '^POS_OFFLINE_MODE=' .env; then sed -i 's|^POS_OFFLINE_MODE=.*|POS_OFFLINE_MODE=true|' .env; else echo 'POS_OFFLINE_MODE=true' >> .env; fi; fi && mkdir -p storage/framework/sessions storage/framework/views storage/framework/cache/data storage/logs bootstrap/cache && chown -R www-data:www-data storage bootstrap/cache && chmod -R 777 storage && php artisan optimize:clear && php artisan migrate --path=database/offline_migrations --force --no-interaction || true"

:after_maintenance

REM ── Sync .env.offline into container .env ──────────────────────────────────
echo Syncing .env.offline values into app .env...
call :sync_env_offline

REM ── Stamp version marker ────────────────────────────────────────────────────
docker compose -f "%COMPOSE_FILE%" exec -T app sh -c "printf '%%s' '%NEW_VERSION%' > /var/www/html/.zip_sync_version" >nul 2>&1
echo Stamped version %NEW_VERSION% into .zip_sync_version

REM ── Wait for app endpoint ───────────────────────────────────────────────────
echo Waiting for app endpoint to become ready...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ok=$false; for($i=0;$i -lt 90;$i++){ try { $resp = Invoke-WebRequest -Uri 'http://localhost:8080/login' -MaximumRedirection 0 -ErrorAction Stop; if($resp.StatusCode -eq 200 -or $resp.StatusCode -eq 302){ $ok=$true; break } } catch { if($_.Exception.Response -and ($_.Exception.Response.StatusCode.Value__ -eq 302)){ $ok=$true; break } }; Start-Sleep -Seconds 2 }; if($ok){ exit 0 } else { exit 1 }"
if errorlevel 1 (
  echo Sync finished, but app is not ready yet.
  echo Run: docker compose -f "%COMPOSE_FILE%" logs --tail=200 app web
  goto :end
)

echo Daily sync complete. App updated to %NEW_VERSION% at http://localhost:8080/login
goto :end

REM ── Subroutine: push .env.offline key=value pairs into container .env ───────
:sync_env_offline
if not exist "%OFFLINE_ENV%" exit /b 0
REM Write cleaned lines to a temp file (no comments, no blanks, no CRLF).
set "_ENVLINES_TMP=%TEMP%\pos_envlines_%RANDOM%.txt"
powershell -NoProfile -Command "Get-Content -LiteralPath '%OFFLINE_ENV%' | ForEach-Object { $_.TrimEnd() } | Where-Object { $_ -notmatch '^\s*#' -and $_.Trim() -ne '' } | Set-Content -Encoding UTF8 -LiteralPath '%_ENVLINES_TMP%'"
if not exist "%_ENVLINES_TMP%" exit /b 0
type "%_ENVLINES_TMP%" | docker compose -f "%COMPOSE_FILE%" exec -T app sh -lc "cd /var/www/html; [ -f .env ] || { [ -f .env.example ] && cp .env.example .env || exit 0; }; sed -i 's/\r$//' .env 2>/dev/null || true; while IFS= read -r line; do case \"$line\" in ''|'#'*) continue;; esac; key=\"${line%%%%=*}\"; val=\"$(printf '%%s' \"${line#*=}\" | sed 's/[[:space:]]*$//')\"; tmpf=\"$(mktemp)\"; grep -v \"^${key}=\" .env > \"$tmpf\" 2>/dev/null || true; printf '%%s=%%s\n' \"$key\" \"$val\" >> \"$tmpf\"; mv \"$tmpf\" .env; done; php artisan config:clear >/dev/null 2>&1 || true"
del "%_ENVLINES_TMP%" >nul 2>&1
exit /b 0

:end
echo.
pause
