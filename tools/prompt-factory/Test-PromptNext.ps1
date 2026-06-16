param([string]$PromptPath="data/prompt-factory/out/PROMPT_NEXT.md",[string]$ContextPath="data/prompt-factory/out/prompt-context.json",[string]$ReportPath="reports/prompt-factory/e03-generador-prompt-next/prompt-next-smoke-report.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$checks=@();$score=0;function AddPromptCheck([string]$id,[bool]$ok,[int]$points,[string]$message){if($ok){$script:score+=$points};$script:checks+=[ordered]@{id=$id;ok=$ok;points=$points;message=$message}}
$promptExists=Test-Path -LiteralPath $PromptPath -PathType Leaf;$contextExists=Test-Path -LiteralPath $ContextPath -PathType Leaf;AddPromptCheck "prompt_exists" $promptExists 10 $PromptPath;AddPromptCheck "context_exists" $contextExists 10 $ContextPath
$txt="";if($promptExists){$txt=Get-Content -LiteralPath $PromptPath -Raw -Encoding UTF8}
$must=@("## ROL","## OBJETIVO ACTIVO","## DEPENDENCIA VALIDADA","## ARTEFACTO ESPERADO","## CONTEXTO REAL","## LÍMITES DE SEGURIDAD","## ARCHIVOS PERMITIDOS","## ARCHIVOS PROHIBIDOS","## VALIDACIÓN OBLIGATORIA","## FORMATO DE SALIDA WORKEROUTPUT","## CRITERIO GO / NO_GO","external_network=False","git_write=False","NO_GO","worker_id")
foreach($m in $must){AddPromptCheck ("contains_"+($m -replace "[^A-Za-z0-9]","_")) ($txt -match [regex]::Escape($m)) 5 $m}
$ctxOk=$false;if($contextExists){try{$ctx=Get-Content -LiteralPath $ContextPath -Raw -Encoding UTF8|ConvertFrom-Json;$ctxOk=($ctx.next_step.step_id -and $ctx.security.external_network -eq $false)}catch{}};AddPromptCheck "context_schema_ok" $ctxOk 10 $ContextPath
if($score -gt 100){$score=100};$ok=($score -ge 90);$rep=[ordered]@{objective_id="ENGREMIAT_CORE_MVP_PROMPT_FACTORY_001";stage_id="E03";repair="E03-PROMPTNEXT-JSON-QUOTE-REPAIR-001";block_id="B03.3";step_id="P03.3.2";status=$(if($ok){"OK"}else{"NO_GO"});validation_passed=$ok;score=$score;threshold=90;checks=$checks;prompt=$PromptPath;context=$ContextPath;external_network=$false;git=$false;next=$(if($ok){"E04_GENERADOR_PROMPT_REPAIR"}else{"REPAIR_PROMPT_FACTORY_E03"});checked_at=(Get-Date).ToString("s")}
WriteJson $ReportPath $rep
if(-not $ok){Write-Host ("ERR prompt_next=False score="+$score+" report="+$ReportPath);exit 1}
Write-Host ("OK prompt_next=True repair=E03-PROMPTNEXT-JSON-QUOTE-REPAIR-001 score="+$score+" report="+$ReportPath+" next=E04_GENERADOR_PROMPT_REPAIR")
