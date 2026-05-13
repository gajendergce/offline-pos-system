@echo off
setlocal enableextensions

set "PROJECT_DIR=%~dp0"
set "DEFAULT_ZIP_URL=http://taxnomist.busywizzy.com/pos_1.0.zip"
set "DEFAULT_VERSION_URL="
set "DEFAULT_TARGET_VERSION="
set "COMPOSE_FILE=%PROJECT_DIR%docker-compose.github.yml"

set "APP_ZIP_URL=%DEFAULT_ZIP_URL%"
set "APP_SYNC_ZIP_ON_START=1"
if not defined APP_VERSION_URL set "APP_VERSION_URL=%DEFAULT_VERSION_URL%"
if not defined APP_TARGET_VERSION set "APP_TARGET_VERSION=%DEFAULT_TARGET_VERSION%"
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

docker compose -f "%COMPOSE_FILE%" up -d --build
if errorlevel 1 (
  echo.
  echo Setup failed while running Docker Compose.
  goto :end
)

echo Waiting for app endpoint to become ready...
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ok=$false; for($i=0;$i -lt 90;$i++){ try { $resp = Invoke-WebRequest -Uri 'http://localhost:8080/login' -MaximumRedirection 0 -ErrorAction Stop; if($resp.StatusCode -eq 200 -or $resp.StatusCode -eq 302){ $ok=$true; break } } catch { if($_.Exception.Response -and ($_.Exception.Response.StatusCode.Value__ -eq 302)){ $ok=$true; break } }; Start-Sleep -Seconds 2 }; if($ok){ exit 0 } else { exit 1 }"
if errorlevel 1 (
  echo Setup finished, but app is not ready yet.
  echo Run: docker compose -f "%COMPOSE_FILE%" logs --tail=200 app web
  goto :end
)

echo Setup complete. App is reachable at http://localhost:8080/login
echo Tip: ZIP sync runs once on first startup and skips on restart.
echo Tip: if APP_VERSION_URL is configured, ZIP sync happens only when API version changes.
echo To force sync every start, set APP_SYNC_ZIP_ON_START=always before compose up.

:end
echo.
pause
