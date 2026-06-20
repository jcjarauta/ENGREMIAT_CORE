$ErrorActionPreference='Stop'
param([string]$TaskId='TASK-ASSISTED-001',[string]$Mode='MANUAL_HANDOFF')
New-Item -ItemType Directory -Force -Path 'data/dev-assisted-worker'|Out-Null
$rec=[ordered]@{task_id=$TaskId;mode=$Mode;created_at=(Get-Date).ToString('o');status='HANDOFF_PREPARED_NOT_SENT';auto_apply=$false;remote_execution=$false;git_write=$false}
($rec|ConvertTo-Json -Depth 20 -Compress)|Add-Content 'data/dev-assisted-worker/handoff-registry.jsonl' -Encoding UTF8
Write-Host ('OK tool=eng-assisted-handoff task='+$TaskId+' mode='+$Mode+' status=HANDOFF_PREPARED_NOT_SENT')
