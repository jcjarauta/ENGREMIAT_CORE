$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function J($o,[string]$p){
  $d=Split-Path -Parent $p
  if($d){ New-Item -ItemType Directory -Force -Path $d | Out-Null }
  $o | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $p -Encoding UTF8
}

$objective='ENGREMIAT_FIRST_REAL_CLINE_PROPOSAL_TASK_009'
$base='data/first-cline-proposal-task-009'
$reports='reports/first-cline-proposal-task-009'
$docs='docs'
New-Item -ItemType Directory -Force -Path $reports | Out-Null

$errors=@()

if(-not(Test-Path "$base/first-cline-proposal-scope.json")){ $errors+='missing_scope' }
if(-not(Test-Path "$base/cline-proposal-policy.json")){ $errors+='missing_policy' }
if(-not(Test-Path "$base/cline-proposal-output-contract.json")){ $errors+='missing_output_contract' }
if(-not(Test-Path "$docs/CLINE_PROPOSAL_CONTRACT_GUIDE.md")){ $errors+='missing_guide' }

$scope=$null
$policy=$null
$out=$null
$guide=''

if(Test-Path "$base/first-cline-proposal-scope.json"){ $scope=Get-Content "$base/first-cline-proposal-scope.json" -Raw | ConvertFrom-Json }
if(Test-Path "$base/cline-proposal-policy.json"){ $policy=Get-Content "$base/cline-proposal-policy.json" -Raw | ConvertFrom-Json }
if(Test-Path "$base/cline-proposal-output-contract.json"){ $out=Get-Content "$base/cline-proposal-output-contract.json" -Raw | ConvertFrom-Json }
if(Test-Path "$docs/CLINE_PROPOSAL_CONTRACT_GUIDE.md"){ $guide=Get-Content "$docs/CLINE_PROPOSAL_CONTRACT_GUIDE.md" -Raw }

if($scope){
  if(-not $scope.forbidden_actions){ $errors+='scope_forbidden_actions_missing' }
  if(($scope.forbidden_actions -notcontains 'apply') -or ($scope.forbidden_actions -notcontains 'git write')){ $errors+='scope_forbidden_actions_incomplete' }
}
if($policy){
  if($policy.task_creation -ne $true){ $errors+='policy_task_creation_false' }
  if($policy.prompt_sent -ne $false){ $errors+='policy_prompt_sent_not_false' }
  if($policy.auto_apply -ne $false){ $errors+='policy_auto_apply_not_false' }
  if($policy.git_write -ne $false){ $errors+='policy_git_write_not_false' }
  if($policy.remote_execution -ne $false){ $errors+='policy_remote_execution_not_false' }
}
if($out){
  if(-not $out.required_fields){ $errors+='output_contract_required_fields_missing' }
  if(($out.required_fields.Count -lt 5)){ $errors+='output_contract_too_short' }
  if($out.no_apply -ne $true){ $errors+='output_contract_no_apply_not_true' }
  if($out.no_git_write -ne $true){ $errors+='output_contract_no_git_write_not_true' }
}
if($guide){
  if($guide -notmatch 'auto_apply = false'){ $errors+='guide_missing_auto_apply_rule' }
  if($guide -notmatch 'git_write = false'){ $errors+='guide_missing_git_write_rule' }
  if($guide -notmatch 'parseable'){ $errors+='guide_missing_parseable_rule' }
}

$ok=($errors.Count -eq 0)
$readiness=70
$decision='NO_GO_REPAIR'
$next='REPAIR_OR_COMPLETE_E01_CONTRACT'

if($ok){
  $readiness=100
  $decision='GO_E01_CONTRACT_READY'
  $next='E02_SELECTION_OF_CANDIDATE_CARD'
}

$report=[ordered]@{
  objective=$objective
  stage='E01'
  readiness=$readiness
  decision=$decision
  next=$next
  validation_ok=$ok
  errors=$errors
  scope_file="$base/first-cline-proposal-scope.json"
  policy_file="$base/cline-proposal-policy.json"
  output_contract_file="$base/cline-proposal-output-contract.json"
  guide_file="$docs/CLINE_PROPOSAL_CONTRACT_GUIDE.md"
  task_creation=$true
  prompt_sent=$false
  auto_apply=$false
  git_write=$false
  remote_execution=$false
  timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')
}
J $report "$reports/e01-contract-validation-report.json"

if(-not $ok){
  throw "E01 contract validation failed: $($errors -join ', ')"
}

Write-Host ("OK objective="+$objective+" stage=E01 readiness="+$readiness+" decision="+$decision+" next="+$next) -ForegroundColor Green
