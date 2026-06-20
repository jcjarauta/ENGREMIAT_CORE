param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_NEEDS_TO_SOLUTION_PROPOSAL_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\needs-to-solution-proposal-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$required=@('module.json','contracts\needs-to-solution-contract.json','schemas\need.schema.json','schemas\need-type-taxonomy.json','schemas\system-signal.schema.json','schemas\gap-analysis-model.json','schemas\need-priority-model.json','schemas\solution-proposal.schema.json','rules\need-detection-rules.json','rules\solution-proposal-rules.json','samples\sample-system-state-snapshot.json','samples\sample-solution-proposal.json','tools\Invoke-EngremiatNeedsDetector.ps1','tools\Invoke-SolutionProposalEngine.ps1')
$missing=@();foreach($rel in $required){if(!(Test-Path (Join-Path $mod $rel))){$missing+=$rel}}
$jsonErrors=@();Get-ChildItem -LiteralPath $mod -Recurse -File -Filter *.json|ForEach-Object{try{Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8|ConvertFrom-Json|Out-Null}catch{$jsonErrors+=$_.FullName}}
$needsReport=Join-Path $reportDir 'needs-detection-report.json'
$proposalReport=Join-Path $reportDir 'solution-proposal-report.json'
$pass=($missing.Count -eq 0 -and $jsonErrors.Count -eq 0 -and (Test-Path $needsReport) -and (Test-Path $proposalReport))
$report=[ordered]@{package_id=$pkg;status=$(if($pass){'PASS'}else{'ERR'});readiness=$(if($pass){100}else{0});required_checked=$required.Count;missing=$missing;json_errors=$jsonErrors;needs_report_exists=(Test-Path $needsReport);proposal_report_exists=(Test-Path $proposalReport);local_only=$true;ollama_inference=$false;git_write=$false;network=$false;next=$(if($pass){'E07_MANUAL_CLOSE_AND_NEXT'}else{'REPAIR_E06_VALIDATION'})}
$reportPath=Join-Path $reportDir 'needs-to-solution-validation-report.json'
WJson $reportPath $report
Write-Host ("OK needs_to_solution_validator status="+$report.status+" readiness="+$report.readiness+" missing="+$missing.Count+" json_errors="+$jsonErrors.Count+" report="+$reportPath+" next="+$report.next)
if(!$pass){exit 1}
