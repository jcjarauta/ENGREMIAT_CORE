param([string]$Decision='PENDING')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\kanban-recurrent-operation-001'
$resultPath="$report\recurrent-operation-result.json"
$evidencePath="$report\recurrent-operation-evidence.json"
function WriteJson($p,$o){$o|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 $p}
if($Decision -ne 'GO_MANUAL_RUN'){
 $result=[ordered]@{package_id='ENGREMIAT_KANBAN_RECURRENT_OPERATION_001';status='SAFE_BLOCKED';decision=$Decision;real_scheduler_created=$false;executed=$false;api_called=$false;external_write=$false;git=$false;reason='No GO_MANUAL_RUN provided'}
 WriteJson $resultPath $result
 WriteJson $evidencePath ([ordered]@{package_id='ENGREMIAT_KANBAN_RECURRENT_OPERATION_001';status='PASS';safe_blocked=$true;decision=$Decision;real_scheduler_created=$false;executed=$false})
 $result|ConvertTo-Json -Depth 100
 return
}
throw 'REAL_RECURRENT_EXECUTION_DISABLED_IN_THIS_READONLY_BLOCK'
