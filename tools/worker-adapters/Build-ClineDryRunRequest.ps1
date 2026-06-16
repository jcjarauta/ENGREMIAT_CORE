param([string]$Title="Generated Cline dry-run request",[string]$Prompt="No real execution. Validate adapter only.")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$outDir="data/controlled-worker-adapters/cline"
if(!(Test-Path $outDir)){New-Item -ItemType Directory -Path $outDir -Force|Out-Null}
$request=[ordered]@{request_id=("REQ-CLINE-DRYRUN-"+(Get-Date -Format "yyyyMMddHHmmss"));worker_id="worker.cline.old_pc.local";worker_type="cline_cli_local";title=$Title;prompt=$Prompt;dry_run=$true;launch_task=$false;send_to_cline=$false;auto_apply=$false;auto_approve=$false;git_write=$false;worker_real_execution=$false;status="PREPARED_NOT_EXECUTED";created_at=(Get-Date).ToString("s")}
$path=Join-Path $outDir "generated-cline-request.json"
$request|ConvertTo-Json -Depth 50|Set-Content -LiteralPath $path -Encoding UTF8
Write-Host ("OK cline_dry_run_request_created=True path="+$path+" launch_task=False worker_real_execution=False auto_apply=False git_write=False") -ForegroundColor Green
