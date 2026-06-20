$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_KANBAN_WRITE_GATED_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-write-gated-001'
$planPath="$report\kanban-write-plan.json"
$outPath="$report\kanban-write-dry-run-report.json"
if(!(Test-Path $planPath)){throw "MISSING_WRITE_PLAN $planPath"}
$plan=Get-Content -Raw $planPath|ConvertFrom-Json
$actions=@($plan.actions)
$simulated=@()
foreach($a in $actions){
 $simulated+=[ordered]@{action_id=$a.action_id;operation=$a.operation;would_write=$true;executed=$false;card_id=$a.card_id;column=$a.column;target='LOCAL_ARTIFACT_PREVIEW_ONLY'}
}
$out=[ordered]@{package_id=$package;stage='E05';tool='Invoke-KanbanWriteDryRun';status='PASS';mode='DRY_RUN';actions_planned=$actions.Count;actions_simulated=$simulated.Count;real_write_executed=$false;external_write_executed=$false;local_artifact_written=$false;ready_for_gated_local_write=$true;simulated_actions=$simulated}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 $outPath
$out|ConvertTo-Json -Depth 100
