$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$base="data/kanban-human-control"
$reportPath="reports/kanban-human-control/e01-kanban-card-schema-validation-report.json"
New-Item -ItemType Directory -Force -Path (Split-Path $reportPath -Parent) | Out-Null
$schemaPath=Join-Path $base "kanban-card-schema.json"
$samplePath=Join-Path $base "sample-kanban-card.json"
$guidePath="docs/KANBAN_CARD_MODEL_GUIDE.md"
$schema=Get-Content $schemaPath -Raw | ConvertFrom-Json
$sample=Get-Content $samplePath -Raw | ConvertFrom-Json
$required=@("card_id","objective","stage","block","step","title","description","status","risk","gate","worker","evidence","next_action","safety")
$missing=@()
foreach($f in $required){ if(-not ($sample.PSObject.Properties.Name -contains $f)){ $missing += $f } }
$flags=@("kanban_write","cline_task_created","worker_real_execution","auto_apply","git_write","remote_inference")
$badFlags=@()
foreach($f in $flags){ if($sample.safety.$f -ne $false){ $badFlags += $f } }
$ok=($missing.Count -eq 0 -and $badFlags.Count -eq 0 -and (Test-Path $guidePath) -and ($schema.required_fields.Count -ge 1))
$report=[ordered]@{objective="ENGREMIAT_KANBAN_HUMAN_CONTROL_SURFACE_007";stage="E01";blocks="B01.1-B01.3";steps=6;schema_exists=(Test-Path $schemaPath);sample_exists=(Test-Path $samplePath);guide_exists=(Test-Path $guidePath);required_fields_checked=$required.Count;missing_fields=$missing;bad_safety_flags=$badFlags;kanban_write=$false;cline_task_created=$false;worker_real_execution=$false;auto_apply=$false;git_write=$false;remote_inference=$false;readiness=($(if($ok){100}else{60}));decision=($(if($ok){"GO_E01_KANBAN_CARD_MODEL_VALIDATED"}else{"NO_GO_E01_REPAIR_REQUIRED"}));next=($(if($ok){"E02_GENERADOR_TABLERO_DESDE_EVIDENCIA"}else{"REPAIR_E01_CARD_MODEL"}))}
($report | ConvertTo-Json -Depth 50) | Set-Content -Path $reportPath -Encoding UTF8
if(-not $ok){ throw "E01 validation failed" }
Write-Host ("OK objective="+$report.objective+" stage="+$report.stage+" readiness="+$report.readiness+" decision="+$report.decision+" report="+$reportPath+" next="+$report.next) -ForegroundColor Green
