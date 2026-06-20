$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
$LibRoot=Join-Path $Root "library\reusable-modules"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function CopyDir($src,$dst){if(Test-Path -LiteralPath $dst){Remove-Item -LiteralPath $dst -Recurse -Force};New-Item -ItemType Directory -Force -Path $dst|Out-Null;Copy-Item -LiteralPath (Join-Path $src "*") -Destination $dst -Recurse -Force}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_module_vault)){throw "no_active_module_vault"}
$vault=[string]$s.active_module_vault
$module=[string]$s.active_module
$modulePath=Split-Path $vault -Parent
$moduleJson=Join-Path $vault "module.json"
$evidence=Join-Path $vault "EVIDENCIAS.md"
$gates=Join-Path $vault "GATES.md"
if(!(Test-Path -LiteralPath $moduleJson)){throw "missing_module_json"}
$mj=Get-Content -LiteralPath $moduleJson -Raw -Encoding UTF8|ConvertFrom-Json
if([string]$mj.lifecycle -ne "OBJECTIVE_COMPLETED"){throw "module_not_completed lifecycle=$($mj.lifecycle)"}
$objective=if($mj.PSObject.Properties.Name -contains "objective"){[string]$mj.objective}else{""}
if([string]::IsNullOrWhiteSpace($objective)){throw "objective_not_defined"}
$safeName=($module -replace "[^A-Za-z0-9_\-]","_")
$dest=Join-Path $LibRoot ($safeName+"_"+(Get-Date -Format yyyyMMddHHmmss))
CopyDir $modulePath $dest
$now=Get-Date -Format s
$mj|Add-Member -Force -NotePropertyName reusable -NotePropertyValue $true
$mj|Add-Member -Force -NotePropertyName library_status -NotePropertyValue "PROMOTED_TO_LIBRARY_CANDIDATE"
$mj|Add-Member -Force -NotePropertyName promoted_at -NotePropertyValue $now
$mj|Add-Member -Force -NotePropertyName library_snapshot_path -NotePropertyValue $dest
$mj|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $moduleJson -Encoding UTF8
Add-Content -LiteralPath $evidence -Encoding UTF8 -Value @("","## Promocion biblioteca $now","- status: PROMOTED_TO_LIBRARY_CANDIDATE","- objective: $objective","- snapshot: $dest")
Add-Content -LiteralPath $gates -Encoding UTF8 -Value @("","## Gate biblioteca $now","- [x] Modulo cerrado como OBJECTIVE_COMPLETED","- [x] Snapshot copiado a biblioteca reutilizable","- [x] Estado: PROMOTED_TO_LIBRARY_CANDIDATE")
if($s.PSObject.Properties.Name -contains "active_module_context" -and $s.active_module_context){$s.active_module_context|Add-Member -Force -NotePropertyName reusable -NotePropertyValue $true;$s.active_module_context|Add-Member -Force -NotePropertyName library_status -NotePropertyValue "PROMOTED_TO_LIBRARY_CANDIDATE";$s.active_module_context|Add-Member -Force -NotePropertyName library_snapshot_path -NotePropertyValue $dest;$s.active_module_context|Add-Member -Force -NotePropertyName promoted_at -NotePropertyValue $now}
$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StatePath -Encoding UTF8
$reportDir=Join-Path $Root "reports\operator-context-decision-tree"
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$report=Join-Path $reportDir ("e06d-module-promote-"+$module+"-"+(Get-Date -Format yyyyMMddHHmmss)+".json")
[pscustomobject]@{package_id="ENGREMIAT_OPERATOR_CONTEXT_AND_DECISION_TREE_001";stage="E06D_PROMOTE_MODULE_TO_LIBRARY_CANDIDATE";status="PASS";module=$module;objective=$objective;library_status="PROMOTED_TO_LIBRARY_CANDIDATE";snapshot=$dest;promoted_at=$now}|ConvertTo-Json -Depth 10|Set-Content -LiteralPath $report -Encoding UTF8
L "OK modulo_promovido=True" Green
L ("module="+$module) Cyan
L ("library_status=PROMOTED_TO_LIBRARY_CANDIDATE") Green
L ("snapshot="+$dest) Cyan
L ("report="+$report) Cyan
L "NEXT 3 evidencias | 4 gates | cierre E06" Magenta
