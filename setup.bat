@echo off
echo ==========================================
echo Weekly Activity Report - Setup Script
echo ==========================================
echo.

REM Check if Node.js is installed
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo X Node.js tidak ditemukan. Silakan install Node.js terlebih dahulu.
    echo Download dari: https://nodejs.org/
    pause
    exit /b 1
)

echo [OK] Node.js version:
node --version
echo [OK] npm version:
npm --version
echo.

REM Install frontend dependencies
echo [*] Installing frontend dependencies...
call npm install
if %ERRORLEVEL% EQU 0 (
    echo [OK] Frontend dependencies installed successfully
) else (
    echo [X] Failed to install frontend dependencies
    pause
    exit /b 1
)

echo.

REM Install backend dependencies
echo [*] Installing backend dependencies...
call npm install express pg cors dotenv
if %ERRORLEVEL% EQU 0 (
    echo [OK] Backend dependencies installed successfully
) else (
    echo [X] Failed to install backend dependencies
    pause
    exit /b 1
)

echo.

REM Create .env file if not exists
if not exist .env (
    echo [*] Creating .env file...
    copy .env.example .env
    echo [!] Please edit .env file with your database credentials
) else (
    echo [i] .env file already exists
)

echo.
echo ==========================================
echo [OK] Setup completed successfully!
echo ==========================================
echo.
echo Next steps:
echo 1. Edit .env file with your database configuration
echo 2. Run 'node server.js' to start backend server
echo 3. Run 'npm run dev' to start frontend development server
echo.
echo Or run both with: npm run dev:all (after installing concurrently)
echo.
pause
