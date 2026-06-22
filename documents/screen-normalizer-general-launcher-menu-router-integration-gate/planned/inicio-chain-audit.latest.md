# E10D inicio chain audit no apply

## Decision
NO_GO_INICIO_CHAIN_STATIC_INCOMPLETE

## Finding
El menu mostrado por el humano corresponde a la capa INICIO. La opcion [10] no debe esperarse ahi todavia. La ruta probable es INICIO -> [5] Operador y workers -> operador versionado -> [10] adapter.

## Paths
- inicio_launcher: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-inicio-migration-gate\dry-run\ENGREMIAT-INICIO-NORMALIZED.candidate.latest.ps1
- stable_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- operator_launcher: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Checks
- inicio_parse: 
True
- stable_parse: 
True
- operator_parse: 
True
- adapter_parse: 
True
- inicio_has_operator_workers: 
False
- inicio_operator_entry_paused: 
True
- inicio_routes_operator_hint: 
True
- stable_routes_operator: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True
- static_ok: 
False

## Interpretation
Si [5] esta PAUSADO, la prueba manual puede estar bloqueada por politica UX aunque la integracion tecnica del operador este lista. No conviene cerrar como manual OK hasta decidir si se habilita [5], se entra por launcher padre, o se crea shortcut controlado.

## Inicio menu context
## Inicio visible menu hits
NONE

## Inicio routing/input hits
### around line 5
    1: $ErrorActionPreference = "Stop"
    2: [Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
    3: $Root = "C:\ENGREMIAT_CORE"
    4: $Helper = Join-Path $Root "tools\screen-normalizer\screen-normalizer.ps1"
    5: if(!(Test-Path -LiteralPath $Helper)){ throw "HELPER_NOT_FOUND path=$Helper" }
    6: $src = Get-Content -LiteralPath $Helper -Raw -Encoding UTF8
    7: $src = $src -replace '(?m)^\s*Export-ModuleMember\b.*$',''
    8: . ([scriptblock]::Create($src))
    9: $Screen = '{"screen_id":"INICIO","parent":null,"title":"ENGREMIAT / INICIO","route":"INICIO","role":"hub humano principal del operador","description":"Entrada principal para navegar por proyectos, memoria, control, launchers, workers y tarjetas.","status":"READY","principle":"local-first | workers OFF | worker real pausado","prompt":"INICIO","source":"tools\\launcher\\ENGREMIAT-INICIO-NORMALIZED.ps1","risk":"LOW","requires_human_gate":false,"commands":["b/q = salir","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[{"id":"1","label":"Proyectos","type":"screen","target_screen":"PROYECTOS","risk":"LOW","requires_auth":false},{"id":"2","label":"Memoria y documentacion","type":"screen","target_screen":"MEMORIA_DOCUMENTACION","risk":"LOW","requires_auth":false},{"id":"3","label":"Control y estado","type":"screen","target_screen":"CONTROL_ESTADO","risk":"LOW","requires_auth":false},{"id":"4","label":"Launchers y configuracion","type":"screen","target_screen":"LAUNCHERS_CONFIGURACION","risk":"LOW","requires_auth":false},{"id":"5","label":"Operador y workers","type":"screen","target_screen":"OPERADOR_WORKERS","risk":"MEDIUM","requires_auth":true},{"id":"6","label":"Tarjetas","type":"screen","target_screen":"TARJETAS","risk":"LOW","requires_auth":false}]}' | ConvertFrom-Json
   10: $ScreenHash = @{}
   11: $Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
   12: while($true){
   13:   Show-EngremiatNormalizedScreen -Screen $ScreenHash
   14:   Write-EngremiatUiLine ""
   15:   Write-EngremiatUiLine "DRY-RUN: INICIO generado desde registry + helper. No sustituye launcher real." "Yellow"

### around line 17
    7: $src = $src -replace '(?m)^\s*Export-ModuleMember\b.*$',''
    8: . ([scriptblock]::Create($src))
    9: $Screen = '{"screen_id":"INICIO","parent":null,"title":"ENGREMIAT / INICIO","route":"INICIO","role":"hub humano principal del operador","description":"Entrada principal para navegar por proyectos, memoria, control, launchers, workers y tarjetas.","status":"READY","principle":"local-first | workers OFF | worker real pausado","prompt":"INICIO","source":"tools\\launcher\\ENGREMIAT-INICIO-NORMALIZED.ps1","risk":"LOW","requires_human_gate":false,"commands":["b/q = salir","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[{"id":"1","label":"Proyectos","type":"screen","target_screen":"PROYECTOS","risk":"LOW","requires_auth":false},{"id":"2","label":"Memoria y documentacion","type":"screen","target_screen":"MEMORIA_DOCUMENTACION","risk":"LOW","requires_auth":false},{"id":"3","label":"Control y estado","type":"screen","target_screen":"CONTROL_ESTADO","risk":"LOW","requires_auth":false},{"id":"4","label":"Launchers y configuracion","type":"screen","target_screen":"LAUNCHERS_CONFIGURACION","risk":"LOW","requires_auth":false},{"id":"5","label":"Operador y workers","type":"screen","target_screen":"OPERADOR_WORKERS","risk":"MEDIUM","requires_auth":true},{"id":"6","label":"Tarjetas","type":"screen","target_screen":"TARJETAS","risk":"LOW","requires_auth":false}]}' | ConvertFrom-Json
   10: $ScreenHash = @{}
   11: $Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
   12: while($true){
   13:   Show-EngremiatNormalizedScreen -Screen $ScreenHash
   14:   Write-EngremiatUiLine ""
   15:   Write-EngremiatUiLine "DRY-RUN: INICIO generado desde registry + helper. No sustituye launcher real." "Yellow"
   16:   $c = Read-EngremiatScreenCommand -Screen $ScreenHash
   17:   if($c -eq "REFRESH"){ continue }
   18:   if($c -eq "?" -or $c -eq "help"){ Show-EngremiatScreenHelp -Screen $ScreenHash; continue }
   19:   if($c -eq "m" -or $c -eq "mant" -or $c -eq "mantenimiento"){ Invoke-EngremiatMaintenanceFlow -Screen $ScreenHash -DryRun | Out-Null; Read-Host "Enter para volver" | Out-Null; continue }
   20:   if($c -eq "q" -or $c -eq "b"){ break }
   21:   Write-EngremiatUiLine "DRY-RUN: accion no conectada todavia. La migracion real vendra con gate humano." "Yellow"
   22:   Start-Sleep -Milliseconds 700
   23: }

### around line 18
    8: . ([scriptblock]::Create($src))
    9: $Screen = '{"screen_id":"INICIO","parent":null,"title":"ENGREMIAT / INICIO","route":"INICIO","role":"hub humano principal del operador","description":"Entrada principal para navegar por proyectos, memoria, control, launchers, workers y tarjetas.","status":"READY","principle":"local-first | workers OFF | worker real pausado","prompt":"INICIO","source":"tools\\launcher\\ENGREMIAT-INICIO-NORMALIZED.ps1","risk":"LOW","requires_human_gate":false,"commands":["b/q = salir","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[{"id":"1","label":"Proyectos","type":"screen","target_screen":"PROYECTOS","risk":"LOW","requires_auth":false},{"id":"2","label":"Memoria y documentacion","type":"screen","target_screen":"MEMORIA_DOCUMENTACION","risk":"LOW","requires_auth":false},{"id":"3","label":"Control y estado","type":"screen","target_screen":"CONTROL_ESTADO","risk":"LOW","requires_auth":false},{"id":"4","label":"Launchers y configuracion","type":"screen","target_screen":"LAUNCHERS_CONFIGURACION","risk":"LOW","requires_auth":false},{"id":"5","label":"Operador y workers","type":"screen","target_screen":"OPERADOR_WORKERS","risk":"MEDIUM","requires_auth":true},{"id":"6","label":"Tarjetas","type":"screen","target_screen":"TARJETAS","risk":"LOW","requires_auth":false}]}' | ConvertFrom-Json
   10: $ScreenHash = @{}
   11: $Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
   12: while($true){
   13:   Show-EngremiatNormalizedScreen -Screen $ScreenHash
   14:   Write-EngremiatUiLine ""
   15:   Write-EngremiatUiLine "DRY-RUN: INICIO generado desde registry + helper. No sustituye launcher real." "Yellow"
   16:   $c = Read-EngremiatScreenCommand -Screen $ScreenHash
   17:   if($c -eq "REFRESH"){ continue }
   18:   if($c -eq "?" -or $c -eq "help"){ Show-EngremiatScreenHelp -Screen $ScreenHash; continue }
   19:   if($c -eq "m" -or $c -eq "mant" -or $c -eq "mantenimiento"){ Invoke-EngremiatMaintenanceFlow -Screen $ScreenHash -DryRun | Out-Null; Read-Host "Enter para volver" | Out-Null; continue }
   20:   if($c -eq "q" -or $c -eq "b"){ break }
   21:   Write-EngremiatUiLine "DRY-RUN: accion no conectada todavia. La migracion real vendra con gate humano." "Yellow"
   22:   Start-Sleep -Milliseconds 700
   23: }

### around line 19
    9: $Screen = '{"screen_id":"INICIO","parent":null,"title":"ENGREMIAT / INICIO","route":"INICIO","role":"hub humano principal del operador","description":"Entrada principal para navegar por proyectos, memoria, control, launchers, workers y tarjetas.","status":"READY","principle":"local-first | workers OFF | worker real pausado","prompt":"INICIO","source":"tools\\launcher\\ENGREMIAT-INICIO-NORMALIZED.ps1","risk":"LOW","requires_human_gate":false,"commands":["b/q = salir","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[{"id":"1","label":"Proyectos","type":"screen","target_screen":"PROYECTOS","risk":"LOW","requires_auth":false},{"id":"2","label":"Memoria y documentacion","type":"screen","target_screen":"MEMORIA_DOCUMENTACION","risk":"LOW","requires_auth":false},{"id":"3","label":"Control y estado","type":"screen","target_screen":"CONTROL_ESTADO","risk":"LOW","requires_auth":false},{"id":"4","label":"Launchers y configuracion","type":"screen","target_screen":"LAUNCHERS_CONFIGURACION","risk":"LOW","requires_auth":false},{"id":"5","label":"Operador y workers","type":"screen","target_screen":"OPERADOR_WORKERS","risk":"MEDIUM","requires_auth":true},{"id":"6","label":"Tarjetas","type":"screen","target_screen":"TARJETAS","risk":"LOW","requires_auth":false}]}' | ConvertFrom-Json
   10: $ScreenHash = @{}
   11: $Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
   12: while($true){
   13:   Show-EngremiatNormalizedScreen -Screen $ScreenHash
   14:   Write-EngremiatUiLine ""
   15:   Write-EngremiatUiLine "DRY-RUN: INICIO generado desde registry + helper. No sustituye launcher real." "Yellow"
   16:   $c = Read-EngremiatScreenCommand -Screen $ScreenHash
   17:   if($c -eq "REFRESH"){ continue }
   18:   if($c -eq "?" -or $c -eq "help"){ Show-EngremiatScreenHelp -Screen $ScreenHash; continue }
   19:   if($c -eq "m" -or $c -eq "mant" -or $c -eq "mantenimiento"){ Invoke-EngremiatMaintenanceFlow -Screen $ScreenHash -DryRun | Out-Null; Read-Host "Enter para volver" | Out-Null; continue }
   20:   if($c -eq "q" -or $c -eq "b"){ break }
   21:   Write-EngremiatUiLine "DRY-RUN: accion no conectada todavia. La migracion real vendra con gate humano." "Yellow"
   22:   Start-Sleep -Milliseconds 700
   23: }

### around line 20
   10: $ScreenHash = @{}
   11: $Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
   12: while($true){
   13:   Show-EngremiatNormalizedScreen -Screen $ScreenHash
   14:   Write-EngremiatUiLine ""
   15:   Write-EngremiatUiLine "DRY-RUN: INICIO generado desde registry + helper. No sustituye launcher real." "Yellow"
   16:   $c = Read-EngremiatScreenCommand -Screen $ScreenHash
   17:   if($c -eq "REFRESH"){ continue }
   18:   if($c -eq "?" -or $c -eq "help"){ Show-EngremiatScreenHelp -Screen $ScreenHash; continue }
   19:   if($c -eq "m" -or $c -eq "mant" -or $c -eq "mantenimiento"){ Invoke-EngremiatMaintenanceFlow -Screen $ScreenHash -DryRun | Out-Null; Read-Host "Enter para volver" | Out-Null; continue }
   20:   if($c -eq "q" -or $c -eq "b"){ break }
   21:   Write-EngremiatUiLine "DRY-RUN: accion no conectada todavia. La migracion real vendra con gate humano." "Yellow"
   22:   Start-Sleep -Milliseconds 700
   23: }


## Rule
NO_APPLY. No se modifica INICIO, ENGREMIAT.ps1, operator launcher, adapter ni git.

## Next
E10E_DECIDE_ACCESS_PATH_OPERATOR_PAUSED_OR_PARENT_SHORTCUT_NO_APPLY
