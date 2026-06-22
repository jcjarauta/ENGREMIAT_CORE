# E01 Root Loop Router Surface Discovery

Estado: PASS
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Patched: NO
Readiness: 
100
ReadHost hits: 
3
Switch hits: 
3
Loop hits: 
1
ACTIONS observer: 
True
NAVIGATION observer: 
True
COMMAND_FEEDBACK observer: 
False

## Objetivo ROOT_LOOP_ROUTER_007
Aislar el bucle interactivo real del launcher para que feedback, ayuda, estado y mantenimiento se integren dentro del router correcto, no como observer externo.

## Top hits
### line 44 score 118 why read_host,switch,loop,unknown_feedback,function_call,flow_control
```powershell
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
```
### line 41 score 54 why read_host,function_call,flow_control
```powershell
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
```
### line 11 score 46 why read_host,flow_control
```powershell
    1: function Set-EngSafeProp($o,[string]$n,$v){
    2:   if($null -eq $o){throw "Set-EngSafeProp objeto nulo: $n"}
    3:   $p=$o.PSObject.Properties[$n]
    4:   if($p){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}
    5: }
    6: $ErrorActionPreference = "Stop"
    7: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
```
### line 13 score 30 why switch
```powershell
    3:   $p=$o.PSObject.Properties[$n]
    4:   if($p){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}
    5: }
    6: $ErrorActionPreference = "Stop"
    7: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
```
### line 25 score 30 why switch
```powershell
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
```
### line 9 score 16 why root_legend
```powershell
    1: function Set-EngSafeProp($o,[string]$n,$v){
    2:   if($null -eq $o){throw "Set-EngSafeProp objeto nulo: $n"}
    3:   $p=$o.PSObject.Properties[$n]
    4:   if($p){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}
    5: }
    6: $ErrorActionPreference = "Stop"
    7: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
```
### line 68 score 14 why function_call,flow_control
```powershell
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
   71:   }
   72: }
   73: # Integration note: existing launcher flow is intentionally preserved. Future router code can call Invoke-EngremiatOperatorV2ActionsBridgeDryRun before legacy fallback.
   74: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_END
   75: 
   76: 
```
### line 12 score 12 why actions_observer
```powershell
    2:   if($null -eq $o){throw "Set-EngSafeProp objeto nulo: $n"}
    3:   $p=$o.PSObject.Properties[$n]
    4:   if($p){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}
    5: }
    6: $ErrorActionPreference = "Stop"
    7: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
```
### line 24 score 12 why navigation_observer
```powershell
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
```
### line 16 score 8 why function_call
```powershell
    6: $ErrorActionPreference = "Stop"
    7: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
```
### line 17 score 8 why function_call
```powershell
    7: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
```
### line 31 score 8 why function_call
```powershell
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
```
### line 32 score 8 why function_call
```powershell
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
```
### line 42 score 8 why function_call
```powershell
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
```
### line 43 score 8 why function_call
```powershell
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
```
### line 61 score 8 why function_call
```powershell
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
   71:   }
   72: }
   73: # Integration note: existing launcher flow is intentionally preserved. Future router code can call Invoke-EngremiatOperatorV2ActionsBridgeDryRun before legacy fallback.
   74: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_END
   75: 
```
### line 73 score 8 why function_call
```powershell
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
   71:   }
   72: }
   73: # Integration note: existing launcher flow is intentionally preserved. Future router code can call Invoke-EngremiatOperatorV2ActionsBridgeDryRun before legacy fallback.
   74: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_END
   75: 
   76: 
```
### line 22 score 6 why flow_control
```powershell
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
   19: } catch {
   20:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; mode='DRY_RUN_ONLY'; reason='OBSERVER_ERROR' }
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_BEGIN
   25: # mode=DRY_RUN_ONLY navigation observer; legacy switch/router preserved
   26: try {
   27:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = $null
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
```
### line 38 score 6 why flow_control
```powershell
   28:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\navigation-launcher-bridge.ps1'
   29:   if(Test-Path $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE){
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
```
### line 40 score 6 why flow_control
```powershell
   30:     . $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_BRIDGE
   31:     if(Get-Command Invoke-EngNavigationLauncherInputDryRun -ErrorAction SilentlyContinue){
   32:       $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = Invoke-EngNavigationLauncherInputDryRun -InputText $input
   33:     }
   34:   }
   35: } catch {
   36:   $script:ENGREMIAT_OPERATOR_V2_NAVIGATION_LAST_DRYRUN = [pscustomobject]@{ ok=$false; handled=$false; executed=$false; real_execution=$false; mode='DRY_RUN_ONLY'; reason='NAV_OBSERVER_ERROR' }
   37: }
   38: # IMPORTANT: navigation observer does not continue/return; existing legacy flow remains active.
   39: # ENGREMIAT_OPERATOR_V2_NAVIGATION_OBSERVER_END
   40: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   41: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   42: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   43: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
```
### line 54 score 6 why flow_control
```powershell
   44: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
```
### line 55 score 6 why flow_control
```powershell
   45: 
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
```
### line 56 score 6 why flow_control
```powershell
   46: 
   47: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
```
### line 58 score 6 why flow_control
```powershell
   48: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   49: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   50: # mode=DRY_RUN_ONLY
   51: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   52: function Test-EngremiatOperatorV2ActionsBridge {
   53:   try {
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
   71:   }
   72: }
```
### line 64 score 6 why flow_control
```powershell
   54:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   55:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   56:     return $true
   57:   } catch {
   58:     return $false
   59:   }
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
   71:   }
   72: }
   73: # Integration note: existing launcher flow is intentionally preserved. Future router code can call Invoke-EngremiatOperatorV2ActionsBridgeDryRun before legacy fallback.
   74: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_END
   75: 
   76: 
```
### line 70 score 6 why flow_control
```powershell
   60: }
   61: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   62:   param([string]$InputText)
   63:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   64:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   65:   }
   66:   try {
   67:     . $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE
   68:     return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
   69:   } catch {
   70:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }
   71:   }
   72: }
   73: # Integration note: existing launcher flow is intentionally preserved. Future router code can call Invoke-EngremiatOperatorV2ActionsBridgeDryRun before legacy fallback.
   74: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_END
   75: 
   76: 
```

## Siguiente
E02_CREATE_ROOT_LOOP_ROUTER_CONTRACT_GUARDED_WRITE
