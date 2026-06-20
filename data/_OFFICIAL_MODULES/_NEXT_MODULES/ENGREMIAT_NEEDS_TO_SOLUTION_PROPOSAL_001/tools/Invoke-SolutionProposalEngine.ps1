param([string]$Root='C:\ENGREMIAT_CORE',[string]$NeedsReport='')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_NEEDS_TO_SOLUTION_PROPOSAL_001'
$reportDir=Join-Path $Root 'reports\needs-to-solution-proposal-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
if([string]::IsNullOrWhiteSpace($NeedsReport)){$NeedsReport=Join-Path $reportDir 'needs-detection-report.json'}
$n=Get-Content -LiteralPath $NeedsReport -Raw -Encoding UTF8|ConvertFrom-Json
$proposals=@()
foreach($need in @($n.needs)){
  $solution=if($need.need_type -in @('COMPOSITION_GAP','SYSTEM_REPRODUCTION_GAP')){'ENGREMIAT_RESOURCE_COMPOSER_OLLAMA_READY_001'}else{'CREATE_SUPPORTING_RESOURCE_OR_VALIDATOR'}
  $proposals+=[ordered]@{proposal_id=('PROPOSAL-'+$need.need_id);need_id=$need.need_id;need_type=$need.need_type;recommended_solution=$solution;proposal_type='CREATE_NEXT_MODULE';required_capabilities=$need.related_capabilities;required_resources=$need.available_resources;missing_resources=$need.missing_resources;expected_outputs=@('contract','schema','dry_run','validation_report','manual');priority=$need.priority;risk='MEDIUM';gates=@('HUMAN_REVIEW_REQUIRED');evidence=@('needs-detection-report.json');next_action=$solution;status='PROPOSED'}
}
$report=[ordered]@{package_id=$pkg;status='PASS';readiness=100;needs_report=$NeedsReport;proposals_count=$proposals.Count;proposals=$proposals;local_only=$true;proposal_execution=$false;ollama_inference=$false;git_write=$false;network=$false;next='E06_VALIDATION'}
$reportPath=Join-Path $reportDir 'solution-proposal-report.json'
WJson $reportPath $report
Write-Host ("OK solution_proposal_engine status=PASS readiness=100 proposals="+$proposals.Count+" report="+$reportPath+" next=E06_VALIDATION")
