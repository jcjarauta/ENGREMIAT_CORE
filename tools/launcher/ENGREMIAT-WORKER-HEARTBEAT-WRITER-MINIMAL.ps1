$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectId="ENGREMIAT_PROJECT_heartbeat_demo"
$ProjectPath="C:\ENGREMIAT_CORE\projects\ENGREMIAT_PROJECT_heartbeat_demo"
$WorkerId="worker-local-demo-001"
$TaskId="task-heartbeat-demo-001"
$State="RUNNING"
$Phase="HEARTBEAT_DRY_RUN"
$ProgressPct=10
$NextAction="validar writer minimo de heartbeat"
$BlockedReason=""
$SyncDir=Join-Path $Core "documents\worker-sync"
New-Item -ItemType Directory -Force -Path $SyncDir|Out-Null
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$blockedValue=$null
if(-not [string]::IsNullOrWhiteSpace($BlockedReason)){$blockedValue=$BlockedReason}
$hb=[ordered]@{schema_version="1.0";signal_id=("sig-"+$stamp);project_id=$ProjectId;project_path=$ProjectPath;worker_id=$WorkerId;task_id=$TaskId;state=$State;phase=$Phase;current_step=$NextAction;progress_pct=$ProgressPct;blocked_reason=$blockedValue;next_action=$NextAction;evidence_path="documents\worker-sync";heartbeat_at=(Get-Date).ToString("s");expires_at=(Get-Date).AddMinutes(5).ToString("s");source="ENGREMIAT-WORKER-HEARTBEAT-WRITER-MINIMAL";readonly=$true}
$hb|ConvertTo-Json -Depth 100|Set-Content (Join-Path $SyncDir "worker-heartbeat-latest.json") -Encoding UTF8
$hb|ConvertTo-Json -Compress -Depth 100|Add-Content (Join-Path $SyncDir "worker-events.jsonl") -Encoding UTF8
$block="OK"
if($blockedValue){$block="BLOCK"}
[ordered]@{schema_version="1.0";project_id=$ProjectId;project_path=$ProjectPath;state=$State;phase=$Phase;progress_pct=$ProgressPct;worker=$WorkerId;block=$block;next_action=$NextAction;updated_at=(Get-Date).ToString("s");readonly=$true}|ConvertTo-Json -Depth 100|Set-Content (Join-Path $SyncDir "project-signal-latest.json") -Encoding UTF8
Write-Host ("OK heartbeat_writer_minimal project="+$ProjectId+" state="+$State+" phase="+$Phase+" progress="+$ProgressPct+" block="+$block) -ForegroundColor Green
