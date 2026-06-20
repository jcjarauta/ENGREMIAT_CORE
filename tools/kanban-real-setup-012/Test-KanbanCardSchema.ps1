$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$base='data/kanban-real-setup-012'
$reports='reports/kanban-real-setup-012'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$schema=Get-Content "$base/kanban-card-schema.json" -Raw | ConvertFrom-Json
$sample=Get-Content "$base/sample-kanban-card.json" -Raw | ConvertFrom-Json
$guide=Get-Content "docs/KANBAN_MODEL_GUIDE.md" -Raw
$errors=@()
if($schema.required_fields.Count -lt 11){$errors+="schema_required_fields_missing"}
if($schema.states.Count -lt 8){$errors+="schema_states_missing"}
if($sample.objective -ne "ENGREMIAT_KANBAN_REAL_SETUP_012"){$errors+="sample_objective_invalid"}
if($sample.state -ne "PENDING"){$errors+="sample_state_invalid"}
if($guide -notmatch "Kanban es una superficie humana"){$errors+="guide_missing_core_phrase"}
if($guide -notmatch "BACKLOG"){$errors+="guide_missing_states"}
$ok=($errors.Count -eq 0)
$readiness=70
$decision="NO_GO_KANBAN_MODEL_REPAIR_REQUIRED"
$next="REPAIR_KANBAN_MODEL"
if($ok){$readiness=100;$decision="GO_KANBAN_MODEL_READY";$next="E03_GENERATE_BOARD_FROM_EVIDENCE"}
$report=[ordered]@{objective="ENGREMIAT_KANBAN_REAL_SETUP_012";stage="E02";schema="$base/kanban-card-schema.json";sample="$base/sample-kanban-card.json";guide="docs/KANBAN_MODEL_GUIDE.md";errors=$errors;validation_ok=$ok;readiness=$readiness;decision=$decision;next=$next}
J $report "$reports/e02-kanban-model-validation-report.json"
Write-Host ("RESULT objective=ENGREMIAT_KANBAN_REAL_SETUP_012 stage=E02 readiness="+$readiness+" decision="+$decision+" next="+$next) -ForegroundColor Green
