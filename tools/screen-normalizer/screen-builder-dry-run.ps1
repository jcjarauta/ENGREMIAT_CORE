$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){ Write-Host $m -ForegroundColor $c }
$Root = "C:\ENGREMIAT_CORE"
$RegistryPath = Join-Path $Root "data\screen-normalizer\screen-registry.v1.json"
$ParentScreenId = if($env:ENG_SCREEN_PARENT){$env:ENG_SCREEN_PARENT}else{"INICIO"}
$NewScreenId = if($env:ENG_SCREEN_NEW_ID){$env:ENG_SCREEN_NEW_ID}else{"NUEVA_FUNCION_DEMO"}
$Title = if($env:ENG_SCREEN_TITLE){$env:ENG_SCREEN_TITLE}else{"Nueva funcion demo"}
$Role = if($env:ENG_SCREEN_ROLE){$env:ENG_SCREEN_ROLE}else{"funcion nueva anidada por plantilla"}
$Description = if($env:ENG_SCREEN_DESCRIPTION){$env:ENG_SCREEN_DESCRIPTION}else{"Pantalla generada en dry-run para validar anidacion automatica."}
$Risk = if($env:ENG_SCREEN_RISK){$env:ENG_SCREEN_RISK}else{"LOW"}
if(!(Test-Path -LiteralPath $RegistryPath)){ throw "REGISTRY_NOT_FOUND path=$RegistryPath" }
$reg = Get-Content -LiteralPath $RegistryPath -Raw -Encoding UTF8 | ConvertFrom-Json
$parent = @($reg.screens | Where-Object { $_.screen_id -eq $ParentScreenId }) | Select-Object -First 1
if(-not $parent){ throw "PARENT_SCREEN_NOT_FOUND parent=$ParentScreenId" }
$exists = @($reg.screens | Where-Object { $_.screen_id -eq $NewScreenId }) | Select-Object -First 1
if($exists){ throw "NEW_SCREEN_ALREADY_EXISTS screen=$NewScreenId" }
$route = "$($parent.route) > $Title"
$newScreen = [ordered]@{ screen_id=$NewScreenId; parent=$ParentScreenId; title=$Title; route=$route; role=$Role; description=$Description; status="PROPOSED_DRY_RUN"; principle="template-first | dry-run | human_gate=SI antes de escritura real"; prompt=$NewScreenId; source="GENERATED_BY_SCREEN_BUILDER_DRY_RUN"; risk=$Risk; requires_human_gate=$true; commands=@("b = volver","m = mantenimiento","? = ayuda","Enter = refrescar"); actions=@() }
$preview = [ordered]@{ schema="engremiat.screen_builder_dry_run_preview.v1"; status="PASS"; mode="DRY_RUN_NO_REGISTRY_WRITE"; parent_screen=$parent; new_screen=$newScreen; generated_menu_patch_preview=[ordered]@{ parent=$ParentScreenId; add_child=$NewScreenId; menu_label=$Title; route=$route }; generated_ui_preview=@("==== "+$Title+" ====","Ruta: "+$route,"Rol: "+$Role,"Estado: PROPOSED_DRY_RUN","Principio: template-first | dry-run | human_gate=SI antes de escritura real","",$Description,"","[b] volver | m = mantenimiento | ? = ayuda | Enter = refrescar",$NewScreenId+":"); write_now=$false; next="E07_SCREEN_BUILDER_APPLY_WITH_HUMAN_GATE_PENDING" }
$outDir = Join-Path $Root "documents\screen-normalizer-standardization\builder"
New-Item -ItemType Directory -Force -Path $outDir | Out-Null
$out = Join-Path $outDir "screen-builder-dry-run-preview.latest.json"
$preview | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $out -Encoding UTF8
W "OK screen_builder_dry_run_preview_ready parent=$ParentScreenId new=$NewScreenId write_now=False preview=$out" Green
$preview | ConvertTo-Json -Depth 100
