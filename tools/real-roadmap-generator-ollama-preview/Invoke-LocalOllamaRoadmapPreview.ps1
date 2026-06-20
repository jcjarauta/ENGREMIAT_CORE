$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function Fail($m){W "ERR $m" Red;throw $m}
try{
$package="ENGREMIAT_REAL_ROADMAP_GENERATOR_WITH_LOCAL_OLLAMA_PREVIEW_001"
$stage="RUN_LOCAL_OLLAMA_ROADMAP_PREVIEW"
$root=(Get-Location).Path
$data=Join-Path $root "data\real-roadmap-generator-ollama-preview"
$reports=Join-Path $root "reports\real-roadmap-generator-ollama-preview"
$dash=Join-Path $root "dashboard\real-roadmap-generator-ollama-preview"
New-Item -ItemType Directory -Force -Path $data,$reports,$dash|Out-Null
W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
$intakePath=Join-Path $root "data\real-intake-importer\real-human-intake.accepted.latest.json"
if(!(Test-Path -LiteralPath $intakePath)){Fail "missing_latest_accepted_real_intake"}
$intakeRaw=Get-Content -LiteralPath $intakePath -Raw -Encoding UTF8
$intake=$intakeRaw|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace($intake.project_name)){Fail "missing_project_name"}
if($intake.safety.local_only -ne $true){Fail "unsafe_intake_local_only_not_true"}
if($intake.safety.worker_execution -ne $false){Fail "unsafe_intake_worker_execution_true"}
if($intake.safety.execute_now -ne $false){Fail "unsafe_intake_execute_now_true"}
$endpoint="http://127.0.0.1:11434/api/generate"
$model="qwen3:14b"
try{$models=Invoke-RestMethod -Method Get -Uri "http://127.0.0.1:11434/api/tags" -TimeoutSec 10}catch{Fail "ollama_not_available_or_not_running"}
if(-not ($models.models | Where-Object { $_.name -eq $model -or $_.model -eq $model })){Fail "ollama_model_not_found_qwen3_14b"}
$prompt=@()
$prompt+="# ENGREMIAT LOCAL ROADMAP PREVIEW"
$prompt+=""
$prompt+="Convierte este intake humano en un roadmap preview revisable por humano."
$prompt+=""
$prompt+="REGLAS OBLIGATORIAS:"
$prompt+="- No ejecutes nada."
$prompt+="- No propongas auto-apply."
$prompt+="- No uses red externa."
$prompt+="- No escribas Git."
$prompt+="- No actives worker real."
$prompt+="- Mantén una frontera técnica por etapa."
$prompt+="- Devuelve una propuesta práctica, compacta y verificable."
$prompt+="- Usa secciones: RESUMEN, ETAPAS, RIESGOS, EVIDENCIAS, GATE_HUMANO, SIGUIENTE_PASO."
$prompt+=""
$prompt+="INTAKE_JSON:"
$prompt+=$intakeRaw
$promptText=($prompt -join "`n")
$body=[ordered]@{model=$model;prompt=$promptText;stream=$false;options=[ordered]@{temperature=0.2;num_ctx=8192}}|ConvertTo-Json -Depth 20
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$requestPath=Join-Path $data ("ollama-roadmap-request."+ $stamp +".json")
$body|Set-Content -LiteralPath $requestPath -Encoding UTF8
try{$resp=Invoke-RestMethod -Method Post -Uri $endpoint -Body $body -ContentType "application/json" -TimeoutSec 180}catch{Fail "ollama_generate_failed: $($_.Exception.Message)"}
if([string]::IsNullOrWhiteSpace([string]$resp.response)){Fail "ollama_empty_response"}
$text=[string]$resp.response
$preview=[ordered]@{package_id=$package;stage=$stage;preview_id="ollama-roadmap-preview."+ $stamp;status="PREVIEW_ONLY";source_intake=$intakePath;model=$model;project_name=$intake.project_name;raw_response=$text;safety=[ordered]@{local_only=$true;ollama_local_only=$true;external_ai=$false;network_external=$false;execute_now=$false;worker_execution=$false;git_write=$false;auto_apply=$false;manual_review_required=$true};decision="WAIT_HUMAN_REVIEW";next="E03_BUILD_OLLAMA_ROADMAP_REVIEW_DASHBOARD_AND_GATE"}
$previewPath=Join-Path $data ("ollama-roadmap-preview."+ $stamp +".json")
$preview|ConvertTo-Json -Depth 40|Set-Content -LiteralPath $previewPath -Encoding UTF8
$latestPreview=Join-Path $data "ollama-roadmap-preview.latest.json"
$preview|ConvertTo-Json -Depth 40|Set-Content -LiteralPath $latestPreview -Encoding UTF8
$safeName=[System.Net.WebUtility]::HtmlEncode([string]$intake.project_name)
$safeText=[System.Net.WebUtility]::HtmlEncode($text) -replace "`n","<br>"
$htmlPath=Join-Path $dash "ollama-roadmap-preview.latest.html"
$html=@("<!doctype html>","<html lang=""es""><head><meta charset=""utf-8""><meta name=""viewport"" content=""width=device-width,initial-scale=1""><title>ENGREMIAT · Ollama Roadmap Preview</title><style>body{font-family:Segoe UI,Arial,sans-serif;margin:24px;background:#111827;color:#e5e7eb}.card{border:1px solid #374151;border-radius:14px;padding:16px;margin:12px 0;background:#1f2937}.ok{color:#22c55e}.warn{color:#facc15}.bad{color:#fb7185}.content{white-space:normal;line-height:1.5;background:#0f172a;border:1px solid #334155;border-radius:12px;padding:14px}code{color:#93c5fd}</style></head><body>","<h1>ENGREMIAT · Ollama Roadmap Preview</h1>","<div class=""card""><b class=""ok"">RUN PASS · roadmap preview generado con Ollama local</b><p><b>Proyecto:</b> $safeName</p><p><b>Modelo:</b> $model</p></div>","<div class=""card""><h2>Respuesta del modelo</h2><div class=""content"">$safeText</div></div>","<div class=""card""><h2>Seguridad</h2><p class=""warn"">LOCAL_OLLAMA_ONLY · external_ai=false · execute_now=false · worker_execution=false · git_write=false · auto_apply=false</p></div>","<div class=""card""><h2>Artefactos</h2><p><code>$latestPreview</code></p><p><code>$requestPath</code></p></div>","</body></html>")
$html|Set-Content -LiteralPath $htmlPath -Encoding UTF8
$report=[ordered]@{package_id=$package;stage=$stage;status="PASS";intake=$intakePath;request=$requestPath;preview=$previewPath;preview_latest=$latestPreview;dashboard=$htmlPath;model=$model;decision="WAIT_HUMAN_REVIEW";local_only=$true;ollama_local_only=$true;external_ai=$false;execute_now=$false;worker_execution=$false;git_write=$false;auto_apply=$false;next="E03_BUILD_OLLAMA_ROADMAP_REVIEW_DASHBOARD_AND_GATE"}
$reportPath=Join-Path $reports ("ollama-roadmap-preview-run."+ $stamp +".json")
$report|ConvertTo-Json -Depth 40|Set-Content -LiteralPath $reportPath -Encoding UTF8
$latestReport=Join-Path $reports "ollama-roadmap-preview-run.latest.json"
$report|ConvertTo-Json -Depth 40|Set-Content -LiteralPath $latestReport -Encoding UTF8
Start-Process $htmlPath
W "OK package_id=$package stage=$stage status=PASS preview=$latestPreview dashboard=$htmlPath report=$latestReport model=$model decision=WAIT_HUMAN_REVIEW next=E03_BUILD_OLLAMA_ROADMAP_REVIEW_DASHBOARD_AND_GATE" Green
W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ERR package_id=ENGREMIAT_REAL_ROADMAP_GENERATOR_WITH_LOCAL_OLLAMA_PREVIEW_001 status=FAIL message=$($_.Exception.Message)" Red;W "ENGREMIAT_PACKAGE_END package=ENGREMIAT_REAL_ROADMAP_GENERATOR_WITH_LOCAL_OLLAMA_PREVIEW_001 status=FAIL" Cyan;throw}
