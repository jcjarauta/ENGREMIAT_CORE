$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\kanban-operation-loop-001'
$priority='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001\top-priority-recommendations.json'
$externalClose='C:\ENGREMIAT_CORE\reports\external-kanban-real-write-gated-001\e08-close-external-real-write-report.json'
$top=Get-Content -Raw $priority|ConvertFrom-Json
$close=$null;if(Test-Path $externalClose){$close=Get-Content -Raw $externalClose|ConvertFrom-Json}
$out=[ordered]@{package_id='ENGREMIAT_KANBAN_OPERATION_LOOP_001';stage='E03';status='PASS';state='SCAN';readonly=$true;top_recommendations_count=@($top.recommendations).Count;external_real_write_status=if($close){$close.status}else{'MISSING_OPTIONAL'};external_write_executed=if($close){$close.external_write_executed}else{$false};snapshot_utc=(Get-Date).ToUniversalTime().ToString('o')}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\operation-snapshot-report.json"
$out|ConvertTo-Json -Depth 100
