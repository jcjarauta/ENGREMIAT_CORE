$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function ReadJsonFile([string]$Path){if(!(Test-Path -LiteralPath $Path -PathType Leaf)){return $null};return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}
try{
$cmd=[string]$args[0];if([string]::IsNullOrWhiteSpace($cmd)){$cmd="plan-status"}
$data="data/plan-to-worker";$report="reports/plan-to-worker/e06-command-hub/plan-command-last.json";EnsureDir "reports/plan-to-worker/e06-command-hub"
if($cmd -eq "plan-status"){$sel=ReadJsonFile "$data/selected-step.json";$dec=ReadJsonFile "$data/worker-decision.json";$ctx=ReadJsonFile "$data/worker-context.json";Write-Host ("OK plan-status objective=ENGREMIAT_PLAN_TO_WORKER_APP_001 selected="+$sel.step_id+" decision="+$dec.decision+" context="+($null -ne $ctx));exit 0}
if($cmd -eq "plan-import"){Write-Host "OK plan-import available=True use=tools/plan-to-worker/Import-PlanTable.ps1";exit 0}
if($cmd -eq "plan-next"){$sel=ReadJsonFile "$data/selected-step.json";Write-Host ("OK plan-next selected="+$sel.step_id+" title="+$sel.title);exit 0}
if($cmd -eq "plan-prompt"){if(Test-Path -LiteralPath "prompts/outbox/WORKER_PROMPT.md" -PathType Leaf){Write-Host "OK plan-prompt path=prompts/outbox/WORKER_PROMPT.md"}else{Write-Host "NO_GO plan-prompt missing=prompts/outbox/WORKER_PROMPT.md"};exit 0}
if($cmd -eq "plan-open"){if(Test-Path -LiteralPath "dashboard/plan-to-worker/index.html" -PathType Leaf){Start-Process "dashboard/plan-to-worker/index.html";Write-Host "OK plan-open dashboard=dashboard/plan-to-worker/index.html"}else{Write-Host "NO_GO plan-open missing_dashboard=True"};exit 0}
if($cmd -eq "plan-inbox"){EnsureDir "prompts/inbox";$items=@(Get-ChildItem -LiteralPath "prompts/inbox" -File -ErrorAction SilentlyContinue);Write-Host ("OK plan-inbox files="+$items.Count);exit 0}
throw ("Comando plan-to-worker no reconocido: "+$cmd)
}catch{Write-Host ("ERR plan-command message="+$_.Exception.Message) -ForegroundColor Red;throw}
