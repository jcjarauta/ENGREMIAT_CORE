param([switch]$Authorized)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not $Authorized){throw "AUTHORIZATION_REQUIRED"}
$root=(Get-Location).Path
function EnsureDir($p){if(Test-Path -LiteralPath $p){if(-not(Test-Path -LiteralPath $p -PathType Container)){throw "PATH_EXISTS_BUT_IS_NOT_DIRECTORY_$p"}}else{New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function ReadProp($txt,$key,$def=""){if($txt -match "(?m)^\s*$([regex]::Escape($key)):\s*(.+?)\s*$"){return (($matches[1] -replace '^"|"$','').Trim())};return $def}
$cardId="CARD-001"
$cardsDir=Join-Path $root "obsidian/ENGREMIAT_OBSIDIAN_KANBAN_LAB/12_MARKDOWN_KANBAN_TEST/cards"
$base=Join-Path $root "data/local-kanban-worker-loop-001"
$jobs=Join-Path $base "jobs"
$responses=Join-Path $base "responses"
$evidence=Join-Path $base "evidence"
foreach($d in @($base,$jobs,$responses,$evidence)){EnsureDir $d}
$cardPath=Join-Path $cardsDir ($cardId+".md")
if(-not(Test-Path -LiteralPath $cardPath -PathType Leaf)){throw "CARD_NOT_FOUND_$cardPath"}
$txt=Get-Content -LiteralPath $cardPath -Raw -Encoding UTF8
$id=ReadProp $txt "id" $cardId
$title=ReadProp $txt "title" $id
$source=ReadProp $txt "source_need" ""
$column=ReadProp $txt "recommended_column" (ReadProp $txt "status" "BACKLOG")
$priority=ReadProp $txt "priority" "MEDIUM"
$decision=ReadProp $txt "kanban_decision" "PENDING"
$reviewed=ReadProp $txt "human_reviewed" "false"
$jobId="JOB-"+$id+"-OLLAMA-"+(Get-Date -Format "yyyyMMdd-HHmmss")
$promptLines=@()
$promptLines+="Eres un worker local de ENGREMIAT. Responde en español. No ejecutes comandos. No escribas archivos. No uses git. No uses red."
$promptLines+="Devuelve SOLO una propuesta de trabajo y evidencia esperada para la tarjeta indicada."
$promptLines+="Respeta exactamente los marcadores WORKER_RESPONSE_BEGIN y WORKER_RESPONSE_END."
$promptLines+="card_id: "+$id
$promptLines+="title: "+$title
$promptLines+="source_need: "+$source
$promptLines+="column: "+$column
$promptLines+="priority: "+$priority
$promptLines+="decision: "+$decision
$promptLines+="human_reviewed: "+$reviewed
$promptLines+="FORMATO OBLIGATORIO:"
$promptLines+="WORKER_RESPONSE_BEGIN"
$promptLines+="card_id: "+$id
$promptLines+="status: PROPOSAL_ONLY"
$promptLines+="summary:"
$promptLines+="proposal_steps:"
$promptLines+="expected_files:"
$promptLines+="expected_evidence:"
$promptLines+="risks:"
$promptLines+="human_validation_needed: true"
$promptLines+="next_recommended_action:"
$promptLines+="WORKER_RESPONSE_END"
$prompt=$promptLines -join "`n"
$job=[ordered]@{job_id=$jobId;card_id=$id;title=$title;source_need=$source;column=$column;priority=$priority;decision=$decision;human_reviewed=$reviewed;transport="ollama";authorized_real_worker=$true;prompt=$prompt;created_at=(Get-Date).ToString("s")}
$jobPath=Join-Path $jobs ($jobId+".json")
$promptPath=Join-Path $jobs ($jobId+".prompt.txt")
$responsePath=Join-Path $responses ($jobId+".worker-response.md")
$job|ConvertTo-Json -Depth 20|Set-Content -Path $jobPath -Encoding UTF8
Set-Content -Path $promptPath -Encoding UTF8 -Value $promptLines
$raw=& ollama run qwen3:14b $prompt 2>&1
$rawText=($raw -join "`n")
if($rawText -notmatch "WORKER_RESPONSE_BEGIN" -or $rawText -notmatch "WORKER_RESPONSE_END"){
  $wrapped=@("WORKER_RESPONSE_BEGIN","card_id: "+$id,"status: PROPOSAL_ONLY_WRAPPED_RAW_OLLAMA_RESPONSE","summary: Ollama respondio sin marcadores completos; Engremiat conserva la respuesta como evidencia controlada.","proposal_steps: Ver RAW_OLLAMA_RESPONSE abajo.","expected_files: none","expected_evidence: respuesta local capturada","risks: formato no estricto del modelo local","human_validation_needed: true","next_recommended_action: reforzar prompt o parser antes de automatizar","RAW_OLLAMA_RESPONSE_BEGIN",$rawText,"RAW_OLLAMA_RESPONSE_END","WORKER_RESPONSE_END")
  Set-Content -Path $responsePath -Encoding UTF8 -Value $wrapped
}else{
  Set-Content -Path $responsePath -Encoding UTF8 -Value $rawText
}
$finalRaw=Get-Content -LiteralPath $responsePath -Raw -Encoding UTF8
$evidencePath=Join-Path $evidence ($jobId+".evidence.md")
$ev=@("# E04 · Ollama worker real proposal-only evidence","","- job_id: "+$jobId,"- card_id: "+$id,"- transport: ollama","- authorized_real_worker: true","- response: "+$responsePath,"- job: "+$jobPath,"","## Decision","","OLLAMA_WORKER_REAL_PROPOSAL_ONLY_RESPONSE_CAPTURED","","## Response","","````text",$finalRaw,"````")
Set-Content -Path $evidencePath -Encoding UTF8 -Value $ev
Write-Host ("OK ollama_worker card_id="+$id+" job="+$jobPath+" response="+$responsePath+" evidence="+$evidencePath) -ForegroundColor Green
