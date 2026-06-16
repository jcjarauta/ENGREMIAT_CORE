param([switch]$Execute)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not (Get-Command node -ErrorAction SilentlyContinue)){Write-Host "NO_GO node_missing=True install_executed=False next=REPAIR_NODE_NPM_FIRST";exit 2}
if(-not (Get-Command npm -ErrorAction SilentlyContinue)){Write-Host "NO_GO npm_missing=True install_executed=False next=REPAIR_NODE_NPM_FIRST";exit 2}
if(Get-Command cline -ErrorAction SilentlyContinue){Write-Host "OK cline_already_available=True install_executed=False worker_real_execution=False auto_apply=False";exit 0}
if(-not $Execute){Write-Host "NO_GO cline_missing=True install_executed=False hint=run_with_-Execute network_required=True worker_real_execution=False auto_apply=False";exit 2}
Write-Host "STATE installing_cline_cli=True via=npm install_executed=True worker_real_execution=False auto_apply=False" -ForegroundColor Cyan
npm install -g cline
if($LASTEXITCODE -ne 0){throw ("npm install -g cline failed exit="+$LASTEXITCODE)}
Write-Host "OK cline_install_attempted=True next=REOPEN_OR_REFRESH_PATH_AND_RERUN_E05" -ForegroundColor Green
