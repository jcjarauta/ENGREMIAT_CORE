param([string]$Authorization='')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_EXTERNAL_KANBAN_REAL_WRITE_GATED_001'
$report='C:\ENGREMIAT_CORE\reports\external-kanban-real-write-gated-001'
$requiredAuth='AUTORIZO_EXTERNAL_KANBAN_REAL_WRITE_GATED'
$planPath="$report\real-write-plan.json"
$resultPath="$report\external-real-write-result.json"
$rollbackPath="$report\external-write-rollback-package.json"
function WriteJson($p,$o){$o|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 $p}
if($Authorization -ne $requiredAuth){
 $blocked=[ordered]@{package_id=$package;stage='E06';status='BLOCKED';authorization_required=$requiredAuth;authorization_status='PENDING_EXPLICIT_HUMAN_AUTHORIZATION';external_write_executed=$false;sheets_write=$false;cline_write=$false;api_called=$false;message='No se ejecuta escritura externa sin autorizacion literal.'}
 WriteJson $resultPath $blocked
 WriteJson $rollbackPath ([ordered]@{package_id=$package;status='NO_ROLLBACK_NEEDED';reason='NO_EXTERNAL_WRITE_EXECUTED';manual_rollback_required=$false})
 $blocked|ConvertTo-Json -Depth 100
 return
}
throw 'REAL_EXTERNAL_WRITE_DISABLED_UNTIL_TARGET_ADAPTER_IMPLEMENTED'
