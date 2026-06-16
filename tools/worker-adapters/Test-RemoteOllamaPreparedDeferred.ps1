$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$planPath="data/controlled-worker-adapters/ollama-remote/remote-ollama-safe-probe-plan.json"
$gatePath="data/controlled-worker-adapters/ollama-remote/remote-ollama-probe-gate.json"
if(!(Test-Path $planPath)){Write-Host "NO_GO safe_probe_plan_missing=True";exit 2}
if(!(Test-Path $gatePath)){Write-Host "NO_GO probe_gate_missing=True";exit 2}
$p=Get-Content $planPath -Raw|ConvertFrom-Json
$g=Get-Content $gatePath -Raw|ConvertFrom-Json
$problems=@()
if($p.probe_executed -ne $false){$problems+="probe_executed_unexpected"}
if($p.inference_allowed -ne $false){$problems+="inference_allowed_unexpected"}
if($g.enabled -ne $false){$problems+="gate_enabled_unexpected"}
if($g.allowed_endpoint -ne "/api/tags"){$problems+="allowed_endpoint_not_tags"}
if($g.ollama_generate_allowed -ne $false){$problems+="generate_allowed_unexpected"}
if($g.ollama_chat_allowed -ne $false){$problems+="chat_allowed_unexpected"}
if($problems.Count -gt 0){Write-Host ("NO_GO problems="+($problems -join ","));exit 2}
Write-Host "OK remote_ollama_prepared_deferred=True gate_enabled=False endpoint=/api/tags probe_executed=False inference=False main_pc_can_be_off=True" -ForegroundColor Green
