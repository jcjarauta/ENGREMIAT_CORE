param(
  [string]$Root='C:\ENGREMIAT_CORE',
  [switch]$RunRecurrentModel,
  [switch]$OpenPrompt
)

$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function LogLine($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}

LogLine 'ENGREMIAT_PACKAGE_BEGIN package=TOOL_LINKING_SANDBOX_INTAKE_RUN_002'
LogLine 'ENGREMIAT_STEP_BEGIN step_id=SANDBOX_TO_READONLY_INTAKE_CLEAN_QUEUE operation=LOCAL_FILE_MOVE_AND_RUN risk=LOW mode=READONLY no_exec=True timeout_seconds=120'

$sandboxInbox=Join-Path $Root 'runtime\tool-linking-sandbox\openclaw-openwebui-inbox'
$readonlyInbox=Join-Path $Root 'docs\openwebui-openclaw-readonly-adapter\inbox'
$archive=Join-Path $Root 'runtime\tool-linking-sandbox\archive'
$logs=Join-Path $Root 'runtime\tool-linking-sandbox\logs'
$reportDir=Join-Path $Root 'reports\tool-linking-sandbox'
New-Item -ItemType Directory -Force -Path $sandboxInbox,$readonlyInbox,$archive,$logs,$reportDir | Out-Null

$files=Get-ChildItem $sandboxInbox -Filter '*.json' -File | Sort-Object LastWriteTime,Name
if($files.Count -lt 1){
  LogLine "WARN sandbox_inbox_empty=$sandboxInbox" Yellow
  LogLine 'DECISION=NO_NEW_SANDBOX_INPUTS'
  LogLine 'NEXT=DROP_REAL_OPENWEBUI_OR_OPENCLAW_JSON_IN_SANDBOX_INBOX'
  LogLine 'ENGREMIAT_STEP_END step_id=SANDBOX_TO_READONLY_INTAKE_CLEAN_QUEUE status=PASS'
  LogLine 'ENGREMIAT_PACKAGE_END package=TOOL_LINKING_SANDBOX_INTAKE_RUN_002'
  exit 0
}

$stamp=(Get-Date).ToString('yyyyMMdd-HHmmss')
$moved=@()

foreach($f in $files){
  $txt=Get-Content $f.FullName -Raw
  try{$null=$txt|ConvertFrom-Json}catch{LogLine "ERR invalid_json=$($f.FullName)" Red;throw 'INVALID_JSON'}

  $dest=Join-Path $readonlyInbox ("sandbox.$stamp.$($f.Name)")
  Copy-Item $f.FullName $dest -Force
  if(!(Test-Path $dest)){throw 'COPY_TO_READONLY_INBOX_FAILED'}

  $arch=Join-Path $archive ("$stamp.$($f.Name)")
  Move-Item $f.FullName $arch -Force
  $moved += $arch
}

$intake=Join-Path $Root 'tools\kanban-local\Invoke-OpenWebUIOpenClawReadonlyIntake.ps1'
if(!(Test-Path $intake)){throw 'INTAKE_MISSING'}

$args=@('-NoProfile','-ExecutionPolicy','Bypass','-File',$intake,'-Root',$Root)
if($RunRecurrentModel){$args += '-RunRecurrentModel'}
if($OpenPrompt){$args += '-OpenPrompt'}

$tmpOut=Join-Path $logs ("readonly-intake.stdout.$stamp.txt")
$tmpErr=Join-Path $logs ("readonly-intake.stderr.$stamp.txt")
$p=Start-Process -FilePath 'powershell.exe' -ArgumentList $args -Wait -PassThru -NoNewWindow -RedirectStandardOutput $tmpOut -RedirectStandardError $tmpErr

if(Test-Path $tmpOut){$stdout=Get-Content $tmpOut -Raw;if($stdout){Write-Host $stdout}}
if($p.ExitCode -ne 0){if(Test-Path $tmpErr){Write-Host (Get-Content $tmpErr -Raw) -ForegroundColor Red};throw 'READONLY_INTAKE_FAILED'}

$report=Join-Path $reportDir ("tool-linking-sandbox-intake.$stamp.json")
[pscustomobject]@{
  package='TOOL_LINKING_SANDBOX_INTAKE_RUN_002'
  created_at=(Get-Date).ToString('s')
  files_count=$files.Count
  moved_to_archive=$moved
  openwebui_api_called=$false
  openclaw_api_called=$false
  execution_allowed=$false
  native_kanban_write='disabled'
  obsidian_real_write='disabled'
  queue_policy='move_sandbox_files_to_archive_after_copy'
  decision='GO_TOOL_LINKING_SANDBOX_INTAKE_READY'
  next='REVIEW_GENERATED_INLINE_BATCH_OR_DROP_NEXT_REAL_JSON'
} | ConvertTo-Json -Depth 8 | Set-Content -Path $report -Encoding UTF8

LogLine "OK files_count=$($files.Count)" Green
LogLine "OK moved_to_archive=$($moved.Count)" Green
LogLine "OK report=$report" Green
LogLine 'DECISION=GO_TOOL_LINKING_SANDBOX_INTAKE_READY' Green
LogLine 'NEXT=REVIEW_GENERATED_INLINE_BATCH_OR_DROP_NEXT_REAL_JSON' Magenta
LogLine 'ENGREMIAT_STEP_END step_id=SANDBOX_TO_READONLY_INTAKE_CLEAN_QUEUE status=PASS'
LogLine 'ENGREMIAT_PACKAGE_END package=TOOL_LINKING_SANDBOX_INTAKE_RUN_002'
