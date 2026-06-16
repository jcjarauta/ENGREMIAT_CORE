$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not (Get-Command node -ErrorAction SilentlyContinue)){Write-Host "NO_GO node_missing=True install_cline_executed=False next=INSTALL_NODE_FIRST";exit 2}
if(-not (Get-Command npm -ErrorAction SilentlyContinue)){Write-Host "NO_GO npm_missing=True install_cline_executed=False next=INSTALL_NODE_NPM_FIRST";exit 2}
if(Get-Command cline -ErrorAction SilentlyContinue){Write-Host "OK cline_already_installed=True worker_real_execution=False auto_apply=False";exit 0}
if($args[0] -ne "--execute"){Write-Host "NO_GO Install-ClineCliGate execute=False hint=run_with_--execute install_cline_executed=False";exit 0}
& npm install -g cline
exit $LASTEXITCODE
