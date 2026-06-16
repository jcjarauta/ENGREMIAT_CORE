$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$cfg="data/local-runtime-fix/remote-ollama-target.local.json"
if(!(Test-Path $cfg)){Write-Host "NO_GO remote_config_missing=True create_from=data/local-runtime-fix/remote-ollama-target.example.json";exit 2}
Write-Host "OK remote_ollama_contract_config_present=True inference=False model_download=False"
