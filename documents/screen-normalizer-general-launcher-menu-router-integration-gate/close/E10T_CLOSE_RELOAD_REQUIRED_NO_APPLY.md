# E10T close reload required no apply

## Decision
GO_RELOAD_REQUIRED_FILE_READY_NO_MORE_PATCH

## Diagnosis
E10S confirma que [6] existe en ENGREMIAT.ps1 y en el bloque visible. Si la pantalla humana aun no muestra [6], la instancia actual del launcher fue cargada antes del parche. No se debe seguir parcheando; hay que cerrar esa instancia y relanzar ENGREMIAT.ps1 desde archivo.

## Static checks
- stable_parse: 
True
- operator_parse: 
True
- adapter_parse: 
True
- menu6_visible_in_file: 
True
- route_present: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True
- static_ok: 
True

## Visible menu block in file
    7: function ParseOk($p){$e=$null;[System.Management.Automation.PSParser]::Tokenize((Get-Content $p -Raw),[ref]$e)|Out-Null;if($e.Count){throw "Parse FAIL $p :: $(($e|Select-Object -First 1).Message)"}}
    8: function OpenLauncher($id){$reg=Get-Content $Registry -Raw|ConvertFrom-Json;$l=$reg.launchers|Where-Object{$_.id -eq $id}|Select-Object -First 1;if($null -eq $l){UX ("Launcher no registrado: "+$id) Red;Start-Sleep -Milliseconds 900;return};$p=Join-Path $Core $l.path;if(!(Test-Path $p)){UX ("No existe: "+$p) Red;Start-Sleep -Milliseconds 900;return};ParseOk $p;& powershell -NoProfile -ExecutionPolicy Bypass -File $p}
    9: [Console]::WriteLine("[6] Operador local seguro")
   10: while($true){Clear-Host;UX "==== ENGREMIAT / LAUNCHER HUMANO ESTABLE ====" Cyan;UX "Ruta: C:\ENGREMIAT_CORE\ENGREMIAT.ps1" DarkGray;UX "Principio: este archivo no cambia de nombre; enruta a launchers versionados" DarkGray;UX "";UX "[1] Inicio operador" Cyan;UX "[2] Proyectos" Cyan;UX "[3] Memoria y documentacion" Cyan;UX "[4] Data Intake" Cyan;UX "[5] Health launchers" Cyan;UX "[b/q] salir" DarkGray;$op=Read-Host "ENGREMIAT";if([string]::IsNullOrWhiteSpace($op)){continue};if($op -eq "1"){OpenLauncher "inicio"}elseif($op -eq "2"){OpenLauncher "proyectos"}elseif($op -eq "3"){OpenLauncher "documentacion"}elseif($op -eq "4"){OpenLauncher "data-intake"}elseif($op -eq "5"){& powershell -NoProfile -ExecutionPolicy Bypass -File $Health;Read-Host "HEALTH"}elseif($op -eq "b" -or $op -eq "q"){break}else{UX "opcion no reconocida" Yellow;Start-Sleep -Milliseconds 700}}
   11: Write-Host "[6] Operador local seguro"
   12: if ($op -eq "6") {
   13:   $operatorLauncher = Join-Path $PSScriptRoot "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"

## Manual relaunch
Cerrar la instancia actual del launcher y ejecutar desde una terminal nueva o desde el acceso normal. No usar Start-Process desde scripts de smoke.

Comando manual si estas en PowerShell:
cd C:\ENGREMIAT_CORE; powershell -NoProfile -ExecutionPolicy Bypass -File .\ENGREMIAT.ps1

## Expected manual result
E10R_OK launcher estable visible [6] abre operador y opcion 10 abre adapter seguro

## Writes
- stable_write: false
- inicio_write: false
- operator_write: false
- adapter_write: false
- git_write: false
- open_terminal: false

## Next
E10R_MANUAL_TEST_AFTER_FRESH_RELAUNCH
