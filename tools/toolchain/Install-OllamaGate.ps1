$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not (Get-Command winget -ErrorAction SilentlyContinue)){Write-Host "NO_GO winget_missing=True install_ollama_executed=False next=MANUAL_INSTALL_OLLAMA_OR_ENABLE_WINGET";exit 2}
if(Get-Command ollama -ErrorAction SilentlyContinue){Write-Host "OK ollama_already_installed=True model_download=False";exit 0}
if($args[0] -ne "--execute"){Write-Host "NO_GO Install-OllamaGate execute=False hint=add_--execute model_download=False";exit 0}
& winget install --id Ollama.Ollama --silent --accept-package-agreements --accept-source-agreements
exit $LASTEXITCODE
