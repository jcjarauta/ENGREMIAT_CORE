$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_module_vault)){throw "no_active_module_vault"}
$vault=[string]$s.active_module_vault
$module=[string]$s.active_module
$moduleJson=Join-Path $vault "module.json"
$evidence=Join-Path $vault "EVIDENCIAS.md"
$gates=Join-Path $vault "GATES.md"
if(!(Test-Path -LiteralPath $moduleJson)){throw "missing_module_json"}
$mj=Get-Content -LiteralPath $moduleJson -Raw -Encoding UTF8|ConvertFrom-Json
$objective=if($mj.PSObject.Properties.Name -contains "objective"){[string]$mj.objective}else{""}
if([string]::IsNullOrWhiteSpace($objective)){throw "objective_not_defined"}
$smokeDir=Join-Path $Root "reports\module-smoke"
$lastSmoke=Get-ChildItem -LiteralPath $smokeDir -Filter ("module-smoke-"+$module+"-*.json") -File -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 1
if(!$lastSmoke){throw "no_smoke_report_found"}
$sr=Get-Content -LiteralPath $lastSmoke.FullName -Raw -Encoding UTF8|ConvertFrom-Json
if([string]$sr.status -ne "PASS"){throw "last_smoke_not_pass report=$($lastSmoke.FullName)"}
$now=Get-Date -Format s
$mj|Add-Member -Force -NotePropertyName lifecycle -NotePropertyValue "OBJECTIVE_COMPLETED"
$mj|Add-Member -Force -NotePropertyName objective_status -NotePropertyValue "COMPLETED"
$mj|Add-Member -Force -NotePropertyName reusable -NotePropertyValue $false
$mj|Add-Member -Force -NotePropertyName library_status -NotePropertyValue "CANDIDATE_NOT_PROMOTED"
$mj|Add-Member -Force -NotePropertyName completed_at -NotePropertyValue $now
$mj|Add-Member -Force -NotePropertyName last_smoke_report -NotePropertyValue $lastSmoke.FullName
$mj|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $moduleJson -Encoding UTF8
Add-Content -LiteralPath $evidence -Encoding UTF8 -Value @("","## Cierre objetivo $now","- status: OBJECTIVE_COMPLETED","- objective: $objective","- smoke: $($lastSmoke.FullName)","- library_status: CANDIDATE_NOT_PROMOTED")
Add-Content -LiteralPath $gates -Encoding UTF8 -Value @("","## Gate cierre $now","- [x] Objetivo definido: $objective","- [x] Smoke PASS: $($lastSmoke.FullName)","- [x] Modulo cerrado como OBJECTIVE_COMPLETED","- [ ] Promocion a biblioteca reutilizable pendiente")
if($s.PSObject.Properties.Name -contains "active_module_context" -and $s.active_module_context){$s.active_module_context|Add-Member -Force -NotePropertyName lifecycle -NotePropertyValue "OBJECTIVE_COMPLETED";$s.active_module_context|Add-Member -Force -NotePropertyName objective_status -NotePropertyValue "COMPLETED";$s.active_module_context|Add-Member -Force -NotePropertyName library_status -NotePropertyValue "CANDIDATE_NOT_PROMOTED";$s.active_module_context|Add-Member -Force -NotePropertyName completed_at -NotePropertyValue $now}
$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StatePath -Encoding UTF8
$closeDir=Join-Path $Root "reports\operator-context-decision-tree"
New-Item -ItemType Directory -Force -Path $closeDir|Out-Null
$closeReport=Join-Path $closeDir ("e06c-module-close-"+$module+"-"+(Get-Date -Format yyyyMMddHHmmss)+".json")
[pscustomobject]@{package_id="ENGREMIAT_OPERATOR_CONTEXT_AND_DECISION_TREE_001";stage="E06C_CLOSE_MODULE_OBJECTIVE";status="PASS";module=$module;objective=$objective;lifecycle="OBJECTIVE_COMPLETED";objective_status="COMPLETED";last_smoke_report=$lastSmoke.FullName;library_status="CANDIDATE_NOT_PROMOTED";closed_at=$now}|ConvertTo-Json -Depth 10|Set-Content -LiteralPath $closeReport -Encoding UTF8
L "OK modulo_cerrado=True" Green
L ("module="+$module) Cyan
L ("objective="+$objective) Cyan
L ("lifecycle=OBJECTIVE_COMPLETED") Green
L ("smoke="+$lastSmoke.FullName) Cyan
L ("report="+$closeReport) Cyan
L "NEXT 3 evidencias | 4 gates | siguiente: promover a biblioteca reutilizable si procede" Magenta
