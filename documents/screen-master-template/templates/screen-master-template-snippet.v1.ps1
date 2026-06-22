function OpenContextualMaintenanceCard {
  param([string]$ScreenId,[string]$Route)
  Clear-Host
  Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
  Write-Host ("Ruta: " + $Route) -ForegroundColor DarkCyan
  Write-Host "Cancelar: b / q / c / cancelar" -ForegroundColor DarkGray
  Write-Host ""
  $cancelTokens = @("b","q","c","cancelar","cancel","salir")
  $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
  if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  $exp = Read-Host "Esperado"
  if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  $obs = Read-Host "Observado / que falla"
  if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  $act = Read-Host "Accion realizada antes del fallo"
  if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
  if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }
  if([string]::IsNullOrWhiteSpace($obs)){ $obs = "PENDING" }
  if([string]::IsNullOrWhiteSpace($act)){ $act = "PENDING" }
  New-EngremiatMaintenanceCard -ScreenId $ScreenId -Route $Route -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
  Read-Host "Enter para volver" | Out-Null
}

function ShowScreenTemplateExample {
  param([string]$ScreenId="SCREEN_ID",[string]$Route="RUTA")
  while($true){
    Clear-Host
    Write-Host "==== TITULO PANTALLA ====" -ForegroundColor Cyan
    Write-Host ("Ruta: " + $Route) -ForegroundColor DarkCyan
    Write-Host "[?] Ayuda" -ForegroundColor White
    Write-Host "[b/q] volver | m = mantenimiento | Enter = refrescar" -ForegroundColor DarkGray
    $cmd = Read-Host "COMANDO"
    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    switch($cmd.Trim().ToLowerInvariant()){
      "m" { OpenContextualMaintenanceCard -ScreenId $ScreenId -Route $Route }
      "?" { Write-Host "Ayuda contextual pendiente" -ForegroundColor Cyan; Read-Host "Enter" | Out-Null }
      "b" { return }
      "q" { return }
      default { Write-Host "Comando no reconocido" -ForegroundColor Yellow; Start-Sleep -Milliseconds 700 }
    }
  }
}
