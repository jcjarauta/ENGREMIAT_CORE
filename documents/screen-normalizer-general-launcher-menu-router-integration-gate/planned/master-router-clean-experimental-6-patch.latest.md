# E10X prepare clean master experimental 6 no apply

## Decision
GO_MASTER_ROUTER_CLEAN_PATCH_READY_NO_APPLY

## Purpose
Limpiar la opcion experimental [6] del launcher maestro estable porque el maestro debe actuar como router estable hacia launchers versionados, no como menu profundo.

## Paths
- master_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- inicio_launcher: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- operator_launcher: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1
- selected_planned: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\ENGREMIAT.master-router-clean-selected.latest.ps1

## Checks before
- stable_parse: 
True
- inicio_parse: 
True
- operator_parse: 
True
- adapter_parse: 
True
- master_has_experimental_6: 
True
- master_has_experimental_6_route: 
True
- master_routes_inicio: 
True
- inicio_routes_operator: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True

## Planned cleanup checks
- selected_parse: 
True
- removed_menu_lines: 
2
- removed_route_blocks: 
1
- selected_has_6: 
False
- selected_has_6_route: 
False
- selected_routes_inicio: 
True

## Selected context
    6: function UX($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function ParseOk($p){$e=$null;[System.Management.Automation.PSParser]::Tokenize((Get-Content $p -Raw),[ref]$e)|Out-Null;if($e.Count){throw "Parse FAIL $p :: $(($e|Select-Object -First 1).Message)"}}
    8: function OpenLauncher($id){$reg=Get-Content $Registry -Raw|ConvertFrom-Json;$l=$reg.launchers|Where-Object{$_.id -eq $id}|Select-Object -First 1;if($null -eq $l){UX ("Launcher no registrado: "+$id) Red;Start-Sleep -Milliseconds 900;return};$p=Join-Path $Core $l.path;if(!(Test-Path $p)){UX ("No existe: "+$p) Red;Start-Sleep -Milliseconds 900;return};ParseOk $p;& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    9: while($true){Clear-Host;UX "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan;UX "Ruta: C:\ENGREMIAT_CORE\ENGREMIAT.ps1" DarkGray;UX "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray;UX "";UX "[1] Inicio operador" Cyan;UX "[2] Proyectos" Cyan;UX "[3] Memoria y documentacion" Cyan;UX "[4] Data Intake" Cyan;UX "[5] Health launchers" Cyan;UX "[b/q] salir" DarkGray;$op=Read-Host "ENGREMIAT";if([string]::IsNullOrWhiteSpace($op)){continue};if($op -eq "1"){OpenLauncher "inicio"}elseif($op -eq "2"){OpenLauncher "proyectos"}elseif($op -eq "3"){OpenLauncher "documentacion"}elseif($op -eq "4"){OpenLauncher "data-intake"}elseif($op -eq "5"){& powershell -NoProfile -ExecutionPolicy Bypass -File $Health;Read-Host "HEALTH"}elseif($op -eq "b" -or $op -eq "q"){break}else{UX "opcion no reconocida" Yellow;Start-Sleep -Milliseconds 700}}

## Rule
NO_APPLY. No modifica runtime. No git. No activa worker real.

## Next
E10Y_APPLY_CLEAN_MASTER_EXPERIMENTAL_6_WITH_GATE_BACKUP_SMOKE
