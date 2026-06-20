$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
function GS([string[]]$a){try{$o=& git @a 2>$null;[ordered]@{ok=($LASTEXITCODE -eq 0);out=($o -join "`n")}}catch{[ordered]@{ok=$false;out=''}}}
$base='data/kanban-real-setup-012'
$reports='reports/kanban-real-setup-012'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$schema=Get-Content "$base/kanban-real-preflight-schema.json" -Raw | ConvertFrom-Json
$req=Get-Content "$base/kanban-surface-inventory-request.json" -Raw | ConvertFrom-Json
$root=GS @('rev-parse','--show-toplevel')
if($root.ok){Set-Location $root.out}
$branch=GS @('branch','--show-current')
$head=GS @('rev-parse','--short','HEAD')
$status=GS @('status','--short')
$origin=GS @('remote','get-url','origin')
$errors=@()
if($schema.required_fields.Count -lt 10){$errors+="schema_fields_missing"}
if($req.must_detect.Count -lt 5){$errors+="request_must_detect_missing"}
if(-not $root.ok){$errors+="git_root_not_detected"}
if(-not $branch.ok){$errors+="git_branch_not_detected"}
if(-not $head.ok){$errors+="git_head_not_detected"}
if(-not $origin.ok){$errors+="git_origin_not_detected"}
if($schema.safety.git_write -ne $false){$errors+="schema_git_write_not_false"}
if($req.safety.git_write -ne $false){$errors+="request_git_write_not_false"}
$ok=($errors.Count -eq 0)
$readiness=70
$decision="NO_GO_MAIN_PC_REPAIR_REQUIRED"
$next="REPAIR_OR_INSTALL_MISSING_COMPONENTS"
if($ok){$readiness=100;$decision="GO_MAIN_PC_READY";$next="E02_KANBAN_MODEL_CANONICAL"}
$report=[ordered]@{objective="ENGREMIAT_KANBAN_REAL_SETUP_012";stage="E01";git_root=if($root.ok){$root.out}else{$null};branch=if($branch.ok){$branch.out}else{$null};head=if($head.ok){$head.out}else{$null};dirty_status=if($status.ok){$status.out}else{"GIT_STATUS_UNAVAILABLE"};origin=if($origin.ok){$origin.out}else{$null};decision=$decision;errors=$errors;next=$next;validation_ok=$ok;readiness=$readiness}
J $report "$reports/e01-kanban-real-preflight-report.json"
Write-Host ("RESULT objective=ENGREMIAT_KANBAN_REAL_SETUP_012 stage=E01 readiness="+$readiness+" decision="+$decision+" git_root="+$report.git_root+" branch="+$report.branch+" head="+$report.head+" next="+$next) -ForegroundColor Green
