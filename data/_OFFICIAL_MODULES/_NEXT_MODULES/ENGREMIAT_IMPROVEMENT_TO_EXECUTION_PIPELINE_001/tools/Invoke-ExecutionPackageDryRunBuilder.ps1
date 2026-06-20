$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001'
$report='C:\ENGREMIAT_CORE\reports\improvement-to-execution-pipeline-001'
$p=Get-Content -Raw "$report\technical-proposal.json"|ConvertFrom-Json
$actions=@(
 [ordered]@{action_id='DRY-ACTION-001';action='CREATE_CONTRACTS';executes=$false;requires_gate=$true},
 [ordered]@{action_id='DRY-ACTION-002';action='CREATE_TOOLS';executes=$false;requires_gate=$true},
 [ordered]@{action_id='DRY-ACTION-003';action='RUN_VALIDATION';executes=$false;requires_gate=$true}
)
$out=[ordered]@{package_id=$package;status='PASS';mode='DRY_RUN_ONLY';source_proposal=$p.proposal_id;actions=$actions;gate_required=$true;allowed_decisions=@('GO','DEFER','BLOCK');real_execution=$false;source_code_write=$false;git=$false}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\execution-package-dry-run.json"
[ordered]@{package_id=$package;status='PENDING_HUMAN_GATE';decision='PENDING';execute_authorized=$false;real_execution=$false}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\execution-gate-request.json"
$out|ConvertTo-Json -Depth 100
