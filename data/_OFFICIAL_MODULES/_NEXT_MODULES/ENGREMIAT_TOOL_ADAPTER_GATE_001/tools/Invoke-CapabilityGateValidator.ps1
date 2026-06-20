param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_TOOL_ADAPTER_GATE_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\tool-adapter-gate-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$required=@('module.json','contracts\capability-gate-contract.json','contracts\workflow-standard-link.json','schemas\capability-catalog.json','schemas\permission-levels.json','schemas\capability-risk-levels.json','schemas\capability-gate.schema.json','contracts\tool-capability-map.json','contracts\tool-adapter-profiles.json','contracts\client-feature-capability-map.json','contracts\capability-evidence-matrix.json','schemas\capability-audit-event.schema.json','contracts\capability-rollback-policy.json','contracts\authorization-expiry-policy.json','samples\sample-capability-gate-request.json','samples\sample-human-decision.json','tools\Invoke-CapabilityGateSimulator.ps1')
$missing=@();foreach($rel in $required){if(!(Test-Path (Join-Path $mod $rel))){$missing+=$rel}}
$jsonErrors=@();Get-ChildItem -LiteralPath $mod -Recurse -File -Filter *.json|ForEach-Object{try{Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8|ConvertFrom-Json|Out-Null}catch{$jsonErrors+=$_.FullName}}
$report=[ordered]@{package_id=$pkg;status=$(if($missing.Count -eq 0 -and $jsonErrors.Count -eq 0){'PASS'}else{'ERR'});readiness=$(if($missing.Count -eq 0 -and $jsonErrors.Count -eq 0){100}else{0});required_checked=$required.Count;missing=$missing;json_errors=$jsonErrors;local_only=$true;real_tool_integration=$false;git_write=$false;network=$false;next=$(if($missing.Count -eq 0 -and $jsonErrors.Count -eq 0){'E07_MANUAL_CLOSE_AND_NEXT'}else{'REPAIR_E06_SIMULATOR_AND_VALIDATOR'})}
$reportPath=Join-Path $reportDir 'capability-gate-validation-report.json'
WJson $reportPath $report
Write-Host ("OK capability_gate_validator status="+$report.status+" readiness="+$report.readiness+" missing="+$missing.Count+" json_errors="+$jsonErrors.Count+" report="+$reportPath+" next="+$report.next)
if($report.status -ne 'PASS'){exit 1}
