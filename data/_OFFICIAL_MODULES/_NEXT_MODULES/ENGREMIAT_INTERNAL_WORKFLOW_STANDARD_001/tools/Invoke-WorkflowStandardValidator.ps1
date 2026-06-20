param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_INTERNAL_WORKFLOW_STANDARD_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\internal-workflow-standard-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$required=@('module.json','contracts\workflow-standard-contract.json','contracts\operational-glossary.json','schemas\project.schema.json','schemas\task.schema.json','schemas\worker.schema.json','schemas\resource.schema.json','schemas\evidence.schema.json','schemas\task-type-taxonomy.json','schemas\resource-type-taxonomy.json','schemas\io-type-taxonomy.json','contracts\tool-adapter-contract.json','contracts\adapter-role-map.json','contracts\adapter-safety-policy.json','samples\sample-project-software.json','samples\sample-project-grant.json','samples\sample-project-business-plan.json','samples\sample-audio-meeting-task.json')
$missing=@()
foreach($rel in $required){if(!(Test-Path (Join-Path $mod $rel))){$missing+=$rel}}
$jsonErrors=@()
Get-ChildItem -LiteralPath $mod -Recurse -File -Filter *.json|ForEach-Object{try{Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8|ConvertFrom-Json|Out-Null}catch{$jsonErrors+=$_.FullName}}
$report=[ordered]@{package_id=$pkg;status=$(if($missing.Count -eq 0 -and $jsonErrors.Count -eq 0){'PASS'}else{'ERR'});readiness=$(if($missing.Count -eq 0 -and $jsonErrors.Count -eq 0){100}else{0});required_checked=$required.Count;missing=$missing;json_errors=$jsonErrors;local_only=$true;real_tool_integration=$false;git_write=$false;network=$false;next=$(if($missing.Count -eq 0 -and $jsonErrors.Count -eq 0){'E07_MANUAL_CLOSE_AND_NEXT'}else{'REPAIR_E06_VALIDATION_AND_EXAMPLES'})}
$reportPath=Join-Path $reportDir 'workflow-standard-validation-report.json'
WJson $reportPath $report
Write-Host ("OK workflow_standard_validator status="+$report.status+" readiness="+$report.readiness+" missing="+$missing.Count+" json_errors="+$jsonErrors.Count+" report="+$reportPath+" next="+$report.next)
if($report.status -ne 'PASS'){exit 1}
