$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function D($p){if(!(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_module_vault)){throw "no_active_module_vault"}
$vault=[string]$s.active_module_vault
$module=[string]$s.active_module
$objective=Read-Host "Objetivo del modulo"
if([string]::IsNullOrWhiteSpace($objective)){throw "objective_empty"}
$contract=Join-Path $vault "CONTRATO.md"
$tasks=Join-Path $vault "TAREAS.md"
$json=Join-Path $vault "module.json"
D $vault
$contractLines=@("# CONTRATO $module","","Proyecto vinculado: $($s.active_project)","Modulo: $((Split-Path $vault -Parent))","Estado: ACTIVE_IN_PROJECT","","## Objetivo",$objective,"","## Criterio de cierre","El modulo podra cerrarse cuando el objetivo este implementado, validado con smoke y registrado en evidencias.","")
Set-Content -LiteralPath $contract -Encoding UTF8 -Value $contractLines
if(!(Test-Path -LiteralPath $tasks)){Set-Content -LiteralPath $tasks -Encoding UTF8 -Value @("# TAREAS $module","")}
Add-Content -LiteralPath $tasks -Encoding UTF8 -Value @("","## Objetivo definido $(Get-Date -Format s)","- [ ] $objective","- [ ] Validar smoke del modulo.","- [ ] Registrar evidencia de cierre.")
if(Test-Path -LiteralPath $json){try{$mj=Get-Content -LiteralPath $json -Raw -Encoding UTF8|ConvertFrom-Json}catch{$mj=[pscustomobject]@{}}}else{$mj=[pscustomobject]@{}}
$mj|Add-Member -Force -NotePropertyName objective -NotePropertyValue $objective
$mj|Add-Member -Force -NotePropertyName objective_status -NotePropertyValue "DEFINED"
$mj|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s")
$mj|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $json -Encoding UTF8
if($s.PSObject.Properties.Name -contains "active_module_context" -and $s.active_module_context){$s.active_module_context|Add-Member -Force -NotePropertyName objective -NotePropertyValue $objective;$s.active_module_context|Add-Member -Force -NotePropertyName objective_status -NotePropertyValue "DEFINED"}
$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StatePath -Encoding UTF8
L "OK objetivo_definido=True" Green
L ("module="+$module) Cyan
L ("objective="+$objective) Cyan
L ("contract="+$contract) Cyan
L ("tasks="+$tasks) Cyan
L ("module_json="+$json) Cyan
L "NEXT ejecuta 1 para ver contrato o 5 para smoke" Magenta
