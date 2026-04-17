@echo off
REM Start All Services
REM This script starts both backend and frontend services

setlocal

set "SCRIPT_DIR=%~dp0"

echo ========================================
echo   Mine Monitor - Starting All Services
echo ========================================
echo.

echo [1/2] Starting Backend Server...
start "Mine Monitor - Backend" cmd /c "%SCRIPT_DIR%start-backend.bat"

timeout /t 3 /nobreak > nul

echo [2/2] Starting Frontend App...
start "Mine Monitor - Frontend" cmd /c "%SCRIPT_DIR%start-frontend.bat"

echo.
echo ========================================
echo   All services started!
echo   Backend: http://127.0.0.1:8080
echo ========================================
echo.
echo Close this window or press Ctrl+C to stop.
echo.

pause

endlocal
