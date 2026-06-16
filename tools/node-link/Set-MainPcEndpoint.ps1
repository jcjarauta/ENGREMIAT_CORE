param([Parameter(Mandatory=$true)][string]$Ip,[string]$HostName="MAIN-PC")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$obj=[ordered]@{node_id="MAIN-PC";role="COMPUTE_WORKER_NODE";host=$HostName;ip=$Ip;endpoint_status="MANUAL_SET";ping_allowed=$true;http_probe_allowed=$false;ollama_probe_allowed=$false;firewall_changed=$false;services_changed=$false;created_at=(Get-Date).ToString("s")}
WriteJson "data/node-link/main-pc-endpoint.local.json" $obj
Write-Host ("OK MAIN_PC_ENDPOINT_SET ip="+$Ip+" host="+$HostName+" next=TEST_MAIN_PC_PING") -ForegroundColor Green
