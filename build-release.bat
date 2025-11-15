@echo off
REM Bearsampp Module Builder - Gradle
REM This script runs the Gradle build for module-mailpit

echo.
echo ========================================
echo Bearsampp Module Builder - Mailpit
echo ========================================
echo.

REM Check if Gradle is available
where gradle >nul 2>&1
if %ERRORLEVEL% EQU 0 (
    echo Using system Gradle...
    gradle releaseBuild
) else (
    echo Gradle not found in PATH
    echo Please install Gradle or use: gradlew releaseBuild
    pause
    exit /b 1
)

echo.
echo ========================================
echo Build Complete!
echo ========================================
echo.
pause
