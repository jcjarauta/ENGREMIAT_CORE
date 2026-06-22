# E10S stable launcher runtime menu source audit no apply

## Decision
WARN_MENU6_IN_FILE_AND_VISIBLE_BLOCK_BUT_RUNTIME_NOT_REFRESHED_OR_DIFFERENT_ENTRYPOINT

## Human observation
Despues de E10Q, la pantalla ejecutada sigue mostrando [1]..[5] y [b/q], sin [6].

## Checks
- stable_parse: 
True
- operator_parse: 
True
- adapter_parse: 
True
- file_has_menu6: 
True
- visible_block_has_menu6: 
True
- file_has_route: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True

## Paths
- stable_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- stable_sha256: 
ED0772333C4FE9B1F897D984D65AEAA33DFE9B8D4F3FE17BF31435EB86A63E65
- operator: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Runtime candidates
- score=210 path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1 modified=2026-06-20 19:21:48 hash=ED0772333C4FE9B1F897D984D65AEAA33DFE9B8D4F3FE17BF31435EB86A63E65
- score=20 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1 modified=2026-06-20 19:10:19 hash=F1F6EDD55AC784CAC5227919A54EDC143F84419FC274CF12179FB34C54953A99

## Hits
- header_hits: 
10
- visible_menu_hits: 
10
- menu6_hits: 
9, 11
- read_host_hits: 
10
- route_hits: 
12, 13
- source_hints: 
4, 5, 7, 8, 10, 15

## Visible menu blocks
- block 1-20 contains6=True contains_bq=True

## Header/Menu contexts
### around line 10
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


## Menu6 contexts
### around line 9
    1: $ErrorActionPreference="Stop"
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

### around line 11
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


## ReadHost/Route contexts
### around line 10
    1: $ErrorActionPreference="Stop"
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

### around line 12
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

### around line 13
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
NO_APPLY. No modifica archivos. No abre terminal. No git.

## Next
E10T_PREPARE_RUNTIME_TRUE_MENU_REPAIR_OR_RELOAD_DIAGNOSIS_NO_APPLY
