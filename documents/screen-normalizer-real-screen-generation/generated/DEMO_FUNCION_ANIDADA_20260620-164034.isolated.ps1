$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
$Root = "C:\ENGREMIAT_CORE"
$Helper = Join-Path $Root "tools\screen-normalizer\screen-normalizer.ps1"
if(!(Test-Path -LiteralPath $Helper)){ throw "HELPER_NOT_FOUND path=$Helper" }
$src = Get-Content -LiteralPath $Helper -Raw -Encoding UTF8
$src = $src -replace '(?m)^\s*Export-ModuleMember\b.*$',''
. ([scriptblock]::Create($src))
$Screen = '{"screen_id":"DEMO_FUNCION_ANIDADA_20260620-164034","parent":"INICIO","title":"Demo funcion anidada","route":"INICIO \u003e Demo funcion anidada","role":"validar anidacion controlada por registry","description":"Funcion demo para probar apply controlado al registry sin tocar launchers reales.","status":"PROPOSED_DRY_RUN","principle":"template-first | dry-run | human_gate=SI antes de escritura real","prompt":"DEMO_FUNCION_ANIDADA_20260620-164034","source":"GENERATED_BY_SCREEN_BUILDER_DRY_RUN","risk":"LOW","requires_human_gate":true,"commands":["b = volver","m = mantenimiento","? = ayuda","Enter = refrescar"],"actions":[]}' | ConvertFrom-Json
$ScreenHash = @{}
$Screen.PSObject.Properties | ForEach-Object { $ScreenHash[$_.Name] = $_.Value }
Show-EngremiatNormalizedScreen -Screen $ScreenHash
Write-EngremiatUiLine ""
Write-EngremiatUiLine "AISLADO: esta pantalla viene del registry y no esta conectada al launcher real." "Yellow"
Write-EngremiatUiLine "Prueba segura: no toca registry, launchers, workers, red ni git." "DarkGray"
Write-EngremiatUiLine ""
Read-Host "Enter para cerrar" | Out-Null
