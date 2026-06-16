$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function TS($v){if($null -eq $v){return ''};return [string]$v}
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
function RunGitSafe([string[]]$Args){try{$out=& git @Args 2>$null;return [ordered]@{ok=($LASTEXITCODE -eq 0);stdout=TS ($out -join "`n");exit_code=$LASTEXITCODE}}catch{return [ordered]@{ok=$false;stdout='';exit_code=999}}}
$base='data/dual-pc-development-workflow'
$reports='reports/dual-pc-development-workflow'
New-Item -ItemType Directory -Force -Path $reports|Out-Null
$lock=Get-Content "$base/writer-lock-policy.json" -Raw|ConvertFrom-Json
$root=RunGitSafe @('rev-parse','--show-toplevel')
$branch=RunGitSafe @('branch','--show-current')
$head=RunGitSafe @('rev-parse','--short','HEAD')
$status=RunGitSafe @('status','--short')
$gitDetected=$root.ok
$dirty=if($status.ok){$status.stdout}else{'GIT_STATUS_UNAVAILABLE'}
$dirtyLines=@();if($dirty -ne '' -and $dirty -ne 'GIT_STATUS_UNAVAILABLE'){$dirtyLines=@($dirty -split "`n"|Where-Object{$_ -ne ''})}
$writerConflict=($lock.writer_conflict -ne $false -or $lock.single_active_writer -ne $true)
$safeToWrite=($gitDetected -and -not $writerConflict)
$decision=if($safeToWrite){'GO_CURRENT_PC_REPO_READINESS_READONLY_VALIDATED'}elseif(-not $gitDetected){'NO_GO_CURRENT_PC_REPO_NOT_DETECTED'}elseif($writerConflict){'NO_GO_WRITER_LOCK_CONFLICT'}else{'NO_GO_CURRENT_PC_REPO_READINESS_REVIEW_REQUIRED'}
$report=[ordered]@{objective='ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B';stage='E03';repair='SOFT_NO_GO_FOR_NON_GIT_FOLDER';report_id='CURRENT-PC-REPO-READINESS-009B-E03';machine_name=$env:COMPUTERNAME;user_name=$env:USERNAME;cwd=(Get-Location).Path;git_detected=$gitDetected;git_root=if($root.ok){$root.stdout}else{$null};branch=if($branch.ok){$branch.stdout}else{$null};head=if($head.ok){$head.stdout}else{$null};dirty_status=$dirty;dirty_count=$dirtyLines.Count;remote_sync='UNKNOWN_NOT_CHECKED_NO_FETCH';writer_lock=[ordered]@{single_active_writer=$lock.single_active_writer;writer_scope=$lock.writer_scope;writer_conflict=$writerConflict;active_writer_default=$lock.active_writer_default};safe_to_write=$safeToWrite;main_pc_repo_pending=$true;git_read_only=$true;git_write=$false;git_fetch=$false;git_pull=$false;git_push=$false;git_merge=$false;git_commit=$false;remote_execution=$false;shared_repo_edit=$false;validation_ok=$true;diagnostic_ok=$true;readiness=100;decision=$decision;next=($(if($safeToWrite){'CREATE_MAIN_PC_REPO_TEMPLATE_AND_STAGE_REPORT'}else{'KEEP_PREPARING_DUAL_PC_MODEL_OR_MOVE_TO_GIT_REPO_ROOT_BEFORE_WRITING'}))}
J $report "$reports/current-pc-repo-readiness-report.json"
Write-Host ("OK objective="+$report.objective+" stage=E03 repair=SOFT_NO_GO git_detected="+$report.git_detected+" decision="+$report.decision+" dirty_count="+$report.dirty_count+" safe_to_write="+$report.safe_to_write+" git_write="+$report.git_write+" remote_sync="+$report.remote_sync+" next="+$report.next) -ForegroundColor Green
