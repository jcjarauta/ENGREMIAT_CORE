param([string]$Root='C:\ENGREMIAT_CORE',[string]$SnapshotPath='')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_NEEDS_TO_SOLUTION_PROPOSAL_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\needs-to-solution-proposal-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
if([string]::IsNullOrWhiteSpace($SnapshotPath)){$SnapshotPath=Join-Path $mod 'samples\sample-system-state-snapshot.json'}
$s=Get-Content -LiteralPath $SnapshotPath -Raw -Encoding UTF8|ConvertFrom-Json
$needs=@()
if(@($s.capabilities_missing) -contains 'RESOURCE_COMPOSITION'){
  $needs+=[ordered]@{need_id='NEED-COMPOSITION-001';need_type='COMPOSITION_GAP';title='Falta compositor de recursos';description='La biblioteca existe pero falta el motor que convierte necesidades en blueprints de composicion.';signals=@('SIG-001','SIG-002');related_capabilities=@('RESOURCE_COMPOSITION','BLUEPRINT_GENERATION');available_resources=@('ENGREMIAT_RESOURCE_LIBRARY_STANDARD_001','ENGREMIAT_TOOL_ADAPTER_GATE_001');missing_resources=@('RESOURCE_COMPOSER');priority='HIGH';recommended_next_action='ENGREMIAT_RESOURCE_COMPOSER_OLLAMA_READY_001';gate='HUMAN_REVIEW_REQUIRED';status='DETECTED'}
}
if($s.health.composition -lt 50){
  $needs+=[ordered]@{need_id='NEED-COMPOSITION-HEALTH-001';need_type='SYSTEM_REPRODUCTION_GAP';title='Baja madurez de composicion';description='La dimension composition esta por debajo del umbral operativo.';signals=@('health.composition');related_capabilities=@('RESOURCE_COMPOSITION');available_resources=@();missing_resources=@('COMPOSER','COMPOSITION_VALIDATOR');priority='HIGH';recommended_next_action='CREATE_COMPOSER_LAYER';gate='HUMAN_REVIEW_REQUIRED';status='DETECTED'}
}
$report=[ordered]@{package_id=$pkg;status='PASS';readiness=100;snapshot=$SnapshotPath;needs_count=$needs.Count;needs=$needs;local_only=$true;read_only_observation=$true;ollama_inference=$false;git_write=$false;network=$false;next='E05_SOLUTION_PROPOSAL'}
$reportPath=Join-Path $reportDir 'needs-detection-report.json'
WJson $reportPath $report
Write-Host ("OK needs_detector status=PASS readiness=100 needs="+$needs.Count+" report="+$reportPath+" next=E05_SOLUTION_PROPOSAL")
