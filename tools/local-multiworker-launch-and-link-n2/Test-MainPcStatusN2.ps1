$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/local-multiworker-launch-and-link-n2'
$reports='reports/local-multiworker-launch-and-link-n2'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$required=@("$base/main-pc-check-request.json","$base/main-pc-profile-template.json","$base/main-pc-status.json","$base/nodes-registry-n2.json")
$missing=@();foreach($p in $required){if(-not(Test-Path $p)){$missing+=$p}}
$request=Get-Content "$base/main-pc-check-request.json" -Raw|ConvertFrom-Json
$status=Get-Content "$base/main-pc-status.json" -Raw|ConvertFrom-Json
$registry=Get-Content "$base/nodes-registry-n2.json" -Raw|ConvertFrom-Json
$errors=@()
if($request.remote_connection_allowed -ne $false){$errors+="request_remote_connection_allowed_not_false"}
if($request.ssh_allowed -ne $false){$errors+="request_ssh_allowed_not_false"}
if($status.availability -notin @("ACTIVE","PENDING","OFFLINE")){$errors+="invalid_main_pc_availability"}
if($status.availability -eq "ACTIVE" -and $status.evidence_confirmed -ne $true){$errors+="active_without_confirmed_evidence"}
if($status.safety.remote_execution -ne $false){$errors+="status_remote_execution_not_false"}
if($status.safety.git_write -ne $false){$errors+="status_git_write_not_false"}
if($registry.safety.remote_execution -ne $false){$errors+="registry_remote_execution_not_false"}
if($registry.safety.git_write -ne $false){$errors+="registry_git_write_not_false"}
$main=@($registry.nodes|Where-Object{$_.role -eq "MAIN_PC"})
if($main.Count -ne 1){$errors+=("main_pc_node_count:"+$main.Count)}
if($main.Count -eq 1 -and "remote_execution" -notin @($main[0].forbidden_actions)){$errors+="main_pc_missing_remote_execution_forbidden"}
$ok=($missing.Count -eq 0 -and $errors.Count -eq 0)
$decision=if($ok -and $status.availability -eq "ACTIVE"){"GO_MAIN_PC_ACTIVE"}elseif($ok -and $status.availability -eq "OFFLINE"){"NO_GO_MAIN_PC_OFFLINE"}elseif($ok){"NO_GO_MAIN_PC_PENDING"}else{"NO_GO_E01_REPAIR_REQUIRED"}
$report=[ordered]@{objective="ENGREMIAT_LOCAL_MULTIWORKER_LAUNCH_AND_LINK_009A_N2";stage="E01";required_artifacts=$required;missing_artifacts=$missing;errors=$errors;main_pc_availability=$status.availability;evidence_found=$status.evidence_found;evidence_confirmed=$status.evidence_confirmed;active_requires_evidence=$true;registry="$base/nodes-registry-n2.json";remote_execution=$false;ssh=$false;winrm=$false;network_probe=$false;network_write=$false;git_write=$false;apply_executed=$false;worker_real_execution=$false;validation_ok=$ok;readiness=($(if($ok){100}else{70}));decision=$decision;next=($(if($decision -eq "GO_MAIN_PC_ACTIVE"){"E02_CLINE_PREFLIGHT_ON_MAIN_PC"}elseif($decision -eq "NO_GO_MAIN_PC_PENDING"){"PROVIDE_MAIN_PC_EVIDENCE_OR_STOP_N2"}elseif($decision -eq "NO_GO_MAIN_PC_OFFLINE"){"TURN_ON_MAIN_PC_BEFORE_CONTINUING_N2"}else{"REPAIR_E01_MAIN_PC_STATUS"}))}
J $report "$reports/e01-main-pc-availability-report.json"
if(-not $ok){throw "MAIN-PC status validation failed"}
Write-Host ("OK objective="+$report.objective+" stage=E01 readiness="+$report.readiness+" decision="+$report.decision+" main_pc_availability="+$report.main_pc_availability+" evidence_confirmed="+$report.evidence_confirmed+" remote_execution="+$report.remote_execution+" git_write="+$report.git_write+" next="+$report.next) -ForegroundColor Green
