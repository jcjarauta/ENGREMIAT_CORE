param([string]$CardId="CARD-001",[ValidateSet("mock","ollama")][string]$Transport="mock",[switch]$AuthorizeRealWorker)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
function EnsureDir($p){if(Test-Path -LiteralPath $p){if(-not(Test-Path -LiteralPath $p -PathType Container)){throw "PATH_EXISTS_BUT_IS_NOT_DIRECTORY_$p"}}else{New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function ReadProp($txt,$key,$def=""){if($txt -match "(?m)^\s*$([regex]::Escape($key)):\s*(.+?)\s*$"){return (($matches[1] -replace '^"|"$','').Trim())};return $def}
$cardsDir=Join-Path $root "obsidian/ENGREMIAT_OBSIDIAN_KANBAN_LAB/12_MARKDOWN_KANBAN_TEST/cards"
$base=Join-Path $root "data/local-kanban-worker-loop-001"
$jobs=Join-Path $base "jobs"
$responses=Join-Path $base "responses"
$evidence=Join-Path $base "evidence"
foreach($d in @($base,$jobs,$responses,$evidence)){EnsureDir $d}
$cardPath=Join-Path $cardsDir ($CardId+".md")
if(-not(Test-Path -LiteralPath $cardPath -PathType Leaf)){throw "CARD_NOT_FOUND_$cardPath"}
$txt=Get-Content -LiteralPath $cardPath -Raw -Encoding UTF8
$id=ReadProp $txt "id" $CardId
$title=ReadProp $txt "title" $id
$source=ReadProp $txt "source_need" ""
$column=ReadProp $txt "recommended_column" (ReadProp $txt "status" "BACKLOG")
$priority=ReadProp $txt "priority" "MEDIUM"
$decision=ReadProp $txt "kanban_decision" "PENDING"
$reviewed=ReadProp $txt "human_reviewed" "false"
if($Transport -ne "mock" -and -not $AuthorizeRealWorker){throw "REAL_WORKER_TRANSPORT_REQUIRES_EXPLICIT_AUTHORIZATION transport=$Transport"}
$tag=if($Transport -eq "ollama"){"OLLAMA"}else{"MOCK"}
$jobId="JOB-"+$id+"-"+$tag+"-"+(Get-Date -Format "yyyyMMdd-HHmmss")
$jobPath=Join-Path $jobs ($jobId+".json")
$promptPath=Join-Path $jobs ($jobId+".prompt.txt")
$responsePath=Join-Path $responses ($jobId+".worker-response.md")
$stdoutPath=Join-Path $responses ($jobId+".stdout.txt")
$stderrPath=Join-Path $responses ($jobId+".stderr.txt")
$promptLines=@("Eres un worker local de ENGREMIAT. Responde en español. No ejecutes comandos. No escribas archivos. No uses git. No uses red.","Devuelve SOLO una propuesta de trabajo y evidencia esperada para la tarjeta indicada.","Respeta exactamente los marcadores WORKER_RESPONSE_BEGIN y WORKER_RESPONSE_END.","card_id: "+$id,"title: "+$title,"source_need: "+$source,"column: "+$column,"priority: "+$priority,"decision: "+$decision,"human_reviewed: "+$reviewed,"FORMATO OBLIGATORIO:","WORKER_RESPONSE_BEGIN","card_id: "+$id,"status: PROPOSAL_ONLY","summary:","proposal_steps:","expected_files:","expected_evidence:","risks:","human_validation_needed: true","next_recommended_action:","WORKER_RESPONSE_END")
$job=[ordered]@{job_id=$jobId;card_id=$id;title=$title;source_need=$source;column=$column;priority=$priority;decision=$decision;human_reviewed=$reviewed;transport=$Transport;authorized_real_worker=[bool]$AuthorizeRealWorker;created_at=(Get-Date).ToString("s")}
$job|ConvertTo-Json -Depth 20|Set-Content -Path $jobPath -Encoding UTF8
Set-Content -Path $promptPath -Encoding UTF8 -Value $promptLines
if($Transport -eq "mock"){
  $resp=@("WORKER_RESPONSE_BEGIN","card_id: "+$id,"status: PROPOSAL_ONLY","summary: Mock worker valida transporte automatico para "+$id+".","proposal_steps:","1. Leer tarjeta desde Obsidian Markdown/YAML.","2. Crear job local.","3. Capturar response.","4. Generar evidencia.","expected_files:","- data/local-kanban-worker-loop-001/jobs/*.json","- data/local-kanban-worker-loop-001/responses/*.worker-response.md","- data/local-kanban-worker-loop-001/evidence/*.evidence.md","expected_evidence:","- job creado","- response capturada","- evidencia generada","risks:","- mock no sustituye worker real","human_validation_needed: true","next_recommended_action: probar transporte ollama con gate humano.","WORKER_RESPONSE_END")
  Set-Content -Path $responsePath -Encoding UTF8 -Value $resp
  $status="PROPOSAL_ONLY"
}else{
  if(-not(Get-Command ollama -ErrorAction SilentlyContinue)){throw "OLLAMA_NOT_FOUND"}
  $model="qwen3:14b"
  $cmd='chcp 65001>nul && ollama run '+$model+' < "'+$promptPath+'" > "'+$stdoutPath+'" 2> "'+$stderrPath+'"'
  $p=Start-Process -FilePath "cmd.exe" -ArgumentList @("/d","/s","/c",$cmd) -WindowStyle Hidden -PassThru
  $timeoutSec=360
  $sw=[Diagnostics.Stopwatch]::StartNew()
  while(-not $p.HasExited -and $sw.Elapsed.TotalSeconds -lt $timeoutSec){Start-Sleep -Milliseconds 500}
  if(-not $p.HasExited){try{$p.Kill()}catch{};throw "OLLAMA_WORKER_TIMEOUT_360_SECONDS"}
  $stdout=if(Test-Path -LiteralPath $stdoutPath){Get-Content -LiteralPath $stdoutPath -Raw -Encoding UTF8}else{""}
  $stderr=if(Test-Path -LiteralPath $stderrPath){Get-Content -LiteralPath $stderrPath -Raw -Encoding UTF8}else{""}
  if($p.ExitCode -ne 0){throw ("OLLAMA_EXITCODE_"+$p.ExitCode+" STDERR="+$stderr)}
  if($stdout -notmatch "WORKER_RESPONSE_BEGIN" -or $stdout -notmatch "WORKER_RESPONSE_END"){
    $wrapped=@("WORKER_RESPONSE_BEGIN","card_id: "+$id,"status: PROPOSAL_ONLY_WRAPPED_RAW_OLLAMA_RESPONSE","summary: Ollama respondio sin marcadores completos; Engremiat conserva la respuesta como evidencia controlada.","proposal_steps: Revisar RAW_OLLAMA_RESPONSE abajo.","expected_files: none","expected_evidence: respuesta local capturada","risks: formato no estricto del modelo local","human_validation_needed: true","next_recommended_action: reforzar prompt o parser antes de automatizar","RAW_OLLAMA_RESPONSE_BEGIN",$stdout,"RAW_OLLAMA_RESPONSE_END","WORKER_RESPONSE_END")
    Set-Content -Path $responsePath -Encoding UTF8 -Value $wrapped
    $status="PROPOSAL_ONLY_WRAPPED_RAW_OLLAMA_RESPONSE"
  }else{
    Set-Content -Path $responsePath -Encoding UTF8 -Value $stdout
    $status=if($stdout -match "(?m)^status:\s*(.+)$"){$matches[1].Trim()}else{"PROPOSAL_ONLY"}
  }
}
$finalRaw=Get-Content -LiteralPath $responsePath -Raw -Encoding UTF8
$evidencePath=Join-Path $evidence ($jobId+".evidence.md")
$ev=@("# Worker loop evidence","","- job_id: "+$jobId,"- card_id: "+$id,"- transport: "+$Transport,"- authorized_real_worker: "+[string][bool]$AuthorizeRealWorker,"- response: "+$responsePath,"- job: "+$jobPath,"","## Decision","","LOCAL_KANBAN_TO_WORKER_AUTOMATED_LOOP_PASS","","## Response","","````text",$finalRaw,"````")
Set-Content -Path $evidencePath -Encoding UTF8 -Value $ev
Write-Host ("OK worker_loop card_id="+$id+" transport="+$Transport+" status="+$status+" job="+$jobPath+" response="+$responsePath+" evidence="+$evidencePath) -ForegroundColor Green
