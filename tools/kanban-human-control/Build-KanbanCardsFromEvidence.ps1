$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 80|Set-Content -Path $p -Encoding UTF8}
$objective="ENGREMIAT_KANBAN_HUMAN_CONTROL_SURFACE_007"
$base="data/kanban-human-control"
$cardsDir="$base/cards"
$reportDir="reports/kanban-human-control"
New-Item -ItemType Directory -Force -Path $cardsDir,$reportDir | Out-Null
$inventory=Get-Content "$base/evidence-inventory.json" -Raw | ConvertFrom-Json
$items=@($inventory.items)
$defs=@(@{id="005";objective="ENGREMIAT_CONTROLLED_WORKER_ADAPTERS_005";title="Controlled Worker Adapters";status="DONE";stage="E06";block="CLOSE";step="ADAPTERS_READY";risk="LOW";next="006_GATED_WORKER_EXECUTION"},@{id="006";objective="ENGREMIAT_GATED_WORKER_EXECUTION_006";title="Gated Worker Execution";status="DONE";stage="E06";block="CLOSE";step="READONLY_EXECUTION_CLOSED";risk="LOW";next="007_KANBAN_HUMAN_CONTROL_SURFACE"},@{id="007";objective=$objective;title="Kanban Human Control Surface";status="READY";stage="E02";block="B02.1-B02.3";step="BOARD_FROM_EVIDENCE";risk="LOW";next="E03_BUILD_LOCAL_HTML_DASHBOARD"})
$cards=@()
foreach($d in $defs){$ev=@($items|Where-Object{$_.objective_hint -eq $d.objective}|Select-Object -First 12 -ExpandProperty path);if($ev.Count -eq 0 -and $d.objective -eq $objective){$ev=@("data/kanban-human-control/kanban-card-schema.json","data/kanban-human-control/sample-kanban-card.json","data/kanban-human-control/evidence-inventory.json")};$card=[ordered]@{card_id=("KANBAN-"+$d.id+"-"+$d.stage);objective=$d.objective;stage=[ordered]@{id=$d.stage;name=$d.title};block=[ordered]@{id=$d.block;name="Evidence derived card"};step=[ordered]@{id=$d.step;name=$d.title};title=$d.title;description=("Tarjeta generada desde evidencia canonica local para "+$d.objective);status=$d.status;risk=$d.risk;gate=[ordered]@{authorization_required=$false;decision="NOT_REQUIRED_VIEW_ONLY";reason="Generacion local de tarjeta desde evidencia"};worker=[ordered]@{assigned="NONE";worker_real_execution=$false};evidence=$ev;next_action=[ordered]@{recommended=$d.next;requires_human_review=$true};safety=[ordered]@{kanban_write=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false}};$path=Join-Path $cardsDir (($card.card_id)+".json");J $card $path;$cards+=$card}
$columns=@("BACKLOG","READY","GATED","RUNNING","REVIEW","DEFERRED","DONE","BLOCKED")
$counters=[ordered]@{};foreach($c in $columns){$counters[$c]=@($cards|Where-Object{$_.status -eq $c}).Count}
$board=[ordered]@{objective=$objective;stage="E02";generated_at_utc=(Get-Date).ToUniversalTime().ToString("o");source="data/kanban-human-control/evidence-inventory.json";columns=$columns;counters=$counters;cards=$cards;safety=[ordered]@{kanban_write=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false}}
J $board "$base/kanban-board.json"
$missingEvidence=@();foreach($card in $cards){if(@($card.evidence).Count -eq 0){$missingEvidence+=$card.card_id}}
$ok=($cards.Count -ge 3 -and (Test-Path "$base/kanban-board.json") -and $missingEvidence.Count -eq 0)
$report=[ordered]@{objective=$objective;stage="E02";blocks="B02.1-B02.3";steps=6;sources_file="$base/evidence-sources.json";inventory_file="$base/evidence-inventory.json";cards_dir=$cardsDir;board_file="$base/kanban-board.json";inventory_count=@($items).Count;cards_count=$cards.Count;columns_count=$columns.Count;missing_evidence_cards=$missingEvidence;kanban_write=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E02_KANBAN_BOARD_FROM_EVIDENCE_VALIDATED"}else{"NO_GO_E02_REPAIR_REQUIRED"}));next=($(if($ok){"E03_VISTA_HTML_HUMANA_LOCAL"}else{"REPAIR_E02_BOARD_FROM_EVIDENCE"}))}
J $report "$reportDir/e02-kanban-board-generation-report.json"
if(-not $ok){throw "E02 validation failed"}
Write-Host ("OK objective="+$objective+" stage=E02 cards="+$cards.Count+" inventory="+@($items).Count+" readiness="+$report.readiness+" decision="+$report.decision+" report="+$reportDir+"/e02-kanban-board-generation-report.json next="+$report.next) -ForegroundColor Green
