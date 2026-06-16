param([string]$Prompt="Analiza el estado y propone siguiente paso seguro. No escribas archivos ni ejecutes comandos.")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$base="data/gated-worker-execution"
EnsureDir $base
$request=[ordered]@{request_id=("REQ-FIRST-CLINE-READONLY-"+(Get-Date -Format "yyyyMMddHHmmss"));worker_id="worker.cline.old_pc.local";worker_type="cline_cli_local";title="Generated first Cline readonly request";prompt=$Prompt;readonly=$true;write_files=$false;run_commands=$false;auto_apply=$false;git_write=$false;remote_inference=$false;status="PREPARED_NOT_EXECUTED";created_at=(Get-Date).ToString("s")}
$path=Join-Path $base "generated-first-cline-readonly-request.json"
WriteJson $path $request
Write-Host ("OK first_cline_readonly_request_created=True path="+$path+" launch_task=False write_files=False run_commands=False auto_apply=False git_write=False") -ForegroundColor Green
