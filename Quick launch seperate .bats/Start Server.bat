@echo off
title Kronos - Game Server
echo ========================================
echo   Kronos 184 - Game Server
echo ========================================
echo.

set "JAVA_HOME=C:\Users\User\.jdks\corretto-21.0.8"
set "PATH=%JAVA_HOME%\bin;%PATH%"
set "SERVER_DIR=%~dp0Kronos-master"

cd /d "%SERVER_DIR%"

echo Starting Game Server on port 13302...
echo.
call "%SERVER_DIR%\gradlew.bat" :kronos-server:run
pause
