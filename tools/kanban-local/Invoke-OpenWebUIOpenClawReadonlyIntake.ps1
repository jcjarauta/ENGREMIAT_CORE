param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [switch]$RunRecurrentModel,
  [switch]$OpenPrompt
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function CleanText($s){$x=[string]$s;$x=$x -replace "`r",' ';$x=$x -replace "`n",' ';return $x.Trim()}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=OPENWEBUI_OPENCLAW_READONLY_INTAKE_RUN_002'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=READONLY_FILE_INTAKE_CLEAN_QUEUE operation=LOCAL_FILE_READ_WRITE risk=LOW mode=READONLY no_exec=True openwebui_api=False openclaw_api=False timeout_seconds=90'

$base=Join-Path $Root 'docs\openwebui-openclaw-readonly-adapter'
$inbox=Join-Path $base 'inbox'
$processed=Join-Path $base 'processed'
$outbox=Join-Path $base 'detected-inputs'
$recurrentInputDir=Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model\inputs'
$reportDir=Join-Path $Root 'reports\openwebui-openclaw-readonly-adapter'
New-Item -ItemType Directory -Force -Path $inbox,$processed,$outbox,$recurrentInputDir,$reportDir | Out-Null

$files=Get-ChildItem $inbox -Filter '*.json' -File | Sort-Object LastWriteTime,Name
if($files.Count -lt 1){
  LogLine "WARN inbox_empty=$inbox" Yellow
  LogLine 'DECISION=NO_NEW_READONLY_INPUTS'
  LogLine 'NEXT=DROP_REAL_JSON_IN_SANDBOX_OR_READONLY_INBOX'
  LogLine 'ENGREMIAT_STEP_END step_id=READONLY_FILE_INTAKE_CLEAN_QUEUE status=PASS'
  LogLine 'ENGREMIAT_PACKAGE_END package=OPENWEBUI_OPENCLAW_READONLY_INTAKE_RUN_002'
  exit 0
}

$stamp=(Get-Date).ToString('yyyyMMdd-HHmmss')
$detectedItems=@()
$moved=@()

foreach($f in $files){
  $thread=Get-Content $f.FullName -Raw | ConvertFrom-Json
  foreach($field in @('thread_id','source','via','title','user_intent','assistant_summary','proposed_kind','priority','risk')){
    if(!$thread.PSObject.Properties.Name.Contains($field) -or [string]::IsNullOrWhiteSpace([string]$thread.$field)){
      LogLine "ERR missing_field=$field file=$($f.FullName)" Red
      throw 'BAD_THREAD_INPUT'
    }
  }

  $summary=CleanText ($thread.user_intent + ' ' + $thread.assistant_summary)
  if($summary.Length -gt 1400){$summary=$summary.Substring(0,1400)}

  $detectedItems += [pscustomobject]@{
    id='INPUT-READONLY-'+$stamp+'-'+('{0:d3}' -f ($detectedItems.Count+1))
    source='openclaw'
    upstream_source=[string]$thread.source
    upstream_thread_id=[string]$thread.thread_id
    kind=[string]$thread.proposed_kind
    title=[string]$thread.title
    summary=$summary
    priority=[int]$thread.priority
    risk=[string]$thread.risk
    target_consumers=@($thread.target_consumers)
    mode='READONLY_FILE_INTAKE_CLEAN_QUEUE'
    human_review_required=$true
    execution_allowed=$false
    native_kanban_write='disabled'
    obsidian_real_write='disabled'
    openwebui_api_called=$false
    openclaw_api_called=$false
  }

  $dest=Join-Path $processed ($stamp+'.'+$f.Name)
  Move-Item $f.FullName $dest -Force
  $moved += $dest
}

$outFile=Join-Path $outbox ("detected-input.readonly-intake.$stamp.json")
$recurrentFile=Join-Path $recurrentInputDir ("detected-input.readonly-intake.$stamp.json")
$detectedItems | ConvertTo-Json -Depth 8 | Set-Content -Path $outFile -Encoding UTF8
Copy-Item $outFile $recurrentFile -Force

$report=Join-Path $reportDir ("readonly-intake-run.$stamp.json")
[pscustomobject]@{
  package='OPENWEBUI_OPENCLAW_READONLY_INTAKE_RUN_002'
  created_at=(Get-Date).ToString('s')
  files_count=$files.Count
  moved_to_processed=$moved
  detected_input=$outFile
  recurrent_input=$recurrentFile
  detected_count=$detectedItems.Count
  openwebui_api_called=$false
  openclaw_api_called=$false
  execution_allowed=$false
  native_kanban_write='disabled'
  obsidian_real_write='disabled'
  queue_policy='move_processed_files_out_of_inbox'
  decision='GO_READONLY_INTAKE_DETECTED_INPUT_READY'
  next='RUN_RECURRENT_MODEL_OR_DROP_REAL_THREAD_JSON_IN_INBOX'
} | ConvertTo-Json -Depth 8 | Set-Content -Path $report -Encoding UTF8

LogLine "OK inbox=$inbox" Green
LogLine "OK files_count=$($files.Count)" Green
LogLine "OK moved_to_processed=$($moved.Count)" Green
LogLine "OK detected_input=$outFile" Green
LogLine "OK recurrent_input=$recurrentFile" Green
LogLine "OK report=$report" Green
LogLine 'DECISION=GO_READONLY_INTAKE_DETECTED_INPUT_READY' Green

if($RunRecurrentModel){
  $runner=Join-Path $Root 'tools\kanban-local\Invoke-RecurrentCardRefreshModel.ps1'
  if(!(Test-Path $runner)){throw 'RECURRENT_RUNNER_MISSING'}
  $args=@('-NoProfile','-ExecutionPolicy','Bypass','-File',$runner,'-Root',$Root,'-InputFile',$recurrentFile)
  if($OpenPrompt){$args += '-OpenPrompt'}
  $tmpOut=Join-Path $reportDir ("recurrent-run.stdout.$stamp.txt")
  $tmpErr=Join-Path $reportDir ("recurrent-run.stderr.$stamp.txt")
  $p=Start-Process -FilePath 'powershell.exe' -ArgumentList $args -Wait -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr
  if(Test-Path $tmpOut){$stdout=Get-Content $tmpOut -Raw;if($stdout){Write-Host $stdout}}
  if($p.ExitCode -ne 0){if(Test-Path $tmpErr){Write-Host (Get-Content $tmpErr -Raw) -ForegroundColor Red};throw 'RECURRENT_RUNNER_FAILED'}
  LogLine 'OK recurrent_runner_executed=True' Green
}

LogLine 'NEXT=DROP_NEXT_REAL_JSON_OR_REVIEW_INLINE_BATCH' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=READONLY_FILE_INTAKE_CLEAN_QUEUE status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=OPENWEBUI_OPENCLAW_READONLY_INTAKE_RUN_002'
