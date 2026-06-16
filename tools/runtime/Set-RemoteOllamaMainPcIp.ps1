$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
param([Parameter(Mandatory=$true)][string]$Ip)
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJson([string]$Path,$Obj){EnsureDir (Split-Path -Parent $Path);$Obj|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$cfg=[ordered]@{enabled=$true;node_id="MAIN-PC";role="AI_COMPUTE_NODE";base_url=("http://"+$Ip+":11434");probe_path="/api/tags";probe_allowed=$true;inference_allowed=$false;model_download_allowed=$false;old_pc_local_ollama_install=$false;configured_by="Set-RemoteOllamaMainPcIp";notes="Solo permite GET /api/tags. No inferencia."}
WriteJson "data/local-runtime-fix/remote-ollama-target.local.json" $cfg
Write-Host ("OK REMOTE_OLLAMA_IP_SET ip="+$Ip+" endpoint=http://"+$Ip+":11434 next=RUN_REMOTE_OLLAMA_SAFE_PROBE") -ForegroundColor Green
