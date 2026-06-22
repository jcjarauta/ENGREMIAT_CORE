# E01 Navigation Surface Discovery

Estado: PASS
Launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Parse OK: SI
Regex fragile avoided: SI

## Markers
- actions_minimal_bind: True
- actions_observer_bind: True
- enter_refresh_hint: True
- back_quit_hint: True
- help_hint: True

## Commands detected
- ?
- [1]
- [2]
- [3]
- [4]
- [5]
- ayuda
- b/q
- e =
- e=
- Enter
- help
- m =
- refrescar
- salir
- volver

## Top navigation candidates
### line 28 score 14 why Read-Host,switch,refresh,help
```powershell
   25: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   26: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   27: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   28: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   29: 
   30: 
   31: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   32: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   33: # stage=E08_R2 no-plus parse-safe guarded minimal bind
```
### line 11 score 10 why Read-Host,refresh,back_quit,function
```powershell
    8: $Root = "C:\ENGREMIAT_CORE"
    9: $CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
```
### line 26 score 7 why refresh,back_quit,help,function
```powershell
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   25: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   26: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   27: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   28: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   29: 
   30: 
   31: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
```
### line 9 score 6 why refresh,back_quit,help
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
```
### line 25 score 6 why Read-Host,function
```powershell
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   25: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   26: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   27: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   28: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   29: 
   30: 
```
### line 13 score 5 why switch
```powershell
   10: function W([string]$Text,[string]$Color="Gray"){ Write-Host $Text -ForegroundColor $Color }
   11: function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
   12: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_BEGIN
   13: # mode=DRY_RUN_ONLY observer; legacy switch/router preserved
   14: try {
   15:   $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = $null
   16:   if(Get-Command Invoke-EngremiatOperatorV2ActionsBridgeDryRun -ErrorAction SilentlyContinue){
   17:     $script:ENGREMIAT_OPERATOR_V2_ACTIONS_LAST_DRYRUN = Invoke-EngremiatOperatorV2ActionsBridgeDryRun -InputText $input
   18:   }
```
### line 10 score 4 why menu_option,function
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
```
### line 1 score 1 why function
```powershell
    1: function Set-EngSafeProp($o,[string]$n,$v){
    2:   if($null -eq $o){throw "Set-EngSafeProp objeto nulo: $n"}
    3:   $p=$o.PSObject.Properties[$n]
    4:   if($p){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}
    5: }
    6: $ErrorActionPreference = "Stop"
```
### line 24 score 1 why function
```powershell
   21: }
   22: # IMPORTANT: no continue/return here; existing legacy flow remains active.
   23: # ENGREMIAT_OPERATOR_V2_ACTIONS_ROUTER_OBSERVER_END
   24: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   25: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   26: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   27: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   28: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   29: 
```
### line 27 score 1 why function
```powershell
   24: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   25: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   26: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   27: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   28: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   29: 
   30: 
   31: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   32: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
```
### line 36 score 1 why function
```powershell
   33: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   34: # mode=DRY_RUN_ONLY
   35: $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE = 'C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1'
   36: function Test-EngremiatOperatorV2ActionsBridge {
   37:   try {
   38:     if([string]::IsNullOrWhiteSpace($script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   39:     if(!(Test-Path $script:ENGREMIAT_OPERATOR_V2_ACTIONS_BRIDGE)){ return $false }
   40:     return $true
   41:   } catch {
```
### line 45 score 1 why function
```powershell
   42:     return $false
   43:   }
   44: }
   45: function Invoke-EngremiatOperatorV2ActionsBridgeDryRun {
   46:   param([string]$InputText)
   47:   if(!(Test-EngremiatOperatorV2ActionsBridge)){
   48:     return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
   49:   }
   50:   try {
```

## Next
E02 crear contrato NAVIGATION_COMMANDS.json con comandos comunes: Enter/refrescar, f5, ?, b/q, m, e y fallback legacy.
