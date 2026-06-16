param([string]$Service="health")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$contractPath="data/node-link/main-pc-services-contract.json"
if(!(Test-Path $contractPath)){Write-Host "NO_GO service_contract_missing=True";exit 2}
$contract=Get-Content $contractPath -Raw|ConvertFrom-Json
$svc=$contract.allowed_future_services|Where-Object{$_.service -eq $Service}|Select-Object -First 1
if(-not $svc){Write-Host ("NO_GO unknown_service="+$Service);exit 2}
Write-Host ("NO_GO service_probe_deferred=True service="+$Service+" host="+$contract.main_pc_host+" ip="+$contract.main_pc_ip+" port="+$svc.port+" path="+$svc.path+" inference=False firewall_changed=False next=ENABLE_SERVICE_GATE_ON_MAIN_PC") -ForegroundColor Yellow
exit 2
