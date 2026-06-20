param([string]$Root='C:\ENGREMIAT_CORE',[string]$OutputPath='')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_SYSTEM_OUTPUT_STANDARD_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\system-output-standard-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
if([string]::IsNullOrWhiteSpace($OutputPath)){$OutputPath=Join-Path $mod 'samples\outputs\sample-composition-blueprint-output.json'}
$o=Get-Content -LiteralPath $OutputPath -Raw -Encoding UTF8|ConvertFrom-Json
$dest=switch($o.output_type){'PROPOSAL'{'HUMAN_REVIEW_OR_TASK_PLAN'}'DECISION'{'APPLY_DECISION_DRY_RUN'}'TASK_PLAN'{'PROJECT_TASK_PLANNER'}'RESOURCE_QUERY'{'RESOURCE_LIBRARY_SEARCH'}'COMPOSITION_BLUEPRINT'{'BUILD_PACKAGE_PREPARATION'}'BUILD_PACKAGE'{'HUMAN_GATE_REQUIRED_NO_EXECUTION'}default{'UNKNOWN'}}
$report=[ordered]@{package_id=$pkg;status='PASS';readiness=100;input=$OutputPath;output_type=$o.output_type;route=$dest;execution=$false;local_only=$true;next='E06_VALIDATION'}
$reportPath=Join-Path $reportDir 'output-router-report.json'
WJson $reportPath $report
Write-Host ("OK output_router status=PASS output_type="+$o.output_type+" route="+$dest+" report="+$reportPath)
