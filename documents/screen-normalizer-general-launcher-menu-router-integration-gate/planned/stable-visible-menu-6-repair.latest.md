# E10P stable visible menu 6 not visible audit no apply

## Decision
GO_STABLE_VISIBLE_MENU_6_REPAIR_READY_NO_APPLY

## Finding
E10N static OK pero la prueba humana no muestra [6]. Se audita el bloque visible real de ENGREMIAT.ps1 y se prepara reparacion planned insertando [6] justo despues de [5] Health launchers.

## Paths
- stable_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- operator_launcher: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1
- selected_planned: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\ENGREMIAT.stable-visible-menu-6-selected.latest.ps1

## Anchors
- visible_menu_start: 
10
- visible_menu_end: 
10
- insert_after_line: 
10
- read_host_line: 
10
- input_variable: $
op

## Existing hits
- line6_existing: 
9
- read_host_lines: 
10
- route6_or_operator_lines: 
11, 12

## Checks
- stable_parse: 
True
- operator_parse: 
True
- adapter_parse: 
True
- selected_parse: 
True
- already_visible_in_block: 
False
- inserted_menu: 
True
- route_already: 
True
- inserted_route: 
False
- menu6_visible: 
True
- route_present: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True

## Context after planned repair
    2: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    3: $Core="C:\ENGREMIAT_CORE"
    4: $Registry=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-REGISTRY.json"
    5: $Health=Join-Path $Core "tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1"
    6: function UX($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
    7: function ParseOk($p){$e=$null;[System.Management.Automation.PSParser]::Tokenize((Get-Content $p -Raw),[ref]$e)|Out-Null;if($e.Count){throw "Parse FAIL $p :: $(($e|Select-Object -First 1).Message)"}}
    8: function OpenLauncher($id){$reg=Get-Content $Registry -Raw|ConvertFrom-Json;$l=$reg.launchers|Where-Object{$_.id -eq $id}|Select-Object -First 1;if($null -eq $l){UX ("Launcher no registrado: "+$id) Red;Start-Sleep -Milliseconds 900;return};$p=Join-Path $Core $l.path;if(!(Test-Path $p)){UX ("No existe: "+$p) Red;Start-Sleep -Milliseconds 900;return};ParseOk $p;& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    9: [Console]::WriteLine("[6] Operador local seguro")
   10: while($true){Clear-Host;UX "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan;UX "Ruta: C:\ENGREMIAT_CORE\ENGREMIAT.ps1" DarkGray;UX "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray;UX "";UX "[1] Inicio operador" Cyan;UX "[2] Proyectos" Cyan;UX "[3] Memoria y documentacion" Cyan;UX "[4] Data Intake" Cyan;UX "[5] Health launchers" Cyan;UX "[b/q] salir" DarkGray;$op=Read-Host "ENGREMIAT";if([string]::IsNullOrWhiteSpace($op)){continue};if($op -eq "1"){OpenLauncher "inicio"}elseif($op -eq "2"){OpenLauncher "proyectos"}elseif($op -eq "3"){OpenLauncher "documentacion"}elseif($op -eq "4"){OpenLauncher "data-intake"}elseif($op -eq "5"){& powershell -NoProfile -ExecutionPolicy Bypass -File $Health;Read-Host "HEALTH"}elseif($op -eq "b" -or $op -eq "q"){break}else{UX "opcion no reconocida" Yellow;Start-Sleep -Milliseconds 700}}
   11: Write-Host "[6] Operador local seguro"
   12: if ($op -eq "6") {
   13:   $operatorLauncher = Join-Path $PSScriptRoot "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
   14:   if (Test-Path $operatorLauncher) {
   15:     & powershell -NoProfile -ExecutionPolicy Bypass -File $operatorLauncher
   16:   } else {
   17:     Write-Host "Operador local no encontrado: $operatorLauncher" -ForegroundColor Yellow
   18:   }
   19:   return
   20: }

## Rule
NO_APPLY. No modifica launcher real, INICIO, operador, adapter ni git.

## Next
E10Q_APPLY_STABLE_VISIBLE_MENU_6_REPAIR_WITH_GATE
