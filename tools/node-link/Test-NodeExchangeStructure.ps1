$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$required=@("data/node-link/inbox","data/node-link/outbox","data/node-link/receipts","data/node-link/staging","data/node-link/node-exchange-policy.json","data/node-link/outbox/sample-node-packet.json")
$missing=@()
foreach($p in $required){if(!(Test-Path -LiteralPath $p)){$missing+=$p}}
if($missing.Count -gt 0){Write-Host ("NO_GO missing="+($missing -join ","));exit 2}
$packet=Get-Content "data/node-link/outbox/sample-node-packet.json" -Raw|ConvertFrom-Json
if($packet.security.remote_execution -ne $false){Write-Host "NO_GO remote_execution_not_false";exit 2}
Write-Host "OK node_exchange_structure=True network_required=False main_pc_can_be_off=True" -ForegroundColor Green
