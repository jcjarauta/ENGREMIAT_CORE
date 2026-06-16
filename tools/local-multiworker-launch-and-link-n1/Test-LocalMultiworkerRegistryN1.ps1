$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/local-multiworker-launch-and-link-n1'
$reports='reports/local-multiworker-launch-and-link-n1'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$schema=Get-Content "$base/node-registry-schema.json" -Raw|ConvertFrom-Json
$roles=Get-Content "$base/node-roles-model.json" -Raw|ConvertFrom-Json
$profile=Get-Content "$base/local-machine-profile.json" -Raw|ConvertFrom-Json
$registry=Get-Content "$base/nodes-registry.json" -Raw|ConvertFrom-Json
$required=@('node_id','role','availability','workspace_path','capabilities','allowed_actions','forbidden_actions')
$allowedRoles=@('CURRENT_MACHINE','MAIN_PC','AI_LOCAL','OLD_PC','MOBILE','RASPBERRY')
$allowedAvailability=@('ACTIVE','PENDING','OFFLINE','UNKNOWN')
$errors=@()
foreach($n in @($registry.nodes)){foreach($f in $required){if(-not($n.PSObject.Properties.Name -contains $f)){$errors+=("missing_field:"+$n.node_id+":"+$f)}};if($n.role -notin $allowedRoles){$errors+=("invalid_role:"+$n.node_id+":"+$n.role)};if($n.availability -notin $allowedAvailability){$errors+=("invalid_availability:"+$n.node_id+":"+$n.availability)};foreach($bad in @('remote_execution','ssh','git_write','auto_apply','source_write_by_worker')){if($bad -notin @($n.forbidden_actions)){$errors+=("missing_forbidden_action:"+$n.node_id+":"+$bad)}}}
$current=@($registry.nodes|Where-Object{$_.role -eq 'CURRENT_MACHINE' -and $_.availability -eq 'ACTIVE'})
if($current.Count -ne 1){$errors+=("current_machine_active_count:"+$current.Count)}
$remoteOk=($registry.safety.remote_execution -eq $false -and $registry.safety.ssh -eq $false -and $registry.safety.git_write -eq $false -and $registry.safety.apply_executed -eq $false -and $registry.safety.worker_real_execution -eq $false)
$ok=($errors.Count -eq 0 -and $remoteOk)
$report=[ordered]@{objective='ENGREMIAT_LOCAL_MULTIWORKER_LAUNCH_AND_LINK_009A_N1';stage='E01';schema_exists=(Test-Path "$base/node-registry-schema.json");roles_exists=(Test-Path "$base/node-roles-model.json");profile_exists=(Test-Path "$base/local-machine-profile.json");registry_exists=(Test-Path "$base/nodes-registry.json");nodes_total=@($registry.nodes).Count;current_machine_active_count=$current.Count;errors=$errors;remote_execution=$false;ssh=$false;network_write=$false;git_write=$false;apply_executed=$false;worker_real_execution=$false;main_pc_required_for_local_prep=$false;main_pc_required_for_full_test=$true;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=($(if($ok){'GO_E01_LOCAL_NODE_REGISTRY_N1_READY'}else{'NO_GO_E01_REPAIR_REQUIRED'}));next=($(if($ok){'E02_LOCAL_POLICIES_AND_LIMITS'}else{'REPAIR_E01_NODE_REGISTRY'}))}
J $report "$reports/e01-local-registry-validation-report.json"
if(-not $ok){throw "Registry validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E01 readiness="+$report.readiness+" decision="+$report.decision+" nodes_total="+$report.nodes_total+" remote_execution="+$report.remote_execution+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
