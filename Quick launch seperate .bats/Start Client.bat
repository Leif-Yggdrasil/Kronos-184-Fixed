@echo off
title Kronos - RuneLite Client
echo ========================================
echo   Kronos 184 - RuneLite Client
echo ========================================
echo.

set JAVA_HOME=C:\Users\User\.jdks\corretto-1.8.0_452
set PATH=%JAVA_HOME%\bin;%PATH%

echo Starting RuneLite Client...
echo.
java -jar "%~dp0Kronos-master\runelite\runelite-client\build\libs\runelite-client-1.5.37-SNAPSHOT-shaded.jar"
pause
