$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$p="data/plan-to-worker/adapters/ollama/request.json";if(Test-Path -LiteralPath $p){Write-Host "OK ollama_request_adapter=True real_execution=False"}else{Write-Host "NO_GO ollama_request_adapter_missing=True"}
