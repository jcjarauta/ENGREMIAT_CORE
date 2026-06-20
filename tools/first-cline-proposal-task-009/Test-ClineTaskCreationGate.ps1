$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function J($o,[string]$p){
  $d=Split-Path -Parent $p
  if($d){ New-Item -ItemType Directory -Force -Path $d | Out-Null }
  $o | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $p -Encoding UTF8
}

$objective='ENGREMIAT_FIRST_REAL_CLINE_PROPOSAL_TASK_009'
$base='data/first-cline-proposal-task-009'
$docs='docs'
$reports='reports/first-cline-proposal-task-009'
New-Item -ItemType Directory -Force -Path $reports | Out-Null

$errors=@()

$gatePath="$base/cline-task-creation-gate.json"
$gateGuidePath="$docs/CLINE_TASK_CREATION_GATE_GUIDE.md"
$candidatePath="$base/cline-proposal-task-candidate.json"
$promptPreviewPath="$base/cline-proposal-prompt-preview.md"
$e02ReportPath="$reports/e02-task-candidate-report.json"
$e01ReportPath="$reports/e01-contract-validation-report.json"

if(-not(Test-Path $gatePath)){ $errors+='missing_gate' }
if(-not(Test-Path $gateGuidePath)){ $errors+='missing_gate_guide' }
if(-not(Test-Path $candidatePath)){ $errors+='missing_candidate' }
if(-not(Test-Path $promptPreviewPath)){ $errors+='missing_prompt_preview' }
if(-not(Test-Path $e02ReportPath)){ $errors+='missing_e02_report' }
if(-not(Test-Path $e01ReportPath)){ $errors+='missing_e01_report' }

$gate = $null
$candidate = $null
$preview = ''
if(Test-Path $gatePath){ $gate = Get-Content $gatePath -Raw | ConvertFrom-Json }
if(Test-Path $candidatePath){ $candidate = Get-Content $candidatePath -Raw | ConvertFrom-Json }
if(Test-Path $promptPreviewPath){ $preview = Get-Content $promptPreviewPath -Raw }

if($gate){
  if($gate.decision -ne 'DEFER'){ $errors+='gate_decision_not_defer' }
  if($gate.allow_creation -ne $false){ $errors+='gate_allow_creation_not_false' }
  if($gate.task_creation -ne $false){ $errors+='gate_task_creation_not_false' }
  if($gate.prompt_sent -ne $false){ $errors+='gate_prompt_sent_not_false' }
  if($gate.auto_apply -ne $false){ $errors+='gate_auto_apply_not_false' }
  if($gate.git_write -ne $false){ $errors+='gate_git_write_not_false' }
  if($gate.remote_execution -ne $false){ $errors+='gate_remote_execution_not_false' }
  if($gate.authorization_phrase -notmatch 'AUTORIZO_CLINE_TASK_CREATION_009'){ $errors+='gate_phrase_missing' }
}

if($candidate){
  if(-not $candidate.required_limits){ $errors+='candidate_limits_missing' }
  if($candidate.required_limits.no_apply -ne $true){ $errors+='candidate_no_apply_not_true' }
  if($candidate.required_limits.no_git_write -ne $true){ $errors+='candidate_no_git_write_not_true' }
  if($candidate.required_limits.no_remote_execution -ne $true){ $errors+='candidate_no_remote_execution_not_true' }
}

if($preview){
  if($preview -notmatch 'proposal-only'){ $errors+='preview_missing_proposal_only' }
  if($preview -notmatch 'no apply'){ $errors+='preview_missing_no_apply' }
  if($preview -notmatch 'no git write'){ $errors+='preview_missing_no_git_write' }
}

$ok=($errors.Count -eq 0)
$readiness=70
$decision='NO_GO_REPAIR'
$next='REPAIR_OR_COMPLETE_E03_GATE'

if($ok){
  $readiness=100
  $decision='GO_E03_GATE_READY'
  $next='E04_CREACION_CONTROLADA_DE_TAREA_REAL_NO_APPLY'
}

$report=[ordered]@{
  objective=$objective
  stage='E03'
  readiness=$readiness
  decision=$decision
  next=$next
  gate_file=$gatePath
  gate_guide_file=$gateGuidePath
  candidate_file=$candidatePath
  prompt_preview_file=$promptPreviewPath
  validation_ok=$ok
  errors=$errors
  allow_creation=if($gate){$gate.allow_creation}else{$false}
  task_creation=if($gate){$gate.task_creation}else{$false}
  prompt_sent=if($gate){$gate.prompt_sent}else{$false}
  auto_apply=if($gate){$gate.auto_apply}else{$false}
  git_write=if($gate){$gate.git_write}else{$false}
  remote_execution=if($gate){$gate.remote_execution}else{$false}
  timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')
}
J $report "$reports/e03-task-creation-gate-report.json"

if(-not $ok){
  throw ("E03 gate validation failed: " + ($errors -join ', '))
}

$requestPreview = [ordered]@{
  objective = $objective
  stage = 'E03'
  request_id = 'CLINE-TASK-CREATION-REQUEST-PREVIEW-009-E03'
  candidate_file = $candidatePath
  gate_file = $gatePath
  decision = 'DEFER'
  expected_action = 'No crear la tarea real hasta approval explícito'
  limits = [ordered]@{
    proposal_only = $true
    no_apply = $true
    no_git_write = $true
    no_remote_execution = $true
    no_auto_apply = $true
  }
  timestamp_utc = (Get-Date).ToUniversalTime().ToString('o')
}
J $requestPreview "$base/cline-task-creation-request-preview.json"

Write-Host ("OK objective="+$objective+" stage=E03 readiness="+$readiness+" decision="+$decision+" next="+$next+" gate="+$gate.decision) -ForegroundColor Green
