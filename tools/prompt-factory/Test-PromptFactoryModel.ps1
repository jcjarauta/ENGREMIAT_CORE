param([string]$SchemaRoot="data/prompt-factory/schemas",[string]$ContractPath="docs/prompt-factory/PROMPT_FACTORY_CONTRACT.md",[string]$ReportPath="reports/prompt-factory/e01-modelo-prompt-factory/prompt-factory-model-smoke-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$checks=@();$score=0
function AddModelCheck([string]$id,[bool]$ok,[int]$points,[string]$message){if($ok){$script:score+=$points};$script:checks+=[ordered]@{id=$id;ok=$ok;points=$points;message=$message}}
$files=@("prompt-task.schema.json","prompt-context.schema.json","worker-output.schema.json")
foreach($f in $files){$p=Join-Path $SchemaRoot $f;$exists=Test-Path -LiteralPath $p -PathType Leaf;$jsonOk=$false;$requiredOk=$false;if($exists){try{$obj=Get-Content -LiteralPath $p -Raw -Encoding UTF8|ConvertFrom-Json;$jsonOk=$true;$requiredOk=($obj.required.Count -gt 0 -and $null -ne $obj.properties)}catch{}};AddModelCheck ("exists_"+$f) $exists 8 $p;AddModelCheck ("json_"+$f) $jsonOk 8 $p;AddModelCheck ("required_"+$f) $requiredOk 8 $p}
$contractExists=Test-Path -LiteralPath $ContractPath -PathType Leaf;$contractOk=$false;if($contractExists){$txt=Get-Content -LiteralPath $ContractPath -Raw -Encoding UTF8;$contractOk=($txt -match "external_network=False" -and $txt -match "git_write=False" -and $txt -match "NO_GO" -and $txt -match "WorkerOutput" -and $txt -match "Cline/Ollama")}
AddModelCheck "contract_exists" $contractExists 10 $ContractPath
AddModelCheck "contract_limits" $contractOk 18 $ContractPath
if($score -gt 100){$score=100}
$validationPassed=($score -ge 90)
$rep=[ordered]@{objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E01";repair="E01-SMOKE-SCORE-REPAIR-001";block_id="B01.3";step_id="P01.3.2";status=$(if($validationPassed){"OK"}else{"NO_GO"});validation_passed=$validationPassed;score=$score;threshold=90;checks=$checks;external_network=$false;git=$false;next=$(if($validationPassed){"E02_LECTOR_DE_PLAN_DE_DESARROLLO"}else{"REPAIR_PROMPT_FACTORY_E01"});checked_at=(Get-Date).ToString("s")}
WriteJson $ReportPath $rep
if(-not $validationPassed){Write-Host ("ERR prompt_factory_model=False score="+$score+" report="+$ReportPath);exit 1}
Write-Host ("OK prompt_factory_model=True repair=E01-SMOKE-SCORE-REPAIR-001 score="+$score+" report="+$ReportPath+" next=E02_LECTOR_DE_PLAN_DE_DESARROLLO")
