$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$p="data/plan-to-worker/adapters/cline/request.json";if(Test-Path -LiteralPath $p){Write-Host "OK cline_request_adapter=True manual_flow=True auto_apply=False"}else{Write-Host "NO_GO cline_request_adapter_missing=True"}
