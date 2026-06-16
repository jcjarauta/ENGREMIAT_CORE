$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not (Get-Command winget -ErrorAction SilentlyContinue)){Write-Host "NO_GO winget_missing=True install_node_executed=False next=MANUAL_INSTALL_NODE_OR_ENABLE_WINGET";exit 2}
if(Get-Command node -ErrorAction SilentlyContinue){Write-Host "OK node_already_installed=True";exit 0}
if($args[0] -ne "--execute"){Write-Host "NO_GO Install-NodeRuntimeGate execute=False hint=add_--execute";exit 0}
& winget install --id OpenJS.NodeJS.LTS --silent --accept-package-agreements --accept-source-agreements
exit $LASTEXITCODE
