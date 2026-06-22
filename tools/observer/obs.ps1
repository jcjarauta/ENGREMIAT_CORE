param(
  [string]$Command = "status",
  [int]$DurationSeconds = 120
)
$ErrorActionPreference = "Stop"
$Root = "C:\ENGREMIAT_CORE"
$Observer = Join-Path $Root "tools\observer\engremiat-observer.ps1"
$Watcher = Join-Path $Root "tools\observer\engremiat-observer-watch.ps1"
$LatestObserverJson = Join-Path $Root "reports\observer\latest-observer.json"
$LatestObserverMd = Join-Path $Root "reports\observer\latest-observer.md"
$WatchState = Join-Path $Root "memory\development\watch-state.json"
$Timeline = Join-Path $Root "memory\development\timeline.md"

function ReadJson($Path) {
  try {
    if (Test-Path -LiteralPath $Path) {
      return Get-Content -LiteralPath $Path -Raw | ConvertFrom-Json
    }
  } catch {}
  return $null
}

function ShowHelp {
  Write-Host "==== ENGREMIAT OBSERVER ===="
  Write-Host ""
  Write-Host "status   Ver estado observer/watch"
  Write-Host "run      Ejecutar observer puntual readonly"
  Write-Host "watch    Escuchar cambios durante una ventana corta"
  Write-Host "open     Abrir latest observer md"
  Write-Host "timeline Abrir timeline de memoria"
  Write-Host "help     Mostrar ayuda"
}

switch ($Command.ToLowerInvariant()) {
  "run" {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $Observer
    if ($LASTEXITCODE -ne 0) { throw "observer run failed" }
  }
  "watch" {
    & powershell -NoProfile -ExecutionPolicy Bypass -File $Watcher -Watch -DurationSeconds $DurationSeconds
    if ($LASTEXITCODE -ne 0) { throw "observer watch failed" }
  }
  "open" {
    if (Test-Path -LiteralPath $LatestObserverMd) { Invoke-Item $LatestObserverMd } else { Write-Host "NO latest observer md: $LatestObserverMd" }
  }
  "timeline" {
    if (Test-Path -LiteralPath $Timeline) { Invoke-Item $Timeline } else { Write-Host "NO timeline: $Timeline" }
  }
  "help" {
    ShowHelp
  }
  default {
    $obs = ReadJson $LatestObserverJson
    $watch = ReadJson $WatchState
    Write-Host "==== ENGREMIAT OBSERVER STATUS ===="
    Write-Host ""
    if ($obs) {
      Write-Host ("observer_status=" + $obs.status)
      Write-Host ("observer_needs=" + @($obs.needs).Count)
      Write-Host ("latest_observer=" + $LatestObserverJson)
    } else {
      Write-Host "observer_status=NO_LATEST"
    }
    if ($watch) {
      Write-Host ("watch_status=" + $watch.status)
      Write-Host ("watch_tracked=" + $watch.tracked_files)
      Write-Host ("watch_changes=" + $watch.changes_count)
      Write-Host ("watch_state=" + $WatchState)
    } else {
      Write-Host "watch_status=NO_STATE"
    }
    Write-Host ""
    Write-Host "Comandos:"
    Write-Host "  obs.ps1 run"
    Write-Host "  obs.ps1 watch -DurationSeconds 120"
    Write-Host "  obs.ps1 open"
    Write-Host "  obs.ps1 timeline"
  }
}
