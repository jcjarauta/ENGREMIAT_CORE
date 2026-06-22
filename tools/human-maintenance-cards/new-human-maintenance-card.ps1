param([string]$SourceScreen='manual', [string]$SourceContext='human_manual_capture', [string]$Dimension='other', [string]$Severity='INFO', [string]$Title='Tarjeta de mantenimiento humano', [string]$Description='Observacion humana pendiente de evaluar', [string]$Observation='Observacion no especificada', [string]$SuggestedAction='', [string]$ProjectId='', [string]$ModuleId='', [string]$ObjectId='')
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_HUMAN_MAINTENANCE_CARD_001'
$stage='CREATE_HUMAN_MAINTENANCE_CARD_CAPTURE_ONLY'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function ReadJson($p){Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json}
function SafeId($v){return ("$v" -replace '[^A-Za-z0-9_\-]','_')}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  $baseDir=Join-Path $root 'documents\human-maintenance-cards'
  $taxonomyPath=Join-Path $baseDir 'taxonomy\human-maintenance-card-taxonomy.latest.json'
  $safetyPath=Join-Path $baseDir 'safety\human-maintenance-card-safety-policy.latest.json'
  if(-not(Test-Path -LiteralPath $taxonomyPath)){throw "TAXONOMY_NOT_FOUND path=$taxonomyPath"}
  if(-not(Test-Path -LiteralPath $safetyPath)){throw "SAFETY_POLICY_NOT_FOUND path=$safetyPath"}
  $taxonomy=ReadJson $taxonomyPath
$safety=ReadJson $safetyPath
  if("$($safety.default_mode)" -ne 'CAPTURE_ONLY_NO_EXECUTION'){throw "UNSAFE_CAPTURE_POLICY mode=$($safety.default_mode)"}
  $dim=$Dimension.ToLowerInvariant().Trim()
  if(@($taxonomy.dimensions) -notcontains $dim){$dim='other'}
  $sev=$Severity.ToUpperInvariant().Trim()
  $validSeverity=@($taxonomy.severity | ForEach-Object {$_.id})
  if($validSeverity -notcontains $sev){$sev='INFO'}
  $ts=Get-Date -Format 'yyyyMMdd-HHmmss'
  $inboxDir=Join-Path $baseDir 'inbox'
  $reportsDir=Join-Path $root 'reports\human-maintenance-cards'
  New-Item -ItemType Directory -Force -Path $inboxDir,$reportsDir | Out-Null
  $screenSafe=SafeId $SourceScreen
  $cardId="HMC-$screenSafe-$ts"
  $requiresAuth=$false
  if($dim -in @('security','hardware','financing')){$requiresAuth=$true}
  if($sev -in @('HIGH','CRITICAL')){$requiresAuth=$true}
  $card=[ordered]@{schema='engremiat.human_maintenance_card.v1';package_id=$package;stage=$stage;created_at=(Get-Date).ToString('s');maintenance_card_id=$cardId;created_by='human';source_screen=$SourceScreen;source_context=$SourceContext;project_id=$ProjectId;module_id=$ModuleId;object_id=$ObjectId;dimension=$dim;severity=$sev;title=$Title;description=$Description;human_observation=$Observation;suggested_action=$SuggestedAction;machine_detection_gap='human_signal_not_yet_evaluated_by_observer';status='NEW';observer_should_evaluate=$true;requires_authorization=$requiresAuth;canonical_action_candidate=$false;safety=[ordered]@{real_execution=$false;system_mutation=$false;screen_mutation=$false;worker=$false;browser=$false;network=$false;git=$false;capture_only=$true};next='OBSERVER_PENDING_REVIEW'}
  $jsonPath=Join-Path $inboxDir "$cardId.json"
  $mdPath=Join-Path $inboxDir "$cardId.md"
  $reportPath=Join-Path $reportsDir "create-human-maintenance-card-$cardId.json"
  $card | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $jsonPath -Encoding UTF8
  $card | ConvertTo-Json -Depth 100 | Set-Content -LiteralPath $reportPath -Encoding UTF8
  @("# HUMAN MAINTENANCE CARD","","- id: $cardId","- status: NEW","- source_screen: $SourceScreen","- dimension: $dim","- severity: $sev","- requires_authorization: $requiresAuth","","## Title","$Title","","## Description","$Description","","## Human observation","$Observation","","## Suggested action","$SuggestedAction","","## Safety","- real_execution: false","- system_mutation: false","- worker: false","- browser: false","- network: false","- git: false") | Set-Content -LiteralPath $mdPath -Encoding UTF8
  W "OK human_maintenance_card_created card=$jsonPath markdown=$mdPath" Green
  W "OK package_id=$package stage=$stage status=PASS card_id=$cardId observer_should_evaluate=True requires_authorization=$requiresAuth real_execution=False system_mutation=False worker=False browser=False network=False git=False report=$reportPath next=E03_SMOKE_CREATE_HUMAN_MAINTENANCE_CARD_DEMO" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
