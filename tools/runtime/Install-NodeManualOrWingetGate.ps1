$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(Get-Command node -ErrorAction SilentlyContinue){Write-Host "OK node_already_available=True";exit 0}
if(-not (Get-Command winget -ErrorAction SilentlyContinue)){Write-Host "NO_GO winget_missing=True node_missing=True install_executed=False next=MANUAL_INSTALL_NODE_LTS_REOPEN_TERMINAL";exit 2}
if($args[0] -ne "--execute"){Write-Host "NO_GO execute=False install_executed=False hint=run_with_--execute";exit 0}
& winget install --id OpenJS.NodeJS.LTS --silent --accept-package-agreements --accept-source-agreements
exit $LASTEXITCODE
