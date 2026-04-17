@echo off
REM Start Frontend Only
REM This script starts only the Electron frontend

setlocal

set "SCRIPT_DIR=%~dp0"
set "FRONTEND_DIR=%SCRIPT_DIR%frontend"

echo ========================================
echo   Mine Monitor - Frontend (Electron)
echo ========================================
echo.

cd /d "%FRONTEND_DIR%"

if not exist "node_modules" (
    echo [Frontend] Installing dependencies...
    call npm install
    echo.
)

echo [Frontend] Starting Electron app...
echo.
echo Press Ctrl+C to stop the app
echo.

call npm start

endlocal
