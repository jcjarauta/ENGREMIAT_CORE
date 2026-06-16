param([string]$ReportPath="reports/prompt-factory/e07-demo-core-mvp-cierre/prompt-factory-readiness-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$checks=@();$score=0;function AddReadyCheck([string]$id,[bool]$ok,[int]$points,[string]$message){if($ok){$script:score+=$points};$script:checks+=[ordered]@{id=$id;ok=$ok;points=$points;message=$message}}
AddReadyCheck "e01_model" (Test-Path -LiteralPath "reports/prompt-factory/e01-modelo-prompt-factory/prompt-factory-e01-model-validation-report.json" -PathType Leaf) 10 "E01"
AddReadyCheck "e02_reader" (Test-Path -LiteralPath "reports/prompt-factory/e02-lector-plan-desarrollo/prompt-factory-e02-plan-reader-validation-report.json" -PathType Leaf) 10 "E02"
AddReadyCheck "e03_prompt_next" (Test-Path -LiteralPath "reports/prompt-factory/e03-generador-prompt-next/prompt-factory-e03-prompt-next-validation-report.json" -PathType Leaf) 10 "E03"
AddReadyCheck "e04_prompt_repair" (Test-Path -LiteralPath "reports/prompt-factory/e04-generador-prompt-repair/prompt-factory-e04-prompt-repair-validation-report.json" -PathType Leaf) 10 "E04"
AddReadyCheck "e05_outbox_inbox" (Test-Path -LiteralPath "reports/prompt-factory/e05-outbox-inbox-handoff/prompt-factory-e05-outbox-inbox-validation-report.json" -PathType Leaf) 10 "E05"
AddReadyCheck "e06_commands" (Test-Path -LiteralPath "reports/prompt-factory/e06-integracion-eng-ps1/prompt-factory-e06-command-hub-validation-report.json" -PathType Leaf) 10 "E06"
AddReadyCheck "core_mvp_next_step" (Test-Path -LiteralPath "data/prompt-factory/out/core-mvp-next-step.json" -PathType Leaf) 10 "core-mvp-next-step"
AddReadyCheck "core_mvp_prompt" (Test-Path -LiteralPath "data/prompt-factory/out/PROMPT_NEXT_CORE_MVP_001.md" -PathType Leaf) 10 "PROMPT_NEXT_CORE_MVP_001"
AddReadyCheck "active_prompt" (Test-Path -LiteralPath "prompts/outbox/ACTIVE_PROMPT.md" -PathType Leaf) 10 "ACTIVE_PROMPT"
AddReadyCheck "commands_available" ((Test-Path -LiteralPath "eng.ps1" -PathType Leaf) -and (Test-Path -LiteralPath "tools/prompt-factory/Invoke-PromptFactoryCommand.ps1" -PathType Leaf)) 10 "command hub"
if($score -gt 100){$score=100};$ok=($score -ge 90);$rep=[ordered]@{objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E07";repair="E07-EMPTY-COMPLETEDSTEPS-REPAIR-001";block_id="B07.2";step_id="P07.2.2";status=$(if($ok){"OK"}else{"NO_GO"});validation_passed=$ok;score=$score;threshold=90;checks=$checks;external_network=$false;git=$false;decision=$(if($ok){"PROMPT_FACTORY_READY_FOR_CORE_MVP"}else{"REPAIR_PROMPT_FACTORY_E07"});next=$(if($ok){"ENGREMIAT_CORE_MVP_001"}else{"REPAIR_PROMPT_FACTORY_E07"});checked_at=(Get-Date).ToString("s")}
WriteJson $ReportPath $rep
if(-not $ok){Write-Host ("ERR prompt_factory_readiness=False score="+$score+" report="+$ReportPath);exit 1}
Write-Host ("OK prompt_factory_readiness=True repair=E07-EMPTY-COMPLETEDSTEPS-REPAIR-001 score="+$score+" decision=PROMPT_FACTORY_READY_FOR_CORE_MVP report="+$ReportPath)
