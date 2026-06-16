$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$nodeLinkPath="data/node-link/node-link-manifest.json"
$remotePath="data/local-runtime-fix/remote-ollama-target.local.json"
$problems=@()
if(!(Test-Path $nodeLinkPath)){$problems+="node_link_manifest_missing"}
if(!(Test-Path $remotePath)){$problems+="remote_ollama_target_missing"}
if(Test-Path $remotePath){$r=Get-Content $remotePath -Raw|ConvertFrom-Json;if(-not $r.base_url){$problems+="remote_base_url_missing"}}
if($problems.Count -gt 0){Write-Host ("NO_GO remote_ollama_bridge=False problems="+($problems -join ","));exit 2}
Write-Host "OK remote_ollama_bridge=True main_pc_can_be_off=True probe_executed=False inference=False worker_real_execution=False" -ForegroundColor Green
