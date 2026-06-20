param(
  [Parameter(Position=0)][string]$Command='start',
  [Parameter(ValueFromRemainingArguments=$true)][string[]]$Args
)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $Root
function Say($level,$msg){
  $color='Cyan'
  if($level -eq 'OK'){$color='Green'}
  elseif($level -eq 'ERR'){$color='Red'}
  elseif($level -eq 'WARN'){$color='Yellow'}
  elseif($level -eq 'NEXT'){$color='Magenta'}
  Write-Host "$level $msg" -ForegroundColor $color
}
function Open-IfExists($path){
  if(Test-Path $path){Start-Process $path; Say 'OK' "opened=$path"} else {Say 'WARN' "missing=$path"}
}
function Show-JsonSummary($path){
  if(Test-Path $path){Get-Content $path -Raw | Write-Host} else {Say 'WARN' "missing=$path"}
}
$aliases=@{
  home='start';inicio='start';estado='status';siguiente='next';ready='readiness';
  gate='gates';artefactos='artifacts';ctx='context';err='errors';
  manual='docs';help='docs';ayuda='docs';panel='dashboard';'open-mvp'='mvp-open';
  'plan-prompt'='prompt';'worker-prompt'='prompt';bandeja='inbox';revisar='review';aprobar='approve'
}
if($aliases.ContainsKey($Command)){ $Command=$aliases[$Command] }
switch($Command){  'daily' { Say 'OK' 'objective=ENGREMIAT_POST_MVP_OPERATIONAL_DAILY_LOOP_046_055 stage=E46 daily_loop=ready local_first=true'; Say 'OK' 'routine= status -> next -> inbox -> review -> human decision'; Say 'NEXT' 'E47_OPERATIONAL_INBOX' }

  'start' { Open-IfExists 'dashboard\human-start\index.html' }
  'status' { Say 'OK' 'objective=ENGREMIAT_MVP_HUMAN_USABLE_036_045 stage=E37 command_hub=eng.ps1 local_first=True human_decision_required=True' }
  'next' { Say 'NEXT' 'E38_PLAN_PROMPT_WORKER_ROUNDTRIP' }
  'readiness' { Show-JsonSummary 'reports\command-hub-037\e37-command-hub-readiness-report.json' }
  'gates' { Say 'OK' 'gates_policy=human_gate_before_sensitive_actions approve_is_preview_only apply_executed=false auto_apply=false' }
  'artifacts' { Get-ChildItem data,reports,docs,dashboard -Recurse -File -ErrorAction SilentlyContinue | Select-Object -First 80 FullName | Format-Table -AutoSize }
  'context' { Show-JsonSummary 'data\command-hub-037\unified-command-map.json' }
  'errors' { Get-ChildItem reports -Recurse -File -Filter '*error*.json' -ErrorAction SilentlyContinue | Select-Object -First 40 FullName | Format-Table -AutoSize }
  'docs' { if(Test-Path 'docs\HUMAN_COMMANDS.md'){Get-Content 'docs\HUMAN_COMMANDS.md'} else {Say 'WARN' 'missing=docs\HUMAN_COMMANDS.md'} }
  'dashboard' { Open-IfExists 'dashboard\human-start\index.html' }
  'mvp-open' { Open-IfExists 'dashboard\human-start\index.html' }
  'prompt' { Say 'OK' 'prompt_mode=prepare_only send_to_worker=false remote_execution=false next_stage=E38' }
  'inbox' { Get-ChildItem data,reports,receipts -Recurse -File -ErrorAction SilentlyContinue | Sort-Object LastWriteTime -Descending | Select-Object -First 40 LastWriteTime,FullName | Format-Table -AutoSize }
  'review' { Say 'OK' 'review_mode=human_decision_console_preview apply_executed=false next_stage=E39' }
  'approve' { Say 'WARN' 'approve_requires_human_gate=True apply_executed=false auto_apply=false controlled_apply_not_available_until_E40' }
  default { Say 'WARN' "unknown_command=$Command"; Say 'OK' 'available=daily,start,status,next,readiness,gates,artifacts,context,errors,docs,dashboard,mvp-open,prompt,inbox,review,approve' }
}

