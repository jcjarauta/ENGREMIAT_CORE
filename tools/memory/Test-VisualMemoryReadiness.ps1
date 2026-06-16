param([string]$ReportPath="reports/dev-visual-memory-operative/e06-operative-close-handoff/visual-memory-operative-readiness-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function ED($p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WJ($p,$o){ED(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$score=0;$checks=@();function AC($id,$path,$points){$ok=Test-Path -LiteralPath $path;if($ok){$script:score+=$points};$script:checks+=[ordered]@{id=$id;path=$path;points=$points;ok=$ok}}
AC "sync_report" "reports/dev-visual-memory-operative/e01-live-evidence-sync/visual-memory-sync-validation-report.json" 10
AC "navigation_report" "reports/dev-visual-memory-operative/e02-live-maps-navigation/visual-memory-operative-e02-navigation-validation-report.json" 10
AC "dashboard_report" "reports/dev-visual-memory-operative/e03-operative-dashboard/visual-memory-operative-e03-dashboard-validation-report.json" 10
AC "command_hub_report" "reports/dev-visual-memory-operative/e04-command-hub-human-flow/visual-memory-operative-e04-command-hub-validation-report.json" 10
AC "query_graph_report" "reports/dev-visual-memory-operative/e05-local-queryable-graph/visual-memory-operative-e05-queryable-graph-validation-report.json" 10
AC "eng_ps1" "eng.ps1" 10
AC "dashboard_html" "ENGREMIAT_MEMORY/dashboard/memory/index.html" 10
AC "events_jsonl" "ENGREMIAT_MEMORY/operative/events/events.jsonl" 10
AC "nodes_jsonl" "ENGREMIAT_MEMORY/graph/export/nodes.jsonl" 10
AC "docs_commands" "docs/ENG_COMMANDS.md" 10
$events=0;if(Test-Path -LiteralPath "ENGREMIAT_MEMORY/operative/events/events.jsonl"){$events=(Get-Content -LiteralPath "ENGREMIAT_MEMORY/operative/events/events.jsonl" -Encoding UTF8|Where-Object{![string]::IsNullOrWhiteSpace($_)}).Count};$nodes=0;if(Test-Path -LiteralPath "ENGREMIAT_MEMORY/graph/export/nodes.jsonl"){$nodes=(Get-Content -LiteralPath "ENGREMIAT_MEMORY/graph/export/nodes.jsonl" -Encoding UTF8|Where-Object{![string]::IsNullOrWhiteSpace($_)}).Count};$decision=if($score -ge 90){"GO_VISUAL_MEMORY_OPERATIVE"}else{"NO_GO_REPAIR_REQUIRED"};$rep=[ordered]@{objective_id="ENGREMIAT_DEV_VISUAL_MEMORY_OPERATIVE_002";stage_id="E06";step_id="P06.1.2";status=$(if($score -ge 90){"OK"}else{"NO_GO"});validation_passed=($score -ge 90);readiness=$score;threshold=90;decision=$decision;events_count=$events;nodes_count=$nodes;checks=$checks;external_network=$false;database=$false;git=$false;checked_at=(Get-Date).ToString("s");next=$(if($score -ge 90){"ENGREMIAT_CORE_MVP_001"}else{"REPAIR_VISUAL_MEMORY_OPERATIVE"})};WJ $ReportPath $rep;if($score -lt 90){Write-Host ("ERR visual_memory_readiness=False score="+$score+" threshold=90 report="+$ReportPath);exit 1};Write-Host ("OK visual_memory_readiness=True score="+$score+" decision="+$decision+" report="+$ReportPath)
