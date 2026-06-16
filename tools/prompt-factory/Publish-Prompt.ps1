param([string]$PromptPath="data/prompt-factory/out/PROMPT_NEXT.md",[string]$Type="NEXT",[string]$OutboxRoot="prompts/outbox")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
function Sha([string]$p){try{if(!(Test-Path -LiteralPath $p -PathType Leaf)){return $null};return ((Get-FileHash -LiteralPath $p -Algorithm SHA256).Hash).ToLowerInvariant()}catch{return $null}}
if(!(Test-Path -LiteralPath $PromptPath -PathType Leaf)){throw "Prompt no encontrado: $PromptPath"}
EnsureDir $OutboxRoot;EnsureDir (Join-Path $OutboxRoot "archive")
$id=("PROMPT-"+$Type+"-"+(Get-Date).ToString("yyyyMMdd-HHmmss"))
$active=Join-Path $OutboxRoot "ACTIVE_PROMPT.md";$archive=Join-Path (Join-Path $OutboxRoot "archive") ($id+".md")
Copy-Item -LiteralPath $PromptPath -Destination $active -Force;Copy-Item -LiteralPath $PromptPath -Destination $archive -Force
$manifestPath=Join-Path $OutboxRoot "manifest.json";$published=0;if(Test-Path -LiteralPath $manifestPath -PathType Leaf){try{$old=Get-Content -LiteralPath $manifestPath -Raw -Encoding UTF8|ConvertFrom-Json;$published=[int]$old.published_count}catch{}}
$m=[ordered]@{schema="prompt-outbox-manifest.v1";active_prompt=$active;active_prompt_id=$id;active_type=$Type;source=$PromptPath;archive=$archive;published_count=($published+1);sha256=(Sha $active);published_at=(Get-Date).ToString("s");manual_handoff=$true;external_network=$false;browser=$false;clipboard=$false;worker_apply=$false}
WriteJson $manifestPath $m
Write-Host ("OK publish_prompt=True id="+$id+" active="+$active)
