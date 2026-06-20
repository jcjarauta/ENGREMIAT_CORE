$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\kanban-recurrent-operation-001'
$snap=Get-Content -Raw "$report\recurrent-operation-snapshot.json"|ConvertFrom-Json
$proposal=[ordered]@{package_id='ENGREMIAT_KANBAN_RECURRENT_OPERATION_001';proposal_id='RECURRENT-OP-PROP-001';status='PASS';recommended_cycle='MANUAL_OR_DAILY_REVIEW';recommended_next_action='Review top Kanban operation proposal and request human GO/DEFER/BLOCK';source_card_id=$snap.recommended_card_id;gate_required=$true;execution_default='SAFE_BLOCKED';real_scheduler_created=$false}
$proposal|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\recurrent-operation-proposal.json"
[ordered]@{package_id='ENGREMIAT_KANBAN_RECURRENT_OPERATION_001';status='PENDING_HUMAN_GATE';allowed_decisions=@('GO_MANUAL_RUN','DEFER','BLOCK');real_scheduler_creation=$false}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\recurrent-operation-gate-request.json"
$proposal|ConvertTo-Json -Depth 100
