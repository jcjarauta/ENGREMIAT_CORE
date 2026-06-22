function Set-EngSafeProp($o,[string]$n,$v){
  if($null -eq $o){throw "Set-EngSafeProp objeto nulo: $n"}
  $p=$o.PSObject.Properties[$n]
  if($p){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}
}
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$Root = "C:\ENGREMIAT_CORE"
$CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
# ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
# mode=DRY_RUN_ONLY observer; legacy switch/router preserved
try {
  $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
  if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
    $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
  }
} catch {
  $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
}
# IMPORTANT: no continue/return here; existing legacy flow remains active.
# ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
# ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
# mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
try {
  $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
  $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
  if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
    . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
    if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
      $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
    }
  }
} catch {
  $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
}
# IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
# ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W "[6] Estado vivo V2" White; W "[7] Siguiente accion V2" White; W "[8] Panel control V2" White; W "[9] Close & Sync V2" White; W ""; W $CommonCommandLegend DarkGray; W "" }
while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\operator-v1\operator-v1-home-screen.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\operator-v1\operator-v1-projects-screen.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "6" { Run-Screen "Estado vivo V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-state-screen.ps1" } "v" { Run-Screen "Estado vivo V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-state-screen.ps1" } "7" { Run-Screen "Siguiente accion V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-next-action-screen.ps1" } "s" { Run-Screen "Siguiente accion V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-next-action-screen.ps1" } "8" { Run-Screen "Panel control V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-control-panel.ps1" } "p" { Run-Screen "Panel control V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-control-panel.ps1" } "9" { Run-Screen "Close & Sync V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-close-sync-screen.ps1" } "c" { Run-Screen "Close & Sync V2" "C:\ENGREMIAT_CORE\tools\operator-v2\operator-v2-close-sync-screen.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }


# ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
# package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
# stage=E08_R2 no-plus parse-safe guarded minimal bind
# mode=DRY_RUN_ONLY
$script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
function Test-EngremiatOperatorV2ActionsBridge {
  try {
    if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
    if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
    return $true
  } catch {
    return $false
  }
}
function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
  param([string]$InputText)
  if(!(Test-EngremiatOperatorV2ActionsBridge)){
    return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
  }
  try {
    . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
    return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
  } catch {
    return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
  }
}
# Integration note: existing launcher flow is intentionally preserved. Future router code can call Invoke-EngremiatOperatorV2ActionsBridgeDryRun before legacy fallback.
# ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_END








