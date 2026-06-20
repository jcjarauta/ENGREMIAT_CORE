param(
  [Parameter(Mandatory=$true)]
  [string]$InputJson,
  [string]$Root='C:\ENGREMIAT_CORE'
)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){
  $Object | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $Path -Encoding UTF8
}
$payload = Get-Content -LiteralPath $InputJson -Raw -Encoding UTF8 | ConvertFrom-Json
$errors = @()
if([string]$payload.module_id -notmatch '^ENGREMIAT_[A-Z0-9_]+_[0-9]{3}$'){ $errors += 'invalid_module_id' }
if([string]$payload.decision -ne 'CREATE_CANDIDATE_JSON'){ $errors += 'decision_not_allowed' }
if($payload.gates.requires_core_change -eq $true){ $errors += 'requires_core_change_blocked' }
if($payload.gates.requires_real_write -eq $true){ $errors += 'requires_real_write_blocked' }
if($payload.gates.requires_external_api -eq $true){ $errors += 'requires_external_api_blocked' }
$nextRoot = Join-Path $Root 'data\_OFFICIAL_MODULES\_NEXT_MODULES'
$target = Join-Path $nextRoot ([string]$payload.module_id)
$resolvedNextRoot = [System.IO.Path]::GetFullPath($nextRoot)
$resolvedTarget = [System.IO.Path]::GetFullPath($target)
if(-not $resolvedTarget.StartsWith($resolvedNextRoot)){ $errors += 'target_outside_next_modules' }
if($errors.Count -gt 0){
  Write-Host ('ERR factory_dry_run validation_errors=' + ($errors -join ',')) -ForegroundColor Red
  exit 1
}
New-Item -ItemType Directory -Force -Path $target,(Join-Path $target 'contracts'),(Join-Path $target 'schemas'),(Join-Path $target 'evidence'),(Join-Path $target 'reports'),(Join-Path $target 'gates') | Out-Null
$module = [ordered]@{
  module_id = [string]$payload.module_id
  name = [string]$payload.name
  status = 'CANDIDATE'
  kind = [string]$payload.kind
  purpose = [string]$payload.purpose
  expected_output = [string]$payload.expected_output
  priority = [string]$payload.priority
  risk = [string]$payload.risk
  dependencies = $payload.dependencies
  source_task_packet_id = [string]$payload.source_task_packet_id
  generated_by = 'ENGREMIAT_JSON_MODULE_FACTORY_001'
  generated_at = (Get-Date).ToString('s')
  active = $false
  detachable = $true
  acoplable = $true
}
WJson (Join-Path $target 'module.json') $module
$contract = [ordered]@{
  module_id = [string]$payload.module_id
  contract_id = ([string]$payload.module_id + '.contract.v1')
  purpose = [string]$payload.purpose
  rules = @('No activo hasta gate humano','No core changes','No Git write','No red externa')
  gates = $payload.gates
}
WJson (Join-Path $target 'contracts\module-contract.json') $contract
$schema = [ordered]@{
  module_id = [string]$payload.module_id
  schema_id = ([string]$payload.module_id + '.schema.v1')
  type = 'candidate_module_skeleton'
  required = @('module.json','contracts/module-contract.json','schemas/module-schema.json','gates/module-gate.json')
}
WJson (Join-Path $target 'schemas\module-schema.json') $schema
$gate = [ordered]@{
  module_id = [string]$payload.module_id
  human_gate = 'REQUIRED'
  active = $false
  allowed_decisions = @('APPROVE_ACTIVATION_LATER','BACKLOG','REJECT')
  current_decision = 'BACKLOG'
}
WJson (Join-Path $target 'gates\module-gate.json') $gate
Set-Content -LiteralPath (Join-Path $target 'README.md') -Encoding UTF8 -Value ("# " + [string]$payload.module_id + "`n`nModulo candidato generado por JSON Module Factory dry-run.`n`nNo activo. No toca core. No Git. No red.")
$report = [ordered]@{
  status = 'PASS'
  readiness = 100
  module_id = [string]$payload.module_id
  target = $target
  active = $false
  real_module_activation = $false
  git_write = $false
  core_changes = $false
}
WJson (Join-Path $target 'reports\factory-dry-run-result.json') $report
Write-Host ('OK factory_dry_run status=PASS readiness=100 module_id=' + [string]$payload.module_id + ' target=' + $target + ' active=False')
