$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$cfgPath="data/local-runtime-fix/remote-ollama-target.local.json"
if(!(Test-Path $cfgPath)){Write-Host "NO_GO remote_config_missing=True";exit 2}
$cfg=Get-Content $cfgPath -Raw|ConvertFrom-Json
if(-not $cfg.enabled -or -not $cfg.probe_allowed){Write-Host "NO_GO remote_probe_not_enabled=True inference=False model_download=False next=SET_MAIN_PC_IP_AND_ENABLE_PROBE";exit 2}
if($cfg.base_url -match "REPLACE_WITH_MAIN_PC_IP"){Write-Host "NO_GO remote_ip_placeholder=True";exit 2}
$uri=($cfg.base_url.TrimEnd("/")+$cfg.probe_path)
try{$r=Invoke-RestMethod -Uri $uri -Method Get -TimeoutSec 3;Write-Host "OK remote_ollama_probe=True endpoint=$uri inference=False model_download=False"}catch{Write-Host ("NO_GO remote_ollama_probe_failed=True endpoint="+$uri+" message="+$_.Exception.Message);exit 2}
