param([string]$Root='C:\ENGREMIAT_CORE')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_RESOURCE_LIBRARY_STANDARD_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$indexDir=Join-Path $mod 'library\index'
New-Item -ItemType Directory -Force -Path $indexDir|Out-Null
$files=Get-ChildItem -LiteralPath (Join-Path $mod 'samples\resources') -File -Filter '*.manifest.json' -ErrorAction SilentlyContinue
$resources=@()
foreach($f in $files){
  $r=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8|ConvertFrom-Json
  $resources+=[ordered]@{resource_id=$r.resource_id;resource_type=$r.resource_type;status=$r.status;title=$r.title;domain=$r.domain;capabilities=$r.capabilities;version=$r.version;location=$r.location;quality_score=$r.quality.overall_score;evidence_status=$(if(@($r.evidence).Count -gt 0){'HAS_EVIDENCE_REF'}else{'MISSING_EVIDENCE'});manifest=$f.FullName}
}
$summary=[ordered]@{resources_total=$resources.Count;by_status=($resources|Group-Object status|ForEach-Object{[ordered]@{status=$_.Name;count=$_.Count}});by_type=($resources|Group-Object resource_type|ForEach-Object{[ordered]@{type=$_.Name;count=$_.Count}})}
$index=[ordered]@{index_id='resource-library-index.v1';generated_at=(Get-Date).ToString('s');resources=$resources;summary=$summary}
$indexPath=Join-Path $indexDir 'resource-library-index.json'
WJson $indexPath $index
Write-Host ("OK resource_library_index_builder status=PASS resources="+$resources.Count+" index="+$indexPath)
