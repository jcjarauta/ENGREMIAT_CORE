$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$cline=Get-Command cline -ErrorAction SilentlyContinue
if(-not $cline){Write-Host "NO_GO cline_missing=True";exit 2}
Write-Host "OK cline_ready_controlled=True launch_task=False worker_real_execution=False auto_apply=False git_write=False" -ForegroundColor Green
