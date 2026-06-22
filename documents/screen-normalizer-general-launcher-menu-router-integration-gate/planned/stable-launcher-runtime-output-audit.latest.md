# E10U capture stable runtime output no apply

## Decision
GO_RUNTIME_OUTPUT_HAS_6_MANUAL_VIEW_STALE_OR_DIFFERENT_ENTRY

## Runtime capture
- capture: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\stable-launcher-runtime-output.latest.txt
- runtime_has_stable_header: 
True
- runtime_path_claim: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- runtime_has_6: 
True

## File checks
- stable: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- stable_parse: 
True
- file_has_6: 
True
- file_has_route: 
True
- stable_sha256: 
ED0772333C4FE9B1F897D984D65AEAA33DFE9B8D4F3FE17BF31435EB86A63E65

## Interpretation
Si file_has_6=True pero runtime_has_6=False, el [6] existe como texto pero no dentro del camino de render ejecutado. Siguiente paso: auditar AST/flujo de render, no parchear por regex global.

## Menu6 context in file
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


## Runtime output
```text
[6] Operador local seguro
==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====
Ruta: C:\ENGREMIAT_CORE\ENGREMIAT.ps1
Principio: este archivo no cambia de nombre; enruta a launchers versionados

[1] Inicio operador
[2] Proyectos
[3] Memoria y documentacion
[4] Data Intake
[5] Health launchers
[b/q] salir
q
[6] Operador local seguro

```

## Rule
NO_APPLY. No modifica archivos. No abre terminal nueva. No git.

## Next
E10V_AUDIT_STABLE_RENDER_FLOW_AST_NO_APPLY
