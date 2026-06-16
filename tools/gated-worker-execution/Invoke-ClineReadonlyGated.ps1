param([switch]$ExecuteGate)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$base="data/gated-worker-execution"
$reports="reports/gated-worker-execution"
EnsureDir $reports
$requestPath=Join-Path $base "first-cline-readonly-request.json"
$gatePath=Join-Path $base "first-human-approve-readonly.json"
if(!(Test-Path $requestPath)){throw "request_missing"}
if(!(Test-Path $gatePath)){throw "gate_missing"}
$request=Get-Content $requestPath -Raw|ConvertFrom-Json
$gate=Get-Content $gatePath -Raw|ConvertFrom-Json
$cline=Get-Command cline -ErrorAction SilentlyContinue
if(-not $cline){throw "cline_missing"}
$allowed=($ExecuteGate -and $gate.decision -eq "APPROVE" -and $gate.human_confirmation -eq $true -and $gate.conditions.write_files -eq $false -and $gate.conditions.run_commands -eq $false -and $gate.conditions.auto_apply -eq $false -and $gate.conditions.git_write -eq $false)
$prompt=$request.prompt
$preview=[ordered]@{objective_id="ENGREMIAT_GATED_WORKER_EXECUTION_006";stage="E03";request_id=$request.request_id;worker_id=$request.worker_id;cline_path=$cline.Source;execute_gate=[bool]$ExecuteGate;execution_allowed=$allowed;preview_only=(-not $allowed);prompt_preview=$prompt;write_files=$false;run_commands=$false;auto_apply=$false;git_write=$false;remote_inference=$false;worker_executed=$false;created_at=(Get-Date).ToString("s")}
WriteJson (Join-Path $reports "cline-dispatch-preview.json") $preview
if(-not $allowed){Write-Host "OK cline_dispatch_preview=True executed=False reason=ExecuteGate_not_used_or_gate_invalid write_files=False run_commands=False auto_apply=False git_write=False" -ForegroundColor Green;exit 0}
Write-Host "NO_GO execution_path_reserved_for_E04=True cline_not_launched_in_E03=True" -ForegroundColor Yellow
exit 3
