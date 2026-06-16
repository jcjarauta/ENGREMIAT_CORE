$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$schemaPath="data/controlled-worker-adapters/worker-execution-gate-schema.json"
$decisionPath="data/controlled-worker-adapters/sample-human-gate-decision.json"
if(!(Test-Path $schemaPath)){Write-Host "NO_GO gate_schema_missing=True";exit 2}
if(!(Test-Path $decisionPath)){Write-Host "NO_GO sample_decision_missing=True";exit 2}
$s=Get-Content $schemaPath -Raw|ConvertFrom-Json
$d=Get-Content $decisionPath -Raw|ConvertFrom-Json
$problems=@()
if($s.default_decision -ne "DEFER"){$problems+="schema_default_not_defer"}
if(($s.valid_decisions -join ",") -notmatch "APPROVE"){$problems+="approve_missing"}
if(($s.valid_decisions -join ",") -notmatch "REJECT"){$problems+="reject_missing"}
if(($s.valid_decisions -join ",") -notmatch "DEFER"){$problems+="defer_missing"}
if($d.decision -ne "DEFER"){$problems+="sample_not_defer"}
if($d.execution_allowed -ne $false){$problems+="execution_allowed_unexpected"}
if($d.human_confirmation -ne $false){$problems+="human_confirmation_unexpected"}
if($problems.Count -gt 0){Write-Host ("NO_GO problems="+($problems -join ","));exit 2}
Write-Host "OK worker_gate_default_deny=True decision=DEFER execution_allowed=False worker_real_execution=False auto_apply=False git_write=False" -ForegroundColor Green
