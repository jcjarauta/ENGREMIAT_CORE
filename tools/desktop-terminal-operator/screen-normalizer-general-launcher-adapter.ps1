Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference = "Stop"
function W($m,$c="Gray"){ Write-Host $m -ForegroundColor $c }
$Root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$Base = Join-Path $Root "documents\screen-normalizer-general-launcher-menu-router-integration-gate"
$Reports = Join-Path $Root "reports\screen-normalizer-general-launcher-menu-router-integration-gate"
$Close = Join-Path $Base "close"
W "==== SCREEN NORMALIZER ADAPTER ====" Cyan
W "Modo: SAFE_READONLY_NO_DANGER" Yellow
W ("Root: " + $Root) DarkGray
W ("Base: " + $Base) DarkGray
W "" Gray
if (Test-Path $Close) {
  W "CIERRES DISPONIBLES:" Cyan
  Get-ChildItem $Close -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 8 | ForEach-Object { W (" - " + $_.Name + "  " + $_.LastWriteTime.ToString("yyyy-MM-dd HH:mm:ss")) Gray }
} else {
  W "WARN close_dir_missing" Yellow
}
W "" Gray
if (Test-Path $Reports) {
  $latest = Get-ChildItem $Reports -File -Filter "*.json" -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  if ($latest) {
    W ("ULTIMO REPORTE: " + $latest.FullName) Green
    try {
      $j = Get-Content $latest.FullName -Raw -Encoding UTF8 | ConvertFrom-Json
      W ("decision=" + $j.decision + " next=" + $j.next) Cyan
    } catch {
      W ("WARN no se pudo leer JSON: " + $_.Exception.Message) Yellow
    }
  } else {
    W "WARN no_reports_found" Yellow
  }
} else {
  W "WARN reports_dir_missing" Yellow
}
W "" Gray
W "ACCIONES REALES: ninguna. Este adapter solo muestra estado y evidencia local." Yellow
W "NEXT recomendado: E08_SMOKE_LAUNCHER_OPTION_10_MANUAL_NO_DANGER" Magenta

