$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 90|Set-Content -Path $p -Encoding UTF8}
$objective="ENGREMIAT_KANBAN_HUMAN_CONTROL_SURFACE_007"
$base="data/kanban-human-control"
$reports="reports/kanban-human-control"
$boardPath="$base/kanban-board.json"
$contractPath="$base/cline-kanban-adapter-contract.json"
$previewPath="$base/cline-kanban-export-preview.json"
$reportPath="$reports/e04-cline-kanban-adapter-preview-report.json"
if(-not(Test-Path $boardPath)){throw "Falta board: $boardPath"}
if(-not(Test-Path $contractPath)){throw "Falta contrato adapter: $contractPath"}
$board=Get-Content $boardPath -Raw|ConvertFrom-Json
$contract=Get-Content $contractPath -Raw|ConvertFrom-Json
$cards=@($board.cards)
$items=@()
foreach($card in $cards){$labels=@("ENGREMIAT",$card.status,$card.risk,$card.stage.id);$evidence=@($card.evidence);$body=("Objective: "+$card.objective+"`nStage: "+$card.stage.id+" "+$card.stage.name+"`nBlock: "+$card.block.id+" "+$card.block.name+"`nStep: "+$card.step.id+" "+$card.step.name+"`nDecision: "+$card.gate.decision+"`nNext: "+$card.next_action.recommended);$items+=[ordered]@{external_card_id=("CLINE-KANBAN-PREVIEW-"+$card.card_id);source_card_id=$card.card_id;title=$card.title;lane=$card.status;body=$body;labels=$labels;evidence_links=$evidence;gate_summary=[ordered]@{authorization_required=$card.gate.authorization_required;decision=$card.gate.decision;reason=$card.gate.reason};safety_flags=[ordered]@{kanban_write=$false;launch_cline_task=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false};proposed_action="PREVIEW_ONLY_NO_WRITE"}}
$preview=[ordered]@{objective=$objective;stage="E04";mode="PREVIEW_ONLY";contract=$contractPath;source_board=$boardPath;generated_at_utc=(Get-Date).ToUniversalTime().ToString("o");items_count=$items.Count;items=$items;safety=[ordered]@{kanban_write=$false;launch_cline_task=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false}}
J $preview $previewPath
$bad=@();foreach($it in $items){foreach($n in @("kanban_write","launch_cline_task","cline_task_created","worker_real_execution","auto_apply","git_write","remote_inference")){if($it.safety_flags.$n -ne $false){$bad+=($it.source_card_id+":"+$n)}}}
$ok=((Test-Path $previewPath) -and $items.Count -ge 1 -and $bad.Count -eq 0 -and $preview.safety.kanban_write -eq $false -and $preview.safety.launch_cline_task -eq $false -and $preview.safety.worker_real_execution -eq $false -and $preview.safety.auto_apply -eq $false)
$report=[ordered]@{objective=$objective;stage="E04";blocks="B04.1-B04.3";steps=6;adapter_contract=$contractPath;guide="docs/CLINE_KANBAN_ADAPTER_GUIDE.md";preview_file=$previewPath;source_board=$boardPath;preview_items_count=$items.Count;bad_safety_flags=$bad;kanban_write=$false;launch_cline_task=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false;real_kanban_sync=$false;decision=($(if($ok){"GO_E04_CLINE_KANBAN_PREVIEW_ADAPTER_VALIDATED"}else{"NO_GO_E04_REPAIR_REQUIRED"}));readiness=($(if($ok){100}else{70}));next=($(if($ok){"E05_KANBAN_WRITE_GATE_DEFER_BY_DEFAULT"}else{"REPAIR_E04_ADAPTER_PREVIEW"}))}
J $report $reportPath
if(-not $ok){throw "E04 validation failed"}
Write-Host ("OK objective="+$objective+" stage=E04 preview_items="+$items.Count+" readiness="+$report.readiness+" decision="+$report.decision+" preview="+$previewPath+" report="+$reportPath+" next="+$report.next) -ForegroundColor Green
