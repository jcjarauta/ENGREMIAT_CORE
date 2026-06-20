$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function Fail($m){W "ERR $m" Red;throw $m}
try{
$package="ENGREMIAT_REAL_INTAKE_IMPORTER_001"
$stage="RUN_IMPORT_REAL_HUMAN_INTAKE_JSON"
$root=(Get-Location).Path
$data=Join-Path $root "data\real-intake-importer"
$reports=Join-Path $root "reports\real-intake-importer"
$dash=Join-Path $root "dashboard\real-intake-importer"
New-Item -ItemType Directory -Force -Path $data,$reports,$dash|Out-Null
W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
W "Pega la ruta del JSON exportado desde la UI de intake real:" Yellow
$src=Read-Host "INTAKE_JSON_PATH"
if([string]::IsNullOrWhiteSpace($src)){Fail "empty_intake_path"}
$src=$src.Trim().Trim("""")
if(!(Test-Path -LiteralPath $src)){Fail "intake_file_not_found: $src"}
$raw=Get-Content -LiteralPath $src -Raw -Encoding UTF8
$intake=$raw|ConvertFrom-Json
if($intake.package_id -ne "ENGREMIAT_REAL_HUMAN_INTAKE_UI_001"){Fail "unexpected_intake_package_id"}
if($intake.schema -ne "real-human-intake.v1"){Fail "unexpected_intake_schema"}
if([string]::IsNullOrWhiteSpace($intake.project_name)){Fail "missing_project_name"}
if([string]::IsNullOrWhiteSpace($intake.human_need)){Fail "missing_human_need"}
if([string]::IsNullOrWhiteSpace($intake.desired_result)){Fail "missing_desired_result"}
if([string]::IsNullOrWhiteSpace($intake.success_criteria)){Fail "missing_success_criteria"}
if($intake.safety.local_only -ne $true){Fail "unsafe_local_only_not_true"}
if($intake.safety.manual_export_only -ne $true){Fail "unsafe_manual_export_only_not_true"}
if($intake.safety.backend -ne $false){Fail "unsafe_backend_true"}
if($intake.safety.network -ne $false){Fail "unsafe_network_true"}
if($intake.safety.worker_execution -ne $false){Fail "unsafe_worker_execution_true"}
if($intake.safety.git_write -ne $false){Fail "unsafe_git_write_true"}
if($intake.safety.execute_now -ne $false){Fail "unsafe_execute_now_true"}
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$acceptedPath=Join-Path $data ("real-human-intake.accepted."+ $stamp +".json")
$raw|Set-Content -LiteralPath $acceptedPath -Encoding UTF8
$canonicalPath=Join-Path $data "real-human-intake.accepted.latest.json"
$raw|Set-Content -LiteralPath $canonicalPath -Encoding UTF8
$roadmap=[ordered]@{package_id="ENGREMIAT_REAL_INTAKE_IMPORTER_001";stage=$stage;roadmap_id="real-intake-roadmap-preview."+ $stamp;status="PREVIEW_ONLY";source_intake=$acceptedPath;project_name=$intake.project_name;priority=$intake.priority;authorization_level=$intake.authorization_level;human_need=$intake.human_need;desired_result=$intake.desired_result;constraints=$intake.constraints;available_resources=$intake.available_resources;success_criteria=$intake.success_criteria;proposed_stages=@([ordered]@{stage_id="E01";name="Normalizar intake real";goal="Guardar el JSON exportado como intake aceptado y canónico.";output="real-human-intake.accepted.latest.json";risk="LOW";human_gate="PASS"},[ordered]@{stage_id="E02";name="Roadmap preview";goal="Convertir el intake en etapas revisables antes de worker.";output="real-intake-roadmap-preview.latest.json";risk="LOW";human_gate="REVIEW"},[ordered]@{stage_id="E03";name="Gate humano";goal="Aprobar, editar, rechazar o aplazar el roadmap.";output="real-roadmap-approval-gate.json";risk="LOW";human_gate="REQUIRED"},[ordered]@{stage_id="E04";name="Worker packet preview";goal="Preparar paquete para worker sin ejecución real.";output="real-worker-packet-preview.json";risk="MEDIUM";human_gate="REQUIRED"},[ordered]@{stage_id="E05";name="Dry-run controlado";goal="Simular la ejecución y mantener NO_GO sin autorización explícita.";output="controlled-dry-run-result.json";risk="MEDIUM";human_gate="REQUIRED"});safety=[ordered]@{local_only=$true;preview_only=$true;execute_now=$false;worker_execution=$false;network=$false;git_write=$false;external_ai=$false;manual_review_required=$true};decision="GO_ROADMAP_PREVIEW_ONLY";next="E02_BUILD_REAL_ROADMAP_REVIEW_DASHBOARD"}
$roadmapPath=Join-Path $data ("real-intake-roadmap-preview."+ $stamp +".json")
$roadmap|ConvertTo-Json -Depth 40|Set-Content -LiteralPath $roadmapPath -Encoding UTF8
$roadmapLatest=Join-Path $data "real-intake-roadmap-preview.latest.json"
$roadmap|ConvertTo-Json -Depth 40|Set-Content -LiteralPath $roadmapLatest -Encoding UTF8
$htmlPath=Join-Path $dash "real-intake-roadmap-preview.latest.html"
$safeName=[System.Net.WebUtility]::HtmlEncode([string]$intake.project_name)
$safeNeed=[System.Net.WebUtility]::HtmlEncode([string]$intake.human_need)
$safeResult=[System.Net.WebUtility]::HtmlEncode([string]$intake.desired_result)
$html=@("<!doctype html>","<html lang=""es""><head><meta charset=""utf-8""><meta name=""viewport"" content=""width=device-width,initial-scale=1""><title>ENGREMIAT Real Intake Importer</title><style>body{font-family:Segoe UI,Arial,sans-serif;margin:24px;background:#111827;color:#e5e7eb}.card{border:1px solid #374151;border-radius:14px;padding:16px;margin:12px 0;background:#1f2937}.ok{color:#22c55e}.warn{color:#facc15}.bad{color:#fb7185}.grid{display:grid;grid-template-columns:repeat(auto-fit,minmax(220px,1fr));gap:12px}.box{padding:14px;border-radius:12px;background:#0f172a;border:1px solid #334155}code{color:#93c5fd}</style></head><body>","<h1>ENGREMIAT · Real Intake Importer</h1>","<div class=""card""><b class=""ok"">IMPORT PASS · Roadmap preview creado</b><p><b>Proyecto:</b> $safeName</p></div>","<div class=""card""><h2>Necesidad</h2><p>$safeNeed</p><h2>Resultado deseado</h2><p>$safeResult</p></div>","<div class=""card""><h2>Roadmap propuesto</h2><div class=""grid""><div class=""box"">E01 · Normalizar intake real</div><div class=""box"">E02 · Roadmap preview</div><div class=""box"">E03 · Gate humano</div><div class=""box"">E04 · Worker packet preview</div><div class=""box"">E05 · Dry-run controlado</div></div></div>","<div class=""card""><h2>Seguridad</h2><p class=""warn"">PREVIEW_ONLY · execute_now=false · worker_execution=false · network=false · git_write=false</p></div>","<div class=""card""><h2>Artefactos</h2><p><code>$acceptedPath</code></p><p><code>$roadmapLatest</code></p></div>","</body></html>")
$html|Set-Content -LiteralPath $htmlPath -Encoding UTF8
$report=[ordered]@{package_id=$package;stage=$stage;status="PASS";source=$src;accepted=$acceptedPath;canonical=$canonicalPath;roadmap=$roadmapPath;roadmap_latest=$roadmapLatest;dashboard=$htmlPath;project_name=$intake.project_name;decision="GO_ROADMAP_PREVIEW_ONLY";execute_now=$false;worker_execution=$false;network=$false;git_write=$false;next="E02_BUILD_REAL_ROADMAP_REVIEW_DASHBOARD"}
$reportPath=Join-Path $reports ("real-intake-import-report."+ $stamp +".json")
$report|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $reportPath -Encoding UTF8
$latestReport=Join-Path $reports "real-intake-import-report.latest.json"
$report|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $latestReport -Encoding UTF8
Start-Process $htmlPath
W "OK package_id=$package stage=$stage status=PASS accepted=$acceptedPath roadmap=$roadmapLatest dashboard=$htmlPath report=$latestReport decision=GO_ROADMAP_PREVIEW_ONLY next=E02_BUILD_REAL_ROADMAP_REVIEW_DASHBOARD" Green
W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ERR package_id=ENGREMIAT_REAL_INTAKE_IMPORTER_001 status=FAIL message=$($_.Exception.Message)" Red;W "ENGREMIAT_PACKAGE_END package=ENGREMIAT_REAL_INTAKE_IMPORTER_001 status=FAIL" Cyan;throw}
