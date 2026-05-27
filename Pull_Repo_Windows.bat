@echo off
setlocal enableextensions enabledelayedexpansion

set "SCRIPT_DIR=%~dp0"
set "SCRIPT_DIR=%SCRIPT_DIR:~0,-1%"

REM ── Load .env.offline ────────────────────────────────────────────────────────
set "OFFLINE_ENV=%SCRIPT_DIR%\.env.offline"
if not exist "%OFFLINE_ENV%" (
  REM If running from outside the repo, look one level up for a sibling .env.offline.
  for %%P in ("%SCRIPT_DIR%") do set "PARENT_DIR=%%~dpP"
  set "PARENT_DIR=!PARENT_DIR:~0,-1!"
  if exist "!PARENT_DIR!\.env.offline" set "OFFLINE_ENV=!PARENT_DIR!\.env.offline"
)
if not exist "%OFFLINE_ENV%" (
  echo Error: .env.offline not found. Expected at %SCRIPT_DIR%\.env.offline
  goto :end
)
for /f "usebackq delims=" %%L in (`powershell -NoProfile -Command "Get-Content -LiteralPath '%OFFLINE_ENV%' | ForEach-Object { $_.TrimEnd() } | Where-Object { $_ -notmatch '^\s*#' -and $_.Trim() -ne '' }"`) do (
  for /f "tokens=1,* delims==" %%A in ("%%L") do (
    if not "%%A"=="" set "%%A=%%B"
  )
)

REM ── Resolve repo settings from .env.offline ──────────────────────────────────
REM Required in .env.offline:
REM   GIT_REPO_URL  = https://github.com/gajendergce/offline-pos-system
REM   GIT_USERNAME  = <github username>
REM   GIT_TOKEN     = <github personal access token>

if not defined GIT_REPO_URL (
  echo Error: GIT_REPO_URL is not set in .env.offline
  goto :end
)
if not defined GIT_USERNAME (
  echo Error: GIT_USERNAME is not set in .env.offline
  goto :end
)
if not defined GIT_TOKEN (
  echo Error: GIT_TOKEN is not set in .env.offline
  goto :end
)

REM Build authenticated URL: https://username:token@github.com/...
REM Strip any existing scheme and inject credentials.
for /f "usebackq delims=" %%U in (`powershell -NoProfile -Command "$u='%GIT_REPO_URL%' -replace '^https?://(.*?@)?',''; 'https://%GIT_USERNAME%:%GIT_TOKEN%@' + $u"`) do set "AUTH_URL=%%U"

REM Derive repo name from the URL (last path segment, strip .git).
for /f "usebackq delims=" %%N in (`powershell -NoProfile -Command "([uri]'%GIT_REPO_URL%').Segments[-1] -replace '\.git$',''"`) do set "REPO_NAME=%%N"

REM ── Check git ───────────────────────────────────────────────────────────────
where git >nul 2>&1
if errorlevel 1 (
  echo Error: git is not installed or not in PATH.
  echo Download from https://git-scm.com/download/win and re-run this script.
  goto :end
)

REM ── Determine context ────────────────────────────────────────────────────────
REM Case 1: this bat lives inside the repo (already cloned) -> pull in place.
REM Case 2: a subfolder with the repo name exists           -> pull inside it.
REM Case 3: neither                                          -> clone here.

if exist "%SCRIPT_DIR%\.git" (
  set "WORK_DIR=%SCRIPT_DIR%"
  set "ACTION=pull"
  goto :do_action
)

if exist "%SCRIPT_DIR%\%REPO_NAME%\.git" (
  set "WORK_DIR=%SCRIPT_DIR%\%REPO_NAME%"
  set "ACTION=pull"
  goto :do_action
)

set "WORK_DIR=%SCRIPT_DIR%\%REPO_NAME%"
set "ACTION=clone"

:do_action
echo Repo    : %GIT_REPO_URL%
echo User    : %GIT_USERNAME%
echo Token   : ****
echo.

if "!ACTION!"=="clone" (
  echo Cloning into %WORK_DIR% ...
  git clone "!AUTH_URL!" "%WORK_DIR%"
  if errorlevel 1 (
    echo Error: git clone failed. Check GIT_USERNAME, GIT_TOKEN, and GIT_REPO_URL in .env.offline.
    goto :end
  )
  echo.
  echo Repository cloned successfully.
  echo Project folder: %WORK_DIR%
  echo.
  echo Next step: ensure .env.offline is inside the project folder, then run
  echo   Setup_Offline_POS_Windows.bat   ^(first-time Docker setup^)
  goto :end
)

REM ── Pull latest changes ──────────────────────────────────────────────────────
echo Updating repository at %WORK_DIR% ...
cd /d "%WORK_DIR%"
if errorlevel 1 (
  echo Error: cannot enter %WORK_DIR%
  goto :end
)

REM Ensure the remote uses the current (token-authenticated) URL.
git remote set-url origin "!AUTH_URL!" >nul 2>&1

for /f "usebackq delims=" %%B in (`git rev-parse --abbrev-ref HEAD 2^>nul`) do set "CURRENT_BRANCH=%%B"
echo Current branch : !CURRENT_BRANCH!
echo.

REM Stash any local uncommitted changes so the pull is clean.
git stash --quiet 2>nul

git pull --ff-only origin "!CURRENT_BRANCH!" 2>&1
if errorlevel 1 (
  echo.
  echo Warning: fast-forward pull failed ^(possible diverged history^).
  echo Fetching and resetting to origin/!CURRENT_BRANCH! ...
  git fetch origin
  git reset --hard "origin/!CURRENT_BRANCH!"
  if errorlevel 1 (
    echo Error: could not reset to origin/!CURRENT_BRANCH!. Check git status manually.
    goto :end
  )
)

REM Restore the remote URL to the plain (non-token) form so credentials
REM are not stored in .git/config in plaintext.
git remote set-url origin "%GIT_REPO_URL%" >nul 2>&1

echo.
echo Repository updated successfully.
echo.
echo Tip: if Docker containers are running, restart them to pick up any
echo      compose or Dockerfile changes:
echo   docker compose -f docker-compose.github.yml up -d --build

:end
echo.
pause
