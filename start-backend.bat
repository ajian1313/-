@echo off
REM Start Backend Server Only
REM This script starts only the Rust backend server

setlocal

set "SCRIPT_DIR=%~dp0"
set "BACKEND_DIR=%SCRIPT_DIR%backend"

echo ========================================
echo   Mine Monitor - Backend Server
echo ========================================
echo.

cd /d "%BACKEND_DIR%"

echo [Backend] Starting Rust server...
echo [Backend] Server will run on: http://127.0.0.1:8080
echo.
echo Press Ctrl+C to stop the server
echo.

cargo run

endlocal
