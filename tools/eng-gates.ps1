$ErrorActionPreference='Stop'
param([string]$Mode='pending',[string]$GateId='',[string]$Decision='DEFER')
$pendingPath='data/gates/pending-gates.json'
$historyPath='data/gates/gate-registry.jsonl'
if($Mode -eq 'pending'){if(Test-Path $pendingPath){(Get-Content $pendingPath -Raw -Encoding UTF8|ConvertFrom-Json).pending_gates|Format-Table gate_id,stage,action,risk,decision,status -AutoSize}else{Write-Host 'WARN no pending gates file'};return}
if($Mode -eq 'history'){if(Test-Path $historyPath){Get-Content $historyPath -Encoding UTF8|Where-Object{$_}|ForEach-Object{$_|ConvertFrom-Json}|Format-Table gate_id,stage,action,decision,status -AutoSize}else{Write-Host 'WARN no gate history'};return}
if($Mode -eq 'approve'){throw 'APPROVE_REQUIRES_DEDICATED_EXPLICIT_SAFE_APPLY_SCRIPT_NOT_GENERIC_GATE_TOOL'}
Write-Host 'OK tool=eng-gates modes=pending,history approve_requires_dedicated_script'
