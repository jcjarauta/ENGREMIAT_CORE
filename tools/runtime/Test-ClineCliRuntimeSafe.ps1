$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$env:Path=[System.Environment]::GetEnvironmentVariable("Path","Machine")+";"+[System.Environment]::GetEnvironmentVariable("Path","User")
if(-not (Get-Command node -ErrorAction SilentlyContinue)){Write-Host "NO_GO node_missing=True";exit 2}
if(-not (Get-Command npm -ErrorAction SilentlyContinue)){Write-Host "NO_GO npm_missing=True";exit 2}
$cline=Get-Command cline -ErrorAction SilentlyContinue
if(-not $cline){Write-Host "NO_GO cline_missing=True install_executed=False worker_real_execution=False auto_apply=False";exit 2}
Write-Host ("OK cline_cli_detected=True path="+$cline.Source+" worker_real_execution=False auto_apply=False") -ForegroundColor Green
