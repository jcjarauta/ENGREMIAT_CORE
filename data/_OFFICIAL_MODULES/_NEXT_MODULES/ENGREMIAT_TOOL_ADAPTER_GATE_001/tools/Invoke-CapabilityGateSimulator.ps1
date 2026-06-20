param([string]$Root='C:\ENGREMIAT_CORE',[string]$RequestPath,[string]$DecisionPath)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function WJson($Path,$Object){$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
$pkg='ENGREMIAT_TOOL_ADAPTER_GATE_001'
$mod=Join-Path $Root "data\_OFFICIAL_MODULES\_NEXT_MODULES\$pkg"
$reportDir=Join-Path $Root 'reports\tool-adapter-gate-001'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
if([string]::IsNullOrWhiteSpace($RequestPath)){$RequestPath=Join-Path $mod 'samples\sample-capability-gate-request.json'}
if([string]::IsNullOrWhiteSpace($DecisionPath)){$DecisionPath=Join-Path $mod 'samples\sample-human-decision.json'}
$request=Get-Content -LiteralPath $RequestPath -Raw -Encoding UTF8|ConvertFrom-Json
$decision=Get-Content -LiteralPath $DecisionPath -Raw -Encoding UTF8|ConvertFrom-Json
$capCatalog=Get-Content -LiteralPath (Join-Path $mod 'schemas\capability-catalog.json') -Raw -Encoding UTF8|ConvertFrom-Json
$toolMap=Get-Content -LiteralPath (Join-Path $mod 'contracts\tool-capability-map.json') -Raw -Encoding UTF8|ConvertFrom-Json
$errors=@();$warnings=@()
$toolProfile=$toolMap.tools|Where-Object{$_.tool -eq $request.tool}|Select-Object -First 1
if(!$toolProfile){$errors+='tool_not_mapped'}elseif(@($toolProfile.capabilities) -notcontains $request.capability){$errors+='capability_not_allowed_for_tool'}
$cap=$capCatalog.capabilities|Where-Object{$_.capability -eq $request.capability}|Select-Object -First 1
if(!$cap){$errors+='capability_not_in_catalog'}
$requiresGate=$false
if($cap){if($cap.gate_required -eq $true){$requiresGate=$true};if([string]$cap.gate_required -eq 'IF_STATE_IMPACT' -and $request.state_impact -eq $true){$requiresGate=$true}}
if($requiresGate -and $decision.decision -ne 'APPROVE'){$errors+='gate_required_not_approved'}
if($decision.request_id -ne $request.request_id){$errors+='decision_request_mismatch'}
if($request.risk -in @('HIGH','CRITICAL') -and $decision.scope -ne 'single_action'){$warnings+='high_risk_should_use_single_action_scope'}
$result=[ordered]@{package_id=$pkg;status=$(if($errors.Count -eq 0){'PASS'}else{'ERR'});readiness=$(if($errors.Count -eq 0){100}else{0});request=$RequestPath;decision=$DecisionPath;tool=$request.tool;capability=$request.capability;requires_gate=$requiresGate;decision_value=$decision.decision;errors=$errors;warnings=$warnings;local_only=$true;real_tool_integration=$false;next=$(if($errors.Count -eq 0){'E06_GLOBAL_VALIDATION'}else{'REPAIR_CAPABILITY_GATE_REQUEST'})}
$reportPath=Join-Path $reportDir 'capability-gate-simulation-report.json'
WJson $reportPath $result
Write-Host ("OK capability_gate_simulator status="+$result.status+" readiness="+$result.readiness+" tool="+$request.tool+" capability="+$request.capability+" errors="+$errors.Count+" warnings="+$warnings.Count+" report="+$reportPath)
if($errors.Count -gt 0){exit 1}
