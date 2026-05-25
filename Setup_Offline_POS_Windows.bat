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

REM Load .env.offline values if present
set "OFFLINE_ENV=%PROJECT_DIR%.env.offline"
if exist "%OFFLINE_ENV%" (
  for /f "usebackq tokens=1,* delims==" %%A in ("%OFFLINE_ENV%") do (
    set "line=%%A"
    if not "!line:~0,1!"=="#" if not "%%A"=="" set "%%A=%%B"
  )
)

REM Resolve ZIP URL: replace APP_VERSION placeholder via API
if not defined APP_ZIP_URL set "APP_ZIP_URL=https://taxnomist.busywizzy.com/pos_APP_VERSION.zip"

echo Fetching latest app version from API...
set "_BODY_TMP=%TEMP%\pos_body_%RANDOM%.json"
set "_VER_TMP=%TEMP%\pos_ver_%RANDOM%.json"
powershell -NoProfile -Command "$body = ConvertTo-Json @{store_id = %OFFLINE_STORE_ID%; offline_token = '%OFFLINE_TOKEN%'}; [IO.File]::WriteAllText('%_BODY_TMP%', $body)"
curl.exe -s --ssl-no-revoke --location --request GET "%APP_VERSION_URL%" --header "Content-Type: application/json" --data @"%_BODY_TMP%" --output "%_VER_TMP%"
del "%_BODY_TMP%" >nul 2>&1
if not exist "%_VER_TMP%" (
  echo Error: API request failed. Check network connectivity and APP_VERSION_URL in .env.offline.
  goto :end
)
for /f "usebackq delims=" %%V in (`powershell -NoProfile -Command "(Get-Content -LiteralPath '%_VER_TMP%' -Raw | ConvertFrom-Json).POS_OFFLINE_BUNDLE_APP_VERSION"`) do set "RESOLVED_VERSION=%%V"
del "%_VER_TMP%" >nul 2>&1

if not defined RESOLVED_VERSION (
  echo Error: could not resolve app version from API.
  echo Check APP_VERSION_URL, OFFLINE_STORE_ID and OFFLINE_TOKEN in .env.offline.
  goto :end
)

echo Resolved version: %RESOLVED_VERSION%
set "APP_ZIP_URL=!APP_ZIP_URL:APP_VERSION=%RESOLVED_VERSION%!"

echo Using ZIP URL: %APP_ZIP_URL%

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
echo MySQL privileges granted for %DB_APP_USER%@%PCT%.

:after_grant
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
