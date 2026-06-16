$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function ReadJsonFile([string]$Path){if(!(Test-Path -LiteralPath $Path -PathType Leaf)){throw ("Falta JSON: "+$Path)};return Get-Content -LiteralPath $Path -Raw -Encoding UTF8|ConvertFrom-Json}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
$SelectedPath=[string]$args[0];$ValidationPath=[string]$args[1];$OutPath=[string]$args[2];if([string]::IsNullOrWhiteSpace($SelectedPath)){$SelectedPath="data/plan-to-worker/selected-step.json"};if([string]::IsNullOrWhiteSpace($ValidationPath)){$ValidationPath="data/plan-to-worker/plan-validation-report.json"};if([string]::IsNullOrWhiteSpace($OutPath)){$OutPath="data/plan-to-worker/worker-decision.json"}
$selected=ReadJsonFile $SelectedPath
$validation=$null;if(Test-Path -LiteralPath $ValidationPath -PathType Leaf){$validation=ReadJsonFile $ValidationPath}
$decision="NEXT";$prompt_type="PROMPT_NEXT";$reason="READY_STEP_SELECTED";$evidence=@($SelectedPath)
$validationDecision="UNKNOWN";if($null -ne $validation){$validationDecision=[string]$validation.decision;$evidence+=$ValidationPath;if($validationDecision -ne "GO"){$decision="REPAIR";$prompt_type="PROMPT_REPAIR";$reason="PLAN_VALIDATION_NOT_GO"}}
if($selected.selected -ne $true -and $decision -ne "REPAIR"){$decision="REPAIR";$prompt_type="PROMPT_REPAIR";$reason="NO_READY_SELECTED_STEP"}
$out=[ordered]@{objective_id=$selected.objective_id;stage="E04";decision=$decision;prompt_type=$prompt_type;reason=$reason;selected_step_id=$selected.step_id;selected_title=$selected.title;selected_artifact=$selected.artifact;selected_status=$selected.status;dependency_state=$selected.dependency_state;validation_decision=$validationDecision;evidence=$evidence;external_network=$false;git_write=$false;worker_real_execution=$false;next=($(if($decision -eq "NEXT"){"E05_GENERADOR_DE_PAQUETES_WORKER"}else{"REPAIR_PLAN_TO_WORKER_E04"}));created_at=(Get-Date).ToString("s")}
WriteJsonFile $OutPath $out
Write-Host ("OK repair_or_next=True decision="+$decision+" prompt_type="+$prompt_type+" reason="+$reason+" out="+$OutPath)
}catch{Write-Host ("ERR repair_or_next=False message="+$_.Exception.Message) -ForegroundColor Red;throw}
