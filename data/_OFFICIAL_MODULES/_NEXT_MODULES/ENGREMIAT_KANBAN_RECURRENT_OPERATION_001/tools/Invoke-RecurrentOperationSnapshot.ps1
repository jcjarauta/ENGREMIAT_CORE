$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\kanban-recurrent-operation-001'
$loopClose='C:\ENGREMIAT_CORE\reports\kanban-operation-loop-001\e08-close-operation-loop-report.json'
$proposalSrc='C:\ENGREMIAT_CORE\reports\kanban-operation-loop-001\operation-proposal.json'
$close=Get-Content -Raw $loopClose|ConvertFrom-Json
$proposal=$null;if(Test-Path $proposalSrc){$proposal=Get-Content -Raw $proposalSrc|ConvertFrom-Json}
$out=[ordered]@{package_id='ENGREMIAT_KANBAN_RECURRENT_OPERATION_001';stage='SNAPSHOT';status='PASS';readonly=$true;previous_loop_status=$close.status;previous_loop_safe_blocked=$close.safe_blocked;previous_next=$close.next;recommended_card_id=if($proposal){$proposal.recommended_card_id}else{$null};snapshot_utc=(Get-Date).ToUniversalTime().ToString('o')}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\recurrent-operation-snapshot.json"
$out|ConvertTo-Json -Depth 100
