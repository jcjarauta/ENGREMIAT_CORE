$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$Root = "C:\ENGREMIAT_CORE"
$Helper = Join-Path $Root "tools\screen-normalizer\screen-normalizer.ps1"
if(!(Test-Path -LiteralPath $Helper)){ throw "HELPER_NOT_FOUND path=$Helper" }
$src = Get-Content -LiteralPath $Helper -Raw -Encoding UTF8
$src = $src -replace '(?m)^\s*Export-ModuleMember\b.*$',''
. ([scriptblock]::Create($src))
$Screen = '{"screen_id":"OPERADOR_WORKERS","parent":"INICIO","title":"OPERADOR Y WORKERS","route":"INICIO \u003e Operador y workers","role":"estado de workers y automatizacion","description":"Pantalla de workers pausados y autorizaciones futuras.","status":"PAUSADO","principle":"worker real pausado | autorizacion explicita | local-only","prompt":"WORKERS","source":"tools\\launcher\\ENGREMIAT-INICIO-NORMALIZED.ps1","risk":"HIGH","requires_human_gate":true,"commands":["b = volver","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[]}' | ConvertFrom-Json
$ScreenHash = @{}
$Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
if($env:ENG_SCREEN_CANDIDATE_SMOKE -eq "1"){
  Show-EngremiatNormalizedScreen -Screen $ScreenHash
  Write-EngremiatUiLine ""
  Write-EngremiatUiLine "SMOKE: candidato aislado generado desde registry + helper." "Yellow"
  exit 0
}
while($true){
  Show-EngremiatNormalizedScreen -Screen $ScreenHash
  Write-EngremiatUiLine ""
  Write-EngremiatUiLine "AISLADO: candidato generado desde registry + helper. No sustituye launcher real." "Yellow"
  $c = Read-EngremiatScreenCommand -Screen $ScreenHash
  if($c -eq "REFRESH"){ continue }
  if($c -eq "?" -or $c -eq "help"){ Show-EngremiatScreenHelp -Screen $ScreenHash; Read-Host "Enter para volver" | Out-Null; continue }
  if($c -eq "m" -or $c -eq "mant" -or $c -eq "mantenimiento"){ Invoke-EngremiatMaintenanceFlow -Screen $ScreenHash -DryRun | Out-Null; Read-Host "Enter para volver" | Out-Null; continue }
  if($c -eq "q" -or $c -eq "b"){ break }
  Write-EngremiatUiLine "AISLADO: accion no conectada todavia. Migracion real vendra con gate humano." "Yellow"
  Start-Sleep -Milliseconds 700
}
