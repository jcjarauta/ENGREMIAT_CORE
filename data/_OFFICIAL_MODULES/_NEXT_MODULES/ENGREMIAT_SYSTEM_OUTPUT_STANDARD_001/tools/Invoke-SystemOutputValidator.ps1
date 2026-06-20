param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_SYSTEM_OUTPUT_STANDARD_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\system-output-standard-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$required=@('module.json','contracts\system-output-contract.json','schemas\output-type-catalog.json','schemas\output-envelope.schema.json','contracts\output-evidence-policy.json','contracts\output-gate-policy.json','schemas\output-audit-event.schema.json','contracts\model-output-adapter-contract.json','rules\output-transform-rules.json','contracts\output-compatibility-map.json','tools\Invoke-SystemOutputRouterDryRun.ps1','samples\sample-model-output.json')
$missing=@();foreach($rel in $required){if(!(Test-Path (Join-Path $mod $rel))){$missing+=$rel}}
$jsonErrors=@();Get-ChildItem -LiteralPath $mod -Recurse -File -Filter *.json|ForEach-Object{try{Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8|ConvertFrom-Json|Out-Null}catch{$jsonErrors+=$_.FullName}}
$outputFiles=Get-ChildItem -LiteralPath (Join-Path $mod 'samples\outputs') -File -Filter '*.json' -ErrorAction SilentlyContinue
$outputErrors=@()
foreach($f in $outputFiles){$o=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8|ConvertFrom-Json;foreach($k in @('output_id','output_type','source','status','payload','evidence','gate','created_at')){if(-not $o.PSObject.Properties.Name.Contains($k)){$outputErrors+=($f.Name+':missing_'+$k)}}}
$routerReport=Join-Path $reportDir 'output-router-report.json'
$pass=($missing.Count -eq 0 -and $jsonErrors.Count -eq 0 -and $outputErrors.Count -eq 0 -and (Test-Path $routerReport))
$report=[ordered]@{package_id=$pkg;status=$(if($pass){'PASS'}else{'ERR'});readiness=$(if($pass){100}else{0});required_checked=$required.Count;sample_outputs=$outputFiles.Count;missing=$missing;json_errors=$jsonErrors;output_errors=$outputErrors;router_report_exists=(Test-Path $routerReport);local_only=$true;ollama_inference=$false;model_dependency=$false;git_write=$false;network=$false;next=$(if($pass){'E07_MANUAL_CLOSE_AND_NEXT'}else{'REPAIR_E06_SYSTEM_OUTPUT_VALIDATION'})}
$reportPath=Join-Path $reportDir 'system-output-validation-report.json'
WJson $reportPath $report
Write-Host ("OK system_output_validator status="+$report.status+" readiness="+$report.readiness+" sample_outputs="+$outputFiles.Count+" missing="+$missing.Count+" json_errors="+$jsonErrors.Count+" output_errors="+$outputErrors.Count+" report="+$reportPath)
if(!$pass){exit 1}
