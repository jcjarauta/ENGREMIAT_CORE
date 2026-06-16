param([string]$NextPath="data/prompt-factory/out/next-step.json",[string]$OutPath="data/prompt-factory/out/prompt-context.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
function LoadJsonl([string]$p){$a=@();if(Test-Path -LiteralPath $p -PathType Leaf){foreach($l in Get-Content -LiteralPath $p -Encoding UTF8){if([string]::IsNullOrWhiteSpace($l)){continue};try{$a+=($l|ConvertFrom-Json)}catch{}}};return @($a)}
if(!(Test-Path -LiteralPath $NextPath -PathType Leaf)){throw "next-step no encontrado: $NextPath"}
$next=Get-Content -LiteralPath $NextPath -Raw -Encoding UTF8|ConvertFrom-Json
$dev=$null;if(Test-Path -LiteralPath "data/dev/context-snapshot.json" -PathType Leaf){try{$dev=Get-Content -LiteralPath "data/dev/context-snapshot.json" -Raw -Encoding UTF8|ConvertFrom-Json}catch{}}
$registry=LoadJsonl "data/registry/artifact-registry.jsonl";$events=LoadJsonl "ENGREMIAT_MEMORY/operative/events/events.jsonl";$lastOk=@($events|Where-Object{$_.status -eq "OK"}|Select-Object -Last 5);$lastIssue=@($events|Where-Object{$_.status -eq "ERR" -or $_.status -eq "NO_GO"}|Select-Object -Last 5)
$context=[ordered]@{schema="prompt-context.v1";objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E03";active_objective=$(if($dev -and $dev.objective_id){$dev.objective_id}else{"ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001"});active_stage=$(if($dev -and $dev.active_stage){$dev.active_stage}else{"E03"});active_step=$(if($dev -and $dev.active_step){$dev.active_step}else{"P03.1.2"});next_step=$next.selected;last_ok=@($lastOk);last_issue=@($lastIssue);artifacts=@($registry|Select-Object -Last 20);visual_memory=[ordered]@{dashboard="ENGREMIAT_MEMORY/dashboard/memory/index.html";memory_status_command=".\eng.ps1 memory-status";memory_sync_command=".\eng.ps1 memory-sync"};security=[ordered]@{external_network=$false;git_write=$false;commit=$false;push=$false;fetch=$false;merge=$false;browser=$false;clipboard=$false;apply_sensible=$false;human_gate_required_for_sensitive_actions=$true};next=[ordered]@{step_id="P03.2.1";action="Crear Build-PromptNext";target="tools/prompt-factory/Build-PromptNext.ps1"};generated_at=(Get-Date).ToString("s")}
WriteJson $OutPath $context
Write-Host ("OK build_prompt_context=True step="+$next.selected.step_id+" output="+$OutPath)
