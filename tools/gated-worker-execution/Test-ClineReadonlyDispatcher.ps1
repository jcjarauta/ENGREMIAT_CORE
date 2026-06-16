$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$invoke="tools/gated-worker-execution/Invoke-ClineReadonlyGated.ps1"
$preview="reports/gated-worker-execution/cline-dispatch-preview.json"
if(!(Test-Path $invoke)){Write-Host "NO_GO dispatcher_missing=True";exit 2}
powershell -NoProfile -ExecutionPolicy Bypass -File $invoke | Out-Null
if(!(Test-Path $preview)){Write-Host "NO_GO preview_missing=True";exit 2}
$p=Get-Content $preview -Raw|ConvertFrom-Json
$problems=@()
if($p.worker_executed -ne $false){$problems+="worker_executed_unexpected"}
if($p.preview_only -ne $true){$problems+="preview_only_not_true"}
if($p.write_files -ne $false){$problems+="write_files_not_false"}
if($p.run_commands -ne $false){$problems+="run_commands_not_false"}
if($p.auto_apply -ne $false){$problems+="auto_apply_not_false"}
if($p.git_write -ne $false){$problems+="git_write_not_false"}
if($problems.Count -gt 0){Write-Host ("NO_GO problems="+($problems -join ","));exit 2}
Write-Host "OK cline_readonly_dispatcher_default_safe=True preview_only=True worker_executed=False write_files=False run_commands=False auto_apply=False git_write=False" -ForegroundColor Green
