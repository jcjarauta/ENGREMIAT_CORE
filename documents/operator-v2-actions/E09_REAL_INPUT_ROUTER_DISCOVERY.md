# E09 Real Input Router Discovery

Estado: PASS
Target: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Bridge: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1
Patched in this step: NO
Parse OK: SI

## Best candidate
Line: 16
Score: 11
Why: Read-Host,switch,input_var
```powershell
   12: function Run-Screen([string]$Label,[string]$Path){ if(Test-Path $Path){ W ("OK abriendo " + $Label + " -> " + $Path) Cyan; & powershell -NoProfile -ExecutionPolicy Bypass -File $Path; return }; W ("PENDIENTE " + $Label) Yellow; W ("No se encontro: " + $Path) DarkYellow; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   13: function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
   14: function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
   15: function Show-Menu(){ Clear-Host; W "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray; W ""; W "[1] Inicio operador" White; W "[2] Proyectos" White; W "[3] Memoria y documentacion" White; W "[4] Data Intake" White; W "[5] Health launchers" White; W ""; W $CommonCommandLegend DarkGray; W "" }
   16: while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
   17: 
   18: 
   19: # ENGREMIAT_OPERATOR_V2_ACTIONS_BIND_BEGIN
   20: # package=ENGREMIAT_OPERATOR_V2_ACTIONS_003
   21: # stage=E08_R2 no-plus parse-safe guarded minimal bind
   22: # mode=DRY_RUN_ONLY
```

## Top candidates
- line=16 score=11 why=Read-Host,switch,input_var text=while($true){ try{ Show-Menu; $cmd = Read-Host "ENGREMIAT"; $cmd = ($cmd + "").Trim().ToLowerInvariant(); switch($cmd){ "" { continue } "1" { Run-Screen "Inicio operador" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1" } "2" { Run-Screen "Proyectos" "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1" } "3" { Run-Screen "Memoria y documentacion" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1" } "4" { Run-Screen "Data Intake" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1" } "5" { Run-Screen "Health launchers" "C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1" } "m" { Show-Maintenance } "?" { Show-Help } "h" { Show-Help } "help" { Show-Help } "b" { return } "q" { return } default { W ("Comando no reconocido: " + $cmd) Yellow; $r=Wait-Back; if($r -eq "quit"){ return } } } } catch { if($_.Exception.Message -eq "__ENGREMIAT_QUIT__"){ return } else { throw } } }
- line=11 score=7 why=Read-Host,command_tokens text=function Wait-Back(){ W ""; $x = Read-Host "Enter = volver/refrescar | b/q = salir"; $x = ($x + "").Trim().ToLowerInvariant(); if($x -eq "b" -or $x -eq "q"){ return "quit" }; return "back" }
- line=13 score=7 why=Read-Host,input_var text=function Show-Maintenance(){ Clear-Host; W "==== ENGREMIAT / MANTENIMIENTO ====" Cyan; W ""; W ("Ruta: " + $PSCommandPath) DarkGray; W "Principio: mantenimiento del launcher maestro estable" DarkGray; W ""; W "[1] Abrir asistente de tarjetas humanas" White; W "[2] Mostrar comando maestro" White; W ""; W $CommonCommandLegend DarkGray; W ""; $cmd=Read-Host "MANTENIMIENTO"; $cmd=($cmd+"").Trim().ToLowerInvariant(); if($cmd -eq "1"){ Run-Screen "Asistente tarjetas humanas" "C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1"; return }; if($cmd -eq "2"){ W "C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File `"C:\ENGREMIAT_CORE\ENGREMIAT.ps1`"" Green; Wait-Back | Out-Null; return }; return }
- line=9 score=2 why=command_tokens text=$CommonCommandLegend = "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar"
- line=14 score=2 why=command_tokens text=function Show-Help(){ Clear-Host; W "==== ENGREMIAT / AYUDA ====" Cyan; W ""; W "1 = Inicio operador / menu operador." White; W "2 = Proyectos / gestor de proyectos." White; W "3 = Memoria y documentacion." White; W "4 = Data Intake." White; W "5 = Health launchers." White; W "m = mantenimiento." White; W "? = ayuda." White; W "Enter vacio = refrescar." White; W "b/q = salir." White; $r=Wait-Back; if($r -eq "quit"){ throw "__ENGREMIAT_QUIT__" } }
- line=34 score=2 why=input_var text=param([string]$InputText)
- line=36 score=2 why=input_var text=return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_NOT_AVAILABLE'; executed=$false; mode='DRY_RUN_ONLY' }
- line=40 score=2 why=input_var text=return Invoke-EngOperatorInputWithActionsBridge -InputText $InputText
- line=42 score=2 why=input_var text=return [pscustomobject]@{ ok=$false; handled=$false; input=$InputText; reason='BRIDGE_ERROR'; executed=$false; mode='DRY_RUN_ONLY' }

## E10 planned patch
Objetivo: insertar un fallback bind mínimo justo después de capturar input humano y antes del switch/fallback legacy.
Regla: si Invoke-EngremiatOperatorV2ActionsBridgeDryRun devuelve handled=True, solo registrar DRY_RUN y continuar sin ejecutar acción real; si handled=False, mantener flujo legacy intacto.
