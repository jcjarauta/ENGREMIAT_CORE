$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Resolve-Path (Join-Path $PSScriptRoot "../..")).Path
$artifact=Join-Path $root "data/operational-apply-136/OPERATIONAL_ARTIFACT.md"
if(!(Test-Path $artifact)){throw "No existe artefacto operativo: $artifact"}
Write-Host "OK opening_operational_artifact=True path=$artifact" -ForegroundColor Green
Start-Process $artifact
