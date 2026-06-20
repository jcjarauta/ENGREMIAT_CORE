param([string]$Decision='PENDING')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\kanban-operation-loop-001'
$proposal=Get-Content -Raw "$report\operation-proposal.json"|ConvertFrom-Json
$resultPath="$report\operation-loop-result.json"
$evidencePath="$report\operation-loop-evidence.json"
function WriteJson($p,$o){$o|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 $p}
if($Decision -ne 'GO'){
 $result=[ordered]@{package_id='ENGREMIAT_KANBAN_OPERATION_LOOP_001';stage='E06';status='SAFE_BLOCKED';decision=$Decision;executed=$false;external_action=$false;api_called=$false;git=$false;reason='Human GO not provided'}
 WriteJson $resultPath $result
 WriteJson $evidencePath ([ordered]@{package_id='ENGREMIAT_KANBAN_OPERATION_LOOP_001';status='PASS';proposal_id=$proposal.proposal_id;decision=$Decision;executed=$false;safe_blocked=$true})
 $result|ConvertTo-Json -Depth 100
 return
}
throw 'EXECUTION_DISABLED_IN_READONLY_OPERATION_LOOP'
