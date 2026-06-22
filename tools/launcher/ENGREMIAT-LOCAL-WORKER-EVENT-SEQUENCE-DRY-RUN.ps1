$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$SyncDir=Join-Path $Core "documents\worker-sync"
$ProjectId="ENGREMIAT_PROJECT_heartbeat_demo"
$ProjectPath="C:\ENGREMIAT_CORE\projects\ENGREMIAT_PROJECT_heartbeat_demo"
$WorkerId="worker-local-sequence-001"
$TaskId="task-local-sequence-dry-run-001"
New-Item -ItemType Directory -Force -Path $SyncDir,$ProjectPath|Out-Null
function WriteSignal([string]$State,[string]$Phase,[int]$Progress,[string]$Next,[string]$BlockedReason){$stamp=Get-Date -Format "yyyyMMdd-HHmmss";$blockedValue=$null;if(-not [string]::IsNullOrWhiteSpace($BlockedReason)){$blockedValue=$BlockedReason};$hb=[ordered]@{schema_version="1.0";signal_id=("sig-"+$stamp+"-"+$State);project_id=$ProjectId;project_path=$ProjectPath;worker_id=$WorkerId;task_id=$TaskId;state=$State;phase=$Phase;current_step=$Next;progress_pct=$Progress;blocked_reason=$blockedValue;next_action=$Next;evidence_path="documents\worker-sync";heartbeat_at=(Get-Date).ToString("s");expires_at=(Get-Date).AddMinutes(5).ToString("s");source="ENGREMIAT-LOCAL-WORKER-EVENT-SEQUENCE-DRY-RUN";readonly=$true};$hb|ConvertTo-Json -Depth 100|Set-Content (Join-Path $SyncDir "worker-heartbeat-latest.json") -Encoding UTF8;$hb|ConvertTo-Json -Compress -Depth 100|Add-Content (Join-Path $SyncDir "worker-events.jsonl") -Encoding UTF8;$block="OK";if($blockedValue){$block="BLOCK"};[ordered]@{schema_version="1.0";project_id=$ProjectId;project_path=$ProjectPath;state=$State;phase=$Phase;progress_pct=$Progress;worker=$WorkerId;block=$block;next_action=$Next;updated_at=(Get-Date).ToString("s");readonly=$true}|ConvertTo-Json -Depth 100|Set-Content (Join-Path $SyncDir "project-signal-latest.json") -Encoding UTF8;Write-Host ("OK event state="+$State+" phase="+$Phase+" progress="+$Progress+" block="+$block) -ForegroundColor Green}
WriteSignal "QUEUED" "EVENT_SEQUENCE" 5 "worker local en cola" ""
WriteSignal "RUNNING" "EVENT_SEQUENCE" 35 "worker local ejecutando paso simulado" ""
WriteSignal "WAITING_HUMAN" "EVENT_SEQUENCE" 70 "esperando validacion humana simulada" ""
WriteSignal "DONE" "EVENT_SEQUENCE" 100 "secuencia local completada" ""
Write-Host "OK local_worker_event_sequence_complete" -ForegroundColor Green
