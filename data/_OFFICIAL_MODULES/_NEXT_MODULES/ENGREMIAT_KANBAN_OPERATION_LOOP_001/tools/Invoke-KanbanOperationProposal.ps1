$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\kanban-operation-loop-001'
$priority='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001\top-priority-recommendations.json'
$top=Get-Content -Raw $priority|ConvertFrom-Json
$rec=@($top.recommendations|Select-Object -First 1)
if($rec.Count -eq 0){$proposal=[ordered]@{status='NO_CANDIDATE';gate_required=$false}}else{$r=$rec[0];$proposal=[ordered]@{status='PASS';proposal_id='OP-PROP-001';recommended_card_id=$r.card_id;title=$r.title;priority_score=$r.priority_score;reasons=$r.reasons;recommended_action='REVIEW_AND_AUTHORIZE_NEXT_OPERATION';gate_required=$true;execution_default='SAFE_BLOCKED'}}
$proposal|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\operation-proposal.json"
$proposal|ConvertTo-Json -Depth 100
