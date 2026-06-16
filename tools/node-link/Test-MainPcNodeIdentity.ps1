$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
function GetIps(){try{return @(Get-NetIPConfiguration|Where-Object{$_.IPv4Address -and $_.NetAdapter.Status -eq "Up"}|ForEach-Object{[ordered]@{interface=$_.InterfaceAlias;ipv4=$_.IPv4Address.IPAddress;gateway=$(if($_.IPv4DefaultGateway){$_.IPv4DefaultGateway.NextHop}else{$null});network_profile=$(if($_.NetProfile){$_.NetProfile.Name}else{$null})}})}catch{return @()}}
$out="$env:USERPROFILE\Desktop\main-pc-node-identity-report.json"
$report=[ordered]@{objective_id="ENGREMIAT_LOCAL_NODE_LINK_004A";stage="E01";node_role="COMPUTE_WORKER_NODE";machine=$env:COMPUTERNAME;user=$env:USERNAME;domain=$env:USERDOMAIN;cwd=(Get-Location).Path;powershell=$PSVersionTable.PSVersion.ToString();ips=GetIps;ollama_expected=$true;old_pc_local_ollama_install=$false;read_only=$true;firewall_changed=$false;services_changed=$false;created_at=(Get-Date).ToString("s")}
WriteJson $out $report
Write-Host ("OK MAIN_PC_IDENTITY_REPORT_CREATED path="+$out+" copy_to_old_pc=data/node-link/main-pc-node-identity-report.json") -ForegroundColor Green
