$ErrorActionPreference = "Stop"

function New-EngremiatMaintenanceCard {
  param([string]$ScreenId,[string]$Route,[string]$Expected,[string]$Observed,[string]$ActionDone,[string]$Severity)
  $RootPath = "C:\ENGREMIAT_CORE"
  $Base = Join-Path $RootPath "documents\manual-screen-maintenance-cards"
  $Cards = Join-Path $Base "cards"
  $Queue = Join-Path $Base "MAINTENANCE_QUEUE.json"
  $Index = Join-Path $Base "MAINTENANCE_CARDS_INDEX.md"
  foreach($p in @($Base,$Cards)){ if(!(Test-Path $p)){ New-Item -ItemType Directory -Force -Path $p | Out-Null } }
  $Id = "MCARD-" + (Get-Date -Format "yyyyMMdd-HHmmss")
  if([string]::IsNullOrWhiteSpace($Severity)){ $Severity = "MEDIUM" }
  $CardPath = Join-Path $Cards ($Id + ".md")
  @("# " + $Id,"","## Identidad","- card_id: " + $Id,"- screen_id: " + $ScreenId,"- route: " + $Route,"- severity: " + $Severity,"- status: OPEN,"","## Evidencia humana","- expected: " + $Expected,"- observed: " + $Observed,"- action_done: " + $ActionDone,"","## Diagnostico inicial","- suspected_file: PENDING","- suspected_function: PENDING","- risk: " + $Severity,"","## Reparacion propuesta","- minimal_frontier: PENDING","- no_apply_first: yes","- rollback_needed: PENDING") | Set-Content -Encoding UTF8 $CardPath
  if(!(Test-Path $Index)){ @("# Indice tarjetas mantenimiento","","## Tarjetas") | Set-Content -Encoding UTF8 $Index }
  Add-Content -Encoding UTF8 $Index ("- OPEN | " + $Severity + " | " + $ScreenId + " | " + $Id + " | " + $CardPath)
  $Obj = [ordered]@{ card_id=$Id; screen_id=$ScreenId; route=$Route; severity=$Severity; status="OPEN"; expected=$Expected; observed=$Observed; action_done=$ActionDone; created_at=(Get-Date).ToString("s"); card_path=$CardPath }
  if(Test-Path $Queue){ try { $Q = Get-Content $Queue -Raw -Encoding UTF8 | ConvertFrom-Json } catch { $Q = $null } } else { $Q = $null }
  if($null -eq $Q){ $Q = [pscustomobject]@{ status="OPEN"; cards=@() } }
  $Arr = @($Q.cards); $Arr += $Obj; $Q.cards = $Arr; $Q | ConvertTo-Json -Depth 8 | Set-Content -Encoding UTF8 $Queue
  Write-Host ("OK tarjeta_mantenimiento_creada=" + $CardPath) -ForegroundColor Green
  return $CardPath
}

$Core = "C:\ENGREMIAT_CORE"
$LauncherDir = Join-Path $Core "tools\launcher"
$CardBase = Join-Path $Core "documents\module-cards"

function W($m,$c="Gray"){ try { Write-Host $m -ForegroundColor $c } catch { Write-Host $m } }

function RunPs1($p){
  if(!(Test-Path $p)){ W "NO_GO falta launcher: $p" Red; Read-Host "Enter"; return }
  & powershell -NoProfile -ExecutionPolicy Bypass -File $p
}

function Header(){
  Clear-Host
  W "==== ENGREMIAT / INICIO ====" Cyan
  W "Ruta: INICIO" DarkCyan
  W "Rol: hub humano principal del operador" DarkCyan
  W "Principio: local-first | workers OFF | worker real" DarkCyan
  W ""
  W "[1] Proyectos" White
  W "[2] Memoria y documentacion" White
  W "[3] Control y estado" White
  W "[4] Launchers y configuracion" White
  W "[5] Operador y workers" Yellow
  W "[6] Tarjetas" White
  W "[?] Ayuda" White
  W "[b/q] salir | m = mantenimiento | Enter = refrescar" DarkGray
}

function StatusPanel(){
  Clear-Host
  W "==== CONTROL Y ESTADO ====" Cyan
  W "Estado compacto del operador local." DarkCyan
  W ""
  $schema = Join-Path $CardBase "module-linked-card.schema.json"
  $index = Join-Path $CardBase "module-linked-card.index.json"
  $flow = Join-Path $CardBase "card-to-module-flow.json"
  $checker = Join-Path $Core "tools\module-cards\check-card-to-module-flow.ps1"
  $view = Join-Path $LauncherDir "ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1"
  W "OK entrada humana: .\ENGREMIAT.cmd" Green
  W "OK launchers: usar [4] para health" Green
  W "PAUSADO worker real: no ejecutar hasta cerrar operador" Yellow
  if((Test-Path $schema) -and (Test-Path $index) -and (Test-Path $flow) -and (Test-Path $checker)){
    W "OK canon tarjetas-modulos: schema + index + flow + checker" Green
    W "REGLA tarjetas: PROPOSED no ejecuta | human_gate=SI" Magenta
  } else {
    W "WARN canon tarjetas-modulos incompleto" Yellow
  }
  if(Test-Path $view){ W "OK vista tarjetas: [6] Tarjetas" Green } else { W "WARN vista tarjetas no enlazada" Yellow }
  W "FUTURO sistema vivo: autodiagnostico genera tarjetas PROPOSED, no acciones directas" Magenta
  W ""
  W "Siguiente recomendado: revisar Tarjetas o Launchers/configuracion." Cyan
  W ""
  W "[Enter] volver" DarkGray
  Read-Host | Out-Null
}

function LauncherTools(){
  while($true){
    Clear-Host
    W "==== LAUNCHERS Y CONFIGURACION ====" Cyan
    W "Ruta: INICIO > Launchers y configuracion" DarkCyan
    W ""
    W "[1] Health launchers" White
    W "[2] Helper update dry-run" White
    W "[3] Data Intake" White
    W "[b] volver | Enter = refrescar" DarkGray
    $x = Read-Host "CONFIG"
    if([string]::IsNullOrWhiteSpace($x)){ continue }
    switch($x.Trim().ToLowerInvariant()){
      "1" { RunPs1 (Join-Path $LauncherDir "ENGREMIAT-LAUNCHER-HEALTH.ps1"); Read-Host "Enter" | Out-Null }
      "2" { RunPs1 (Join-Path $LauncherDir "ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1"); Read-Host "Enter" | Out-Null }
      "3" { RunPs1 (Join-Path $LauncherDir "ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1") }
      "b" { return }
      "q" { return }
      default { W "Comando no reconocido" Yellow; Start-Sleep -Milliseconds 700 }
    }
  }
}

function WorkersPaused(){
  Clear-Host
  W "==== OPERADOR Y WORKERS ====" Cyan
  W "Estado: PAUSADO" Yellow
  W ""
  W "Worker real pausado tras E80." Yellow
  W "Siguiente solo cuando cerremos navegacion y control humano." Yellow
  W ""
  W "[Enter] volver" DarkGray
  Read-Host | Out-Null
}

function Help(){
  Clear-Host
  W "==== AYUDA / INICIO ====" Cyan
  W "Enter refresca la pantalla actual." DarkGray
  W "b/q vuelve o sale segun pantalla." DarkGray
  W "[1] Proyectos: cartera y acciones locales." Gray
  W "[2] Memoria/documentacion: conocimiento del sistema." Gray
  W "[3] Control y estado: resumen operativo y canon tarjetas-modulos." Gray
  W "[4] Launchers/configuracion: health y helper." Gray
  W "[5] Workers: pausado por seguridad." Gray
  W "[6] Tarjetas: vista readonly PROYECTO > MODULO > TARJETA." Gray
  W ""
  W "Futuro: Sistema vivo/autodiagnostico para proponer tarjetas PROPOSED vinculadas a modulos." Magenta
  W ""
  W "[Enter] volver" DarkGray
  Read-Host | Out-Null
}

function MaintenanceCardFromInicio(){
  Clear-Host
  W "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" Cyan
  W "Ruta: INICIO" DarkCyan
  W ""
  $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
  $exp = Read-Host "Esperado"
  $obs = Read-Host "Observado / que falla"
  $act = Read-Host "Accion realizada antes del fallo"
  New-EngremiatMaintenanceCard -ScreenId "S02_INICIO" -Route "INICIO" -Expected $exp -Observed $obs -ActionDone $act -Severity $sev | Out-Null
  Read-Host "Enter para volver a INICIO" | Out-Null
}

while($true){
  Header
  $c = Read-Host "INICIO"
  if([string]::IsNullOrWhiteSpace($c)){ continue }
  switch($c.Trim().ToLowerInvariant()){
    "1" { RunPs1 (Join-Path $LauncherDir "ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1") }
    "2" { RunPs1 (Join-Path $LauncherDir "ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1") }
    "3" { StatusPanel }
    "4" { LauncherTools }
    "5" { WorkersPaused }
    "6" { RunPs1 (Join-Path $LauncherDir "ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1") }
    "?" { Help }
    "7" { Help }
    "m" { MaintenanceCardFromInicio }
    "b" { break }
    "q" { break }
    default { W "Comando no reconocido" Yellow; Start-Sleep -Milliseconds 700 }
  }
}
