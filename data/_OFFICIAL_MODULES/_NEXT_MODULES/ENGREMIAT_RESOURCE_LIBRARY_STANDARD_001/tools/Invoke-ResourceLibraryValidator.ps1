param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_RESOURCE_LIBRARY_STANDARD_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\resource-library-standard-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$required=@('module.json','contracts\resource-library-contract.json','schemas\resource-manifest.schema.json','schemas\resource-library-index.schema.json','schemas\resource-search-fields.json','schemas\resource-composer-query.schema.json','tools\Invoke-ResourceLibraryIndexBuilder.ps1','samples\sample-composition-blueprint.json')
$missing=@();foreach($rel in $required){if(!(Test-Path (Join-Path $mod $rel))){$missing+=$rel}}
$jsonErrors=@();Get-ChildItem -LiteralPath $mod -Recurse -File -Filter *.json|ForEach-Object{try{Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8|ConvertFrom-Json|Out-Null}catch{$jsonErrors+=$_.FullName}}
$manifests=Get-ChildItem -LiteralPath (Join-Path $mod 'samples\resources') -File -Filter '*.manifest.json' -ErrorAction SilentlyContinue
$manifestErrors=@()
foreach($f in $manifests){$r=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8|ConvertFrom-Json;foreach($k in @('resource_id','resource_type','status','title','version','capabilities','location','quality','gate')){if(-not $r.PSObject.Properties.Name.Contains($k)){$manifestErrors+=($f.Name+':missing_'+$k)}}}
$indexPath=Join-Path $mod 'library\index\resource-library-index.json'
$indexExists=Test-Path $indexPath
$pass=($missing.Count -eq 0 -and $jsonErrors.Count -eq 0 -and $manifestErrors.Count -eq 0 -and $indexExists)
$report=[ordered]@{package_id=$pkg;status=$(if($pass){'PASS'}else{'ERR'});readiness=$(if($pass){100}else{0});required_checked=$required.Count;manifest_count=$manifests.Count;index_exists=$indexExists;missing=$missing;json_errors=$jsonErrors;manifest_errors=$manifestErrors;local_only=$true;git_write=$false;network=$false;ollama_inference=$false;next=$(if($pass){'E07_MANUAL_CLOSE_AND_NEXT'}else{'REPAIR_E06_RESOURCE_LIBRARY_VALIDATION'})}
$reportPath=Join-Path $reportDir 'resource-library-validation-report.json'
WJson $reportPath $report
Write-Host ("OK resource_library_validator status="+$report.status+" readiness="+$report.readiness+" manifests="+$manifests.Count+" missing="+$missing.Count+" json_errors="+$jsonErrors.Count+" manifest_errors="+$manifestErrors.Count+" report="+$reportPath)
if(!$pass){exit 1}
