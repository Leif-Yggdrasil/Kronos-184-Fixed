@echo off
title Kronos - Update Server
echo ========================================
echo   Kronos 184 - Update Server
echo ========================================
echo.

set "JAVA_HOME=C:\Users\User\.jdks\corretto-21.0.8"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "SERVER_DIR=%~dp0Kronos-master"

cd /d "%SERVER_DIR%"

echo Starting Update Server on port 7304...
echo.
call "%SERVER_DIR%\gradlew.bat" :kronos-update-server:run
pause
