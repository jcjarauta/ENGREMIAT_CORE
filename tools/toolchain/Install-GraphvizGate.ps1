$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not (Get-Command winget -ErrorAction SilentlyContinue)){Write-Host "NO_GO winget_missing=True install_graphviz_executed=False optional=True";exit 2}
if(Get-Command dot -ErrorAction SilentlyContinue){Write-Host "OK graphviz_already_installed=True optional=True";exit 0}
if($args[0] -ne "--execute"){Write-Host "NO_GO Install-GraphvizGate execute=False hint=run_with_--execute optional=True";exit 0}
& winget install --id Graphviz.Graphviz --silent --accept-package-agreements --accept-source-agreements
exit $LASTEXITCODE
