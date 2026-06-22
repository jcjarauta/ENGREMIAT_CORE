param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function LastReport([string]$Dir){if(!(Test-Path $Dir)){return ""};$f=@(Get-ChildItem $Dir -File -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 1);if($f.Count -gt 0){return $f[0].FullName};return ""}
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
