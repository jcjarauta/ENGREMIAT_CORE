$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$Root = "C:\ENGREMIAT_CORE"
$Helper = Join-Path $Root "tools\screen-normalizer\screen-normalizer.ps1"
if(!(Test-Path -LiteralPath $Helper)){ throw "HELPER_NOT_FOUND path=$Helper" }
$src = Get-Content -LiteralPath $Helper -Raw -Encoding UTF8
$src = $src -replace '(?m)^\s*Export-ModuleMember\b.*$',''
. ([scriptblock]::Create($src))
$Screen = '{"screen_id":"INICIO","parent":null,"title":"ENGREMIAT / INICIO","route":"INICIO","role":"hub humano principal del operador","description":"Entrada principal para navegar por proyectos, memoria, control, launchers, workers y tarjetas.","status":"READY","principle":"local-first | workers OFF | worker real pausado","prompt":"INICIO","source":"tools\\launcher\\ENGREMIAT-INICIO-NORMALIZED.ps1","risk":"LOW","requires_human_gate":false,"commands":["b/q = salir","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[{"id":"1","label":"Proyectos","type":"screen","target_screen":"PROYECTOS","risk":"LOW","requires_auth":false},{"id":"2","label":"Memoria y documentacion","type":"screen","target_screen":"MEMORIA_DOCUMENTACION","risk":"LOW","requires_auth":false},{"id":"3","label":"Control y estado","type":"screen","target_screen":"CONTROL_ESTADO","risk":"LOW","requires_auth":false},{"id":"4","label":"Launchers y configuracion","type":"screen","target_screen":"LAUNCHERS_CONFIGURACION","risk":"LOW","requires_auth":false},{"id":"5","label":"Operador y workers","type":"screen","target_screen":"OPERADOR_WORKERS","risk":"MEDIUM","requires_auth":true},{"id":"6","label":"Tarjetas","type":"screen","target_screen":"TARJETAS","risk":"LOW","requires_auth":false}]}' | ConvertFrom-Json
$ScreenHash = @{}
$Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
while($true){
  Show-EngremiatNormalizedScreen -Screen $ScreenHash
  Write-EngremiatUiLine ""
  Write-EngremiatUiLine "DRY-RUN: INICIO generado desde registry + helper. No sustituye launcher real." "Yellow"
  $c = Read-EngremiatScreenCommand -Screen $ScreenHash
  if($c -eq "REFRESH"){ continue }
  if($c -eq "?" -or $c -eq "help"){ Show-EngremiatScreenHelp -Screen $ScreenHash; continue }
  if($c -eq "m" -or $c -eq "mant" -or $c -eq "mantenimiento"){ Invoke-EngremiatMaintenanceFlow -Screen $ScreenHash -DryRun | Out-Null; Read-Host "Enter para volver" | Out-Null; continue }
  if($c -eq "q" -or $c -eq "b"){ break }
  Write-EngremiatUiLine "DRY-RUN: accion no conectada todavia. La migracion real vendra con gate humano." "Yellow"
  Start-Sleep -Milliseconds 700
}
