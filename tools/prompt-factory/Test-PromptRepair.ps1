param([string]$IssuePath="data/prompt-factory/out/last-issue.json",[string]$PromptPath="data/prompt-factory/out/PROMPT_REPAIR.md",[string]$ReportPath="reports/prompt-factory/e04-generador-prompt-repair/prompt-repair-smoke-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$checks=@();$score=0;function AddRepairCheck([string]$id,[bool]$ok,[int]$points,[string]$message){if($ok){$script:score+=$points};$script:checks+=[ordered]@{id=$id;ok=$ok;points=$points;message=$message}}
$issueExists=Test-Path -LiteralPath $IssuePath -PathType Leaf;$promptExists=Test-Path -LiteralPath $PromptPath -PathType Leaf;AddRepairCheck "issue_exists" $issueExists 15 $IssuePath;AddRepairCheck "prompt_exists" $promptExists 15 $PromptPath
$issueOk=$false;if($issueExists){try{$i=Get-Content -LiteralPath $IssuePath -Raw -Encoding UTF8|ConvertFrom-Json;$issueOk=($i.issue.status -and $i.decision)}catch{}};AddRepairCheck "issue_schema_ok" $issueOk 15 $IssuePath
$txt="";if($promptExists){$txt=Get-Content -LiteralPath $PromptPath -Raw -Encoding UTF8}
$must=@("## ROL","## ISSUE DETECTADO","## LÍMITES DE SEGURIDAD","## ARCHIVOS PERMITIDOS","## ARCHIVOS PROHIBIDOS","## TAREA DE REPARACIÓN","## FORMATO DE SALIDA WORKEROUTPUT","## CRITERIO GO / NO_GO","external_network=False","git_write=False","NO_GO")
foreach($m in $must){AddRepairCheck ("contains_"+($m -replace "[^A-Za-z0-9]","_")) ($txt -match [regex]::Escape($m)) 5 $m}
$ok=($score -ge 90);if($score -gt 100){$score=100};$rep=[ordered]@{objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E04";block_id="B04.3";step_id="P04.3.2";status=$(if($ok){"OK"}else{"NO_GO"});validation_passed=$ok;score=$score;threshold=90;checks=$checks;issue=$IssuePath;prompt=$PromptPath;external_network=$false;git=$false;next=$(if($ok){"E05_OUTBOX_INBOX_HANDOFF"}else{"REPAIR_PROMPT_FACTORY_E04"});checked_at=(Get-Date).ToString("s")}
WriteJson $ReportPath $rep
if(-not $ok){Write-Host ("ERR prompt_repair=False score="+$score+" report="+$ReportPath);exit 1}
Write-Host ("OK prompt_repair=True score="+$score+" report="+$ReportPath+" next=E05_OUTBOX_INBOX_HANDOFF")
