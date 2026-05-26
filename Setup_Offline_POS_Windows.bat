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

REM Keep APP_ZIP_URL as a template (APP_VERSION placeholder intact) so the
REM container can resolve the version on every start and detect upgrades.
if not defined APP_ZIP_URL set "APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_APP_VERSION.zip"
if not defined APP_VERSION_URL set "APP_VERSION_URL=https://taxnomist.busywizzy.com/api/offline/version"

echo Using ZIP template: %APP_ZIP_URL%
echo Version API: %APP_VERSION_URL%

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

:end
echo.
pause
