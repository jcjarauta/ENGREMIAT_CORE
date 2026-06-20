param([ValidateSet('REVIEW','APPROVE_FOR_PREVIEW','DEFER','REJECT','REQUEST_REPAIR','MARK_BLOCKED','MARK_DONE_MANUAL')][string]$Decision='DEFER',[string]$Reason='Sin motivo indicado',[string]$TargetId='MANUAL')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$objective='ENGREMIAT_HUMAN_USABLE_DAILY_WORKBENCH_086_095'
$stage='E88'
$outDir='data\decision-shortcuts-088\ledger'
New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$utc=(Get-Date).ToUniversalTime().ToString('o')
$needsReason=@('APPROVE_FOR_PREVIEW','REJECT','REQUEST_REPAIR','MARK_BLOCKED')
$reasonOk= -not ($needsReason -contains $Decision) -or -not [string]::IsNullOrWhiteSpace($Reason)
$record=[ordered]@{objective=$objective;stage=$stage;decision_id=('DS-088-'+(Get-Date -Format 'yyyyMMddHHmmss'));target_id=$TargetId;decision=$Decision;reason=$Reason;reason_required=($needsReason -contains $Decision);reason_ok=$reasonOk;shortcut_executes_real_action=$false;human_gate_required=$true;apply_executed=$false;auto_apply=$false;remote_execution=$false;git_write=$false;external_network=$false;worker_executed=$false;kanban_real_write=$false;created_utc=$utc}
$path=Join-Path $outDir 'decision-shortcuts-ledger.jsonl'
$record|ConvertTo-Json -Compress -Depth 20|Add-Content $path -Encoding UTF8
if($reasonOk){Write-Host ('OK objective=ENGREMIAT_HUMAN_USABLE_DAILY_WORKBENCH_086_095 stage=E88 decision_shortcut_recorded=true decision='+$Decision+' target_id='+$TargetId+' auto_apply=false git_write=false kanban_real_write=false')}else{Write-Host ('NO_GO objective=ENGREMIAT_HUMAN_USABLE_DAILY_WORKBENCH_086_095 stage=E88 decision_shortcut_recorded=true decision='+$Decision+' reason_missing=true auto_apply=false git_write=false kanban_real_write=false')}
