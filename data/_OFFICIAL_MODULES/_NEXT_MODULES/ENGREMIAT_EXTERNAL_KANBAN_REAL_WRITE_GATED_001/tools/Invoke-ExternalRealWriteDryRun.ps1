$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_EXTERNAL_KANBAN_REAL_WRITE_GATED_001'
$report='C:\ENGREMIAT_CORE\reports\external-kanban-real-write-gated-001'
$planPath="$report\real-write-plan.json"
if(!(Test-Path $planPath)){throw "MISSING_PLAN $planPath"}
$plan=Get-Content -Raw $planPath|ConvertFrom-Json
$sim=@()
foreach($op in @($plan.operations)){
 $sim+=[ordered]@{operation_id=$op.operation_id;target=$op.target;card_id=$op.card_id;would_execute=$true;executed=$false;reason='DRY_RUN_ONLY_NO_TARGET_CALL'}
}
$out=[ordered]@{package_id=$package;tool='Invoke-ExternalRealWriteDryRun';status='PASS';operations_simulated=$sim.Count;external_write_executed=$false;sheets_write=$false;cline_write=$false;api_called=$false;ready_for_go_no_go=$true;simulated_operations=$sim}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\real-write-dry-run-report.json"
$out|ConvertTo-Json -Depth 100
