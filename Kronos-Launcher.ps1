# Kronos-Launcher.ps1 — Starts all Kronos services in a single terminal

$ErrorActionPreference = "Stop"
$Host.UI.RawUI.WindowTitle = "Kronos 184 - Launcher"

$root      = $PSScriptRoot
$server    = Join-Path $root "Kronos-master"
$java8     = "C:\Users\User\.jdks\corretto-1.8.0_452"
$java21    = "C:\Users\User\.jdks\corretto-21.0.8"
$clientJar = Join-Path $server "runelite\runelite-client\build\libs\runelite-client-1.5.37-SNAPSHOT-shaded.jar"

$script:procs = @()

# ── Helpers ─────────────────────────────────────────────────

function Stop-AllServices {
    Write-Host ""
    Write-Host "  Shutting down all services..." -ForegroundColor Yellow
    foreach ($p in $script:procs) {
        if ($p -and -not $p.HasExited) {
            & taskkill /T /F /PID $p.Id 2>$null | Out-Null
        }
    }
    Start-Sleep -Milliseconds 500
    Write-Host "  All services stopped." -ForegroundColor Green
}

function Test-Port([int]$port) {
    try {
        $tcp = New-Object Net.Sockets.TcpClient
        $tcp.Connect("127.0.0.1", $port)
        $tcp.Close()
        return $true
    } catch { return $false }
}

function Wait-ForPort([int]$port, [string]$name, [int]$timeout = 180) {
    $sw = [System.Diagnostics.Stopwatch]::StartNew()
    $dots = @('.   ', '..  ', '... ', '....')
    $i = 0
    while (-not (Test-Port $port)) {
        if ($sw.Elapsed.TotalSeconds -gt $timeout) {
            Write-Host ""
            Write-Host "        X $name failed to start (timeout after ${timeout}s)" -ForegroundColor Red
            return $false
        }
        $elapsed = [math]::Floor($sw.Elapsed.TotalSeconds)
        Write-Host "`r        Waiting for port $port $($dots[$i % 4]) ${elapsed}s  " -NoNewline -ForegroundColor DarkGray
        $i++
        Start-Sleep -Seconds 1
    }
    $elapsed = [math]::Round($sw.Elapsed.TotalSeconds, 1)
    Write-Host "`r        + Ready on port $port (${elapsed}s)                    " -ForegroundColor Green
    return $true
}

# ── Banner ──────────────────────────────────────────────────

Clear-Host
Write-Host ""
Write-Host "  ==========================================" -ForegroundColor Cyan
Write-Host "        K R O N O S   1 8 4                 " -ForegroundColor Cyan
Write-Host "  ==========================================" -ForegroundColor Cyan
Write-Host ""

# ── 1. Update Server ───────────────────────────────────────

Write-Host "  [1/3] " -ForegroundColor Yellow -NoNewline
Write-Host "Update Server" -ForegroundColor White

$p = Start-Process cmd.exe -ArgumentList "/c cd /d `"$server`" && set `"JAVA_HOME=$java21`" && set `"PATH=$java21\bin;%PATH%`" && `"$server\gradlew.bat`" :kronos-update-server:run" -WindowStyle Hidden -PassThru
$script:procs += $p

if (-not (Wait-ForPort 7304 "Update Server")) {
    Stop-AllServices
    Read-Host "  Press Enter to exit"
    exit 1
}
Write-Host ""

# ── 2. Game Server ─────────────────────────────────────────

Write-Host "  [2/3] " -ForegroundColor Yellow -NoNewline
Write-Host "Game Server" -ForegroundColor White

$p = Start-Process cmd.exe -ArgumentList "/c cd /d `"$server`" && set `"JAVA_HOME=$java21`" && set `"PATH=$java21\bin;%PATH%`" && `"$server\gradlew.bat`" :kronos-server:run" -WindowStyle Hidden -PassThru
$script:procs += $p

if (-not (Wait-ForPort 13302 "Game Server")) {
    Stop-AllServices
    Read-Host "  Press Enter to exit"
    exit 1
}
Write-Host ""

# ── 3. Client ──────────────────────────────────────────────

Write-Host "  [3/3] " -ForegroundColor Yellow -NoNewline
Write-Host "RuneLite Client" -ForegroundColor White

$p = Start-Process "$java8\bin\javaw.exe" -ArgumentList "-jar `"$clientJar`"" -PassThru
$script:procs += $p

Write-Host "        + Client launched!" -ForegroundColor Green
Write-Host ""

# ── Status Dashboard ───────────────────────────────────────

Write-Host "  ==========================================" -ForegroundColor Green
Write-Host "        All Services Running                " -ForegroundColor Green
Write-Host "  ------------------------------------------" -ForegroundColor DarkGreen
Write-Host "   Update Server    port 7304       [UP]" -ForegroundColor White
Write-Host "   Game Server      port 13302      [UP]" -ForegroundColor White
Write-Host "   RuneLite Client                  [UP]" -ForegroundColor White
Write-Host "  ==========================================" -ForegroundColor Green
Write-Host ""
Write-Host "  Press any key to stop all services" -ForegroundColor DarkGray
Write-Host ""

# ── Monitor ────────────────────────────────────────────────

[Console]::TreatControlCAsInput = $true

while ($true) {
    if ([Console]::KeyAvailable) {
        $null = [Console]::ReadKey($true)
        break
    }

    $running = ($script:procs | Where-Object { -not $_.HasExited }).Count
    if ($running -eq 0) {
        Write-Host "  All processes have exited." -ForegroundColor Yellow
        break
    }

    Start-Sleep -Milliseconds 500
}

Stop-AllServices
Read-Host "  Press Enter to close"
