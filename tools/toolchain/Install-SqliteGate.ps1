$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not (Get-Command winget -ErrorAction SilentlyContinue)){Write-Host "NO_GO winget_missing=True install_sqlite_executed=False optional=True";exit 2}
if(Get-Command sqlite3 -ErrorAction SilentlyContinue){Write-Host "OK sqlite_already_installed=True optional=True";exit 0}
if($args[0] -ne "--execute"){Write-Host "NO_GO Install-SqliteGate execute=False hint=run_with_--execute optional=True";exit 0}
& winget install --id SQLite.SQLite --silent --accept-package-agreements --accept-source-agreements
exit $LASTEXITCODE
