$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$contractPath="data/controlled-worker-adapters/worker-adapter-contract.json"
$policyPath="data/controlled-worker-adapters/controlled-worker-policy.json"
if(!(Test-Path $contractPath)){Write-Host "NO_GO contract_missing=True";exit 2}
if(!(Test-Path $policyPath)){Write-Host "NO_GO policy_missing=True";exit 2}
$c=Get-Content $contractPath -Raw|ConvertFrom-Json
$p=Get-Content $policyPath -Raw|ConvertFrom-Json
$problems=@()
if($c.default_dry_run -ne $true){$problems+="default_dry_run_not_true"}
if($c.human_gate_required -ne $true){$problems+="human_gate_required_not_true"}
if($p.mode -ne "DEFAULT_DENY"){$problems+="policy_not_default_deny"}
if($p.worker_real_execution_allowed -ne $false){$problems+="worker_execution_allowed_unexpected"}
if($p.auto_apply -ne $false){$problems+="auto_apply_not_false"}
if($p.git_write -ne $false){$problems+="git_write_not_false"}
if($problems.Count -gt 0){Write-Host ("NO_GO problems="+($problems -join ","));exit 2}
Write-Host "OK worker_adapter_contract=True policy=True default_deny=True worker_real_execution=False auto_apply=False git_write=False" -ForegroundColor Green
