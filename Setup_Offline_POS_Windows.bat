@echo off
setlocal enableextensions enabledelayedexpansion

set "PROJECT_DIR=%~dp0"
set "COMPOSE_FILE=%PROJECT_DIR%docker-compose.github.yml"

set "APP_SYNC_ZIP_ON_START=1"
set "DB_DATABASE=agrtl_offline"
set "DB_PASSWORD=root123"
set "DB_APP_USER=app"
set "DB_APP_PASSWORD=app123"
set "DB_PORT_HOST=3308"

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

echo Starting full offline setup...
echo Project root: %PROJECT_DIR%
echo Compose file: %COMPOSE_FILE%

REM Load .env.offline values if present.
REM Use PowerShell to read the file so CRLF line endings are stripped
REM automatically -- a trailing \r on any value corrupts API calls and URLs.
set "OFFLINE_ENV=%PROJECT_DIR%.env.offline"
if exist "%OFFLINE_ENV%" (
  for /f "usebackq delims=" %%L in (`powershell -NoProfile -Command "Get-Content -LiteralPath '%OFFLINE_ENV%' | ForEach-Object { $_.TrimEnd() } | Where-Object { $_ -notmatch '^\s*#' -and $_.Trim() -ne '' }"`) do (
    for /f "tokens=1,* delims==" %%A in ("%%L") do (
      if not "%%A"=="" set "%%A=%%B"
    )
  )
)

REM ── Validate required credentials ───────────────────────────────────────────
if not defined POS_OFFLINE_SYNC_STORE_ID (
  echo Error: POS_OFFLINE_SYNC_STORE_ID is required in .env.offline
  goto :end
)
if not defined POS_OFFLINE_SYNC_TOKEN (
  echo Error: POS_OFFLINE_SYNC_TOKEN is required in .env.offline
  goto :end
)
if not defined POS_OFFLINE_SYNC_SOURCE_URL (
  echo Error: POS_OFFLINE_SYNC_SOURCE_URL is required in .env.offline
  goto :end
)

REM ── Auto-derive APP_VERSION_URL ──────────────────────────────────────────────
if not defined APP_VERSION_URL (
  for /f "usebackq delims=" %%U in (`powershell -NoProfile -Command "'%POS_OFFLINE_SYNC_SOURCE_URL%'.TrimEnd('/') + '/api/offline/version'"`) do set "APP_VERSION_URL=%%U"
)
echo Version API: %APP_VERSION_URL%

REM ── Fetch version + ZIP URL from API ────────────────────────────────────────
echo Fetching app version from API...
set "_BODY_TMP=%TEMP%\pos_setup_body_%RANDOM%.json"
set "_VER_TMP=%TEMP%\pos_setup_ver_%RANDOM%.json"
powershell -NoProfile -Command "$body = ConvertTo-Json @{store_id = [int]%POS_OFFLINE_SYNC_STORE_ID%; offline_token = '%POS_OFFLINE_SYNC_TOKEN%'}; [IO.File]::WriteAllText('%_BODY_TMP%', $body)"
curl.exe -s --ssl-no-revoke --location --request GET "%APP_VERSION_URL%" --header "Content-Type: application/json" --data @"%_BODY_TMP%" --output "%_VER_TMP%"
del "%_BODY_TMP%" >nul 2>&1

set "SETUP_VERSION="
set "FETCHED_ZIP_URL="
if exist "%_VER_TMP%" (
  for /f "usebackq delims=" %%V in (`powershell -NoProfile -Command "$j=Get-Content -LiteralPath '%_VER_TMP%' -Raw|ConvertFrom-Json; if($j.POS_OFFLINE_BUNDLE_APP_VERSION){$j.POS_OFFLINE_BUNDLE_APP_VERSION.Trim()}elseif($j.version){$j.version.Trim()}else{''}"`) do set "SETUP_VERSION=%%V"
  for /f "usebackq delims=" %%Z in (`powershell -NoProfile -Command "$j=Get-Content -LiteralPath '%_VER_TMP%' -Raw|ConvertFrom-Json; if($j.POS_OFFLINE_ZIP_URL){$j.POS_OFFLINE_ZIP_URL.Trim()}else{''}"`) do set "FETCHED_ZIP_URL=%%Z"
  del "%_VER_TMP%" >nul 2>&1
)

if defined SETUP_VERSION echo App version  : %SETUP_VERSION%

REM Resolve the ZIP URL: prefer API response, fall back to template.
set "RESOLVED_ZIP=!FETCHED_ZIP_URL!"
if "!RESOLVED_ZIP!"=="" (
  if defined APP_ZIP_URL (
    set "RESOLVED_ZIP=!APP_ZIP_URL:APP_VERSION=%SETUP_VERSION%!"
  )
)
if "!RESOLVED_ZIP!"=="" (
  echo Error: ZIP URL not returned by API and APP_ZIP_URL not set in .env.offline.
  goto :end
)
echo ZIP URL       : !RESOLVED_ZIP!

REM ── Check ZIP availability ───────────────────────────────────────────────────
echo Checking ZIP availability...
for /f "usebackq delims=" %%C in (`curl.exe -s -o nul -w "%%{http_code}" --head --ssl-no-revoke "!RESOLVED_ZIP!" 2^>nul`) do set "_ZIP_HTTP=%%C"
if "!_ZIP_HTTP!"=="200" goto :zip_ok
if "!_ZIP_HTTP!"=="206" goto :zip_ok
if "!_ZIP_HTTP!"=="301" goto :zip_ok
if "!_ZIP_HTTP!"=="302" goto :zip_ok
echo Error: ZIP not reachable at !RESOLVED_ZIP! ^(HTTP !_ZIP_HTTP!^). Check your network and credentials.
goto :end
:zip_ok
echo ZIP is available ^(HTTP !_ZIP_HTTP!^).

set "APP_ZIP_URL=!RESOLVED_ZIP!"

docker compose -f "%COMPOSE_FILE%" up -d --build
if errorlevel 1 (
  echo.
  echo Setup failed while running Docker Compose.
  goto :end
)

REM Wait for MySQL to accept connections, then guarantee app-user host access.
REM MySQL skips re-init when the data volume already exists, so MYSQL_USER env
REM is ignored on subsequent runs -- an explicit GRANT is the reliable fix.
echo Waiting for MySQL to be ready...
set /a _MYSQL_TRIES=0
:mysql_wait
docker compose -f "%COMPOSE_FILE%" exec -T db mysqladmin -uroot "-p%DB_PASSWORD%" ping --silent >nul 2>&1
if not errorlevel 1 goto :mysql_ready
set /a _MYSQL_TRIES+=1
if %_MYSQL_TRIES% geq 30 (
  echo MySQL did not become ready in time -- skipping privilege grant.
  goto :after_grant
)
powershell -NoProfile -Command "Start-Sleep -Seconds 2" >nul
goto :mysql_wait

:mysql_ready
set "PCT=%%"
docker compose -f "%COMPOSE_FILE%" exec -T db mysql -uroot "-p%DB_PASSWORD%" -e "GRANT ALL PRIVILEGES ON %DB_DATABASE%.* TO '%DB_APP_USER%'@'%PCT%' IDENTIFIED BY '%DB_APP_PASSWORD%'; FLUSH PRIVILEGES;" >nul 2>&1
if errorlevel 1 (
  echo.
  echo WARNING: Could not grant MySQL privileges -- root password mismatch.
  echo The mysql_data volume likely has data from a previous run with a different password.
  echo To fix, stop everything and wipe volumes, then re-run this script:
  echo   docker compose -f "%COMPOSE_FILE%" down -v
  echo.
) else (
  echo MySQL privileges granted for %DB_APP_USER%@%PCT%.
)

:after_grant

REM Wait for .env to appear inside the app container.
REM It is created right after the ZIP is extracted -- well before composer finishes.
echo Waiting for app to initialise...
set /a _ENV_TRIES=0
:env_wait
docker compose -f "%COMPOSE_FILE%" exec -T app sh -c "test -f /var/www/html/.env" >nul 2>&1
if not errorlevel 1 goto :env_ready
set /a _ENV_TRIES+=1
if %_ENV_TRIES% geq 150 (
  echo WARNING: .env not ready after 5 minutes -- proceeding anyway.
  goto :after_key
)
powershell -NoProfile -Command "Start-Sleep -Seconds 2" >nul
goto :env_wait

:env_ready
REM Generate APP_KEY using PHP built-ins (random_bytes + base64_encode).
REM php artisan key:generate cannot be used: it boots Laravel which throws the
REM same "no key" exception before the command can set one -- a catch-22.
REM PHP built-ins need nothing beyond the PHP binary itself (no vendor, no artisan).
echo Generating encryption key...
docker compose -f "%COMPOSE_FILE%" exec -T app php -r "$e=file_get_contents('/var/www/html/.env');if(preg_match('/^APP_KEY=\S/m',$e))exit;$k='base64:'.base64_encode(random_bytes(32));$e=preg_match('/^APP_KEY=/m',$e)?preg_replace('/^APP_KEY=.*/m','APP_KEY='.$k,$e):$e.chr(10).'APP_KEY='.$k;file_put_contents('/var/www/html/.env',$e);" 2>nul

:after_key
echo Waiting for app endpoint to become ready...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ok=$false; for($i=0;$i -lt 90;$i++){ try { $resp = Invoke-WebRequest -Uri 'http://localhost:8080/login' -MaximumRedirection 0 -ErrorAction Stop; if($resp.StatusCode -eq 200 -or $resp.StatusCode -eq 302){ $ok=$true; break } } catch { if($_.Exception.Response -and ($_.Exception.Response.StatusCode.Value__ -eq 302)){ $ok=$true; break } }; Start-Sleep -Seconds 2 }; if($ok){ exit 0 } else { exit 1 }"
if errorlevel 1 (
  echo Setup finished, but app is not ready yet.
  echo Run: docker compose -f "%COMPOSE_FILE%" logs --tail=200 app web
  goto :end
)

echo Setup complete. App is reachable at http://localhost:8080/login

REM ── Stamp installed version ─────────────────────────────────────────────────
if defined SETUP_VERSION (
  docker compose -f "%COMPOSE_FILE%" exec -T app sh -lc "cd /var/www/html; if [ -f .env ]; then if grep -q '^POS_OFFLINE_BUNDLE_APP_VERSION=' .env; then sed -i 's|^POS_OFFLINE_BUNDLE_APP_VERSION=.*|POS_OFFLINE_BUNDLE_APP_VERSION=%SETUP_VERSION%|' .env; else echo 'POS_OFFLINE_BUNDLE_APP_VERSION=%SETUP_VERSION%' >> .env; fi; fi; printf '%%s' '%SETUP_VERSION%' > .zip_sync_version" >nul 2>&1
  echo Stamped installed version ^(%SETUP_VERSION%^) into .env and .zip_sync_version.
)

:end
echo.
pause
