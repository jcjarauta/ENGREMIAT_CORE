param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [string]$InputFile='',
  [switch]$RunRecurrentModel,
  [switch]$OpenPrompt
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function CleanText($s){
  $x=[string]$s
  $x=$x -replace "`r",' '
  $x=$x -replace "`n",' '
  $x=$x.Trim()
  return $x
}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=OPENWEBUI_OPENCLAW_TO_DETECTED_INPUT_ADAPTER_RUN_002'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=CONVERT_THREAD_TO_DETECTED_INPUT operation=LOCAL_FILE_READ_WRITE risk=LOW mode=DRY_RUN no_exec=True openwebui_real=False openclaw_real=False obsidian_real=False timeout_seconds=90'

$base=Join-Path $Root 'docs\openwebui-openclaw-adapter'
$inputDir=Join-Path $base 'inputs'
$outputDir=Join-Path $base 'outputs'
$recurrentInputDir=Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model\inputs'
$reportDir=Join-Path $Root 'reports\openwebui-openclaw-adapter'
New-Item -ItemType Directory -Force -Path $inputDir,$outputDir,$recurrentInputDir,$reportDir | Out-Null

if(!$InputFile){
  $InputFile=Join-Path $inputDir 'openwebui-thread.sample.json'
}
if(!(Test-Path $InputFile)){
  LogLine "ERR input_missing=$InputFile" Red
  throw 'INPUT_MISSING'
}

$thread=Get-Content $InputFile -Raw | ConvertFrom-Json
foreach($field in @('thread_id','source','via','title','user_intent','assistant_summary','proposed_kind','priority','risk')){
  if(!$thread.PSObject.Properties.Name.Contains($field) -or [string]::IsNullOrWhiteSpace([string]$thread.$field)){
    LogLine "ERR missing_field=$field" Red
    throw 'BAD_THREAD_INPUT'
  }
}

$stamp=(Get-Date).ToString('yyyyMMdd-HHmmss')
$outFile=Join-Path $outputDir ("detected-input.from-openwebui-openclaw.$stamp.json")
$recurrentFile=Join-Path $recurrentInputDir ("detected-input.from-openwebui-openclaw.$stamp.json")

$evidenceText=''
if($thread.PSObject.Properties.Name.Contains('evidence')){
  $evidenceText=(@($thread.evidence) -join ' ')
}

$summary=(CleanText ($thread.user_intent + ' ' + $thread.assistant_summary + ' ' + $evidenceText))
if($summary.Length -gt 1200){$summary=$summary.Substring(0,1200)}

$detected=@(
  [pscustomobject]@{
    id='INPUT-OPENWEBUI-OPENCLAW-'+$stamp
    source='openclaw'
    upstream_source='openwebui'
    upstream_thread_id=[string]$thread.thread_id
    kind=[string]$thread.proposed_kind
    title=[string]$thread.title
    summary=$summary
    priority=[int]$thread.priority
    risk=[string]$thread.risk
    target_consumers=@($thread.target_consumers)
    mode='DRY_RUN'
    human_review_required=$true
    execution_allowed=$false
    native_kanban_write='disabled'
    obsidian_real_write='disabled'
  }
)

$detected | ConvertTo-Json -Depth 8 | Set-Content -Path $outFile -Encoding UTF8
Copy-Item $outFile $recurrentFile -Force

$adapterReport=Join-Path $reportDir ("adapter-run.$stamp.json")
[pscustomobject]@{
  package='OPENWEBUI_OPENCLAW_TO_DETECTED_INPUT_ADAPTER_RUN_002'
  created_at=(Get-Date).ToString('s')
  input=$InputFile
  output=$outFile
  recurrent_input=$recurrentFile
  detected_count=$detected.Count
  openwebui_real=$false
  openclaw_real=$false
  obsidian_real=$false
  mode='DRY_RUN'
  decision='GO_DETECTED_INPUT_READY'
  next='RUN_RECURRENT_CARD_REFRESH_MODEL_WITH_GENERATED_INPUT'
} | ConvertTo-Json -Depth 8 | Set-Content -Path $adapterReport -Encoding UTF8

if(!(Test-Path $outFile)){throw 'OUTPUT_MISSING'}
if(!(Test-Path $recurrentFile)){throw 'RECURRENT_INPUT_MISSING'}

LogLine "OK input=$InputFile" Green
LogLine "OK detected_input=$outFile" Green
LogLine "OK recurrent_input=$recurrentFile" Green
LogLine "OK report=$adapterReport" Green
LogLine 'DECISION=GO_DETECTED_INPUT_READY' Green

if($RunRecurrentModel){
  $runner=Join-Path $Root 'tools\kanban-local\Invoke-RecurrentCardRefreshModel.ps1'
  if(!(Test-Path $runner)){
    LogLine "ERR recurrent_runner_missing=$runner" Red
    throw 'RECURRENT_RUNNER_MISSING'
  }

  $args=@(
    '-NoProfile',
    '-ExecutionPolicy','Bypass',
    '-File',$runner,
    '-Root',$Root,
    '-InputFile',$recurrentFile
  )

  if($OpenPrompt){
    $args += '-OpenPrompt'
  }

  $tmpOut=Join-Path $reportDir ("recurrent-run.stdout.$stamp.txt")
  $tmpErr=Join-Path $reportDir ("recurrent-run.stderr.$stamp.txt")
  $p=Start-Process -FilePath 'powershell.exe' -ArgumentList $args -Wait -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr

  $stdout=''
  $stderr=''
  if(Test-Path $tmpOut){$stdout=Get-Content $tmpOut -Raw}
  if(Test-Path $tmpErr){$stderr=Get-Content $tmpErr -Raw}

  if($stdout){Write-Host $stdout}
  if($p.ExitCode -ne 0){
    if($stderr){Write-Host $stderr -ForegroundColor Red}
    LogLine "ERR recurrent_runner_exit=$($p.ExitCode)" Red
    throw 'RECURRENT_RUNNER_FAILED'
  }

  if($stderr){
    LogLine "WARN recurrent_stderr_present=$tmpErr" Yellow
  }

  LogLine 'OK recurrent_runner_executed=True' Green
}

LogLine 'NEXT=CLINE_REVIEW_GENERATED_INLINE_BATCH_OR_BUILD_OBSIDIAN_EXPORT_ADAPTER' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=CONVERT_THREAD_TO_DETECTED_INPUT status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=OPENWEBUI_OPENCLAW_TO_DETECTED_INPUT_ADAPTER_RUN_002'
