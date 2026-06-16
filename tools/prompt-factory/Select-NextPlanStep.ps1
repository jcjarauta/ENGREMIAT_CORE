param([string]$PlanPath="data/prompt-factory/out/plan-normalized.json",[string]$OutPath="data/prompt-factory/out/next-step.json",[string[]]$CompletedSteps=@("P01.3.2"))
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
if(!(Test-Path -LiteralPath $PlanPath -PathType Leaf)){throw "Plan normalizado no encontrado: $PlanPath"}
$plan=Get-Content -LiteralPath $PlanPath -Raw -Encoding UTF8|ConvertFrom-Json
$done=@{};foreach($d in $CompletedSteps){if(-not [string]::IsNullOrWhiteSpace($d)){$done[$d]=$true}}
$candidate=$null;foreach($s in @($plan.steps)){if($s.status -ne "PENDING"){continue};$dep=[string]$s.dependency;if([string]::IsNullOrWhiteSpace($dep) -or $dep -eq "NONE" -or $done.ContainsKey($dep)){$candidate=$s;break}}
if($null -eq $candidate){$candidate=@($plan.steps|Where-Object{$_.status -eq "PENDING"}|Select-Object -First 1)}
if($null -eq $candidate){throw "No hay step PENDING seleccionable"}
$next=[ordered]@{schema="next-plan-step.v1";selected=$candidate;completed_steps=$CompletedSteps;plan=$PlanPath;selected_at=(Get-Date).ToString("s");decision="NEXT_STEP_SELECTED"}
WriteJson $OutPath $next
Write-Host ("OK select_next_plan_step=True step="+$candidate.step_id+" dependency="+$candidate.dependency+" output="+$OutPath)
