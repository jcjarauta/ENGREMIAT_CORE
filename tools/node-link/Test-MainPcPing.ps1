$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$cfgPath="data/node-link/main-pc-endpoint.local.json"
if(!(Test-Path $cfgPath)){Write-Host "NO_GO main_pc_endpoint_missing=True next=SET_MAIN_PC_ENDPOINT";exit 2}
$cfg=Get-Content $cfgPath -Raw|ConvertFrom-Json
$target=$(if($cfg.ip){$cfg.ip}else{$cfg.host})
if([string]::IsNullOrWhiteSpace($target)){Write-Host "NO_GO target_missing=True";exit 2}
$ok=Test-Connection -ComputerName $target -Count 2 -Quiet -ErrorAction SilentlyContinue
Write-Host ("OK main_pc_ping_tested=True target="+$target+" ping="+$ok+" firewall_changed=False services_changed=False")
