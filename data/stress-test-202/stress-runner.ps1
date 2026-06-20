param(
  [ValidateSet('Plan','Run')]
  [string]$Mode = 'Plan',
  [string]$Root = (Get-Location).Path,
  [string]$BenchmarkRunnerPath = (Join-Path (Get-Location).Path 'data\stress-test-201\benchmark-runner.json'),
  [string]$LauncherPath = (Join-Path (Get-Location).Path 'data\real-execution-launcher-186\real-execution-launcher.ps1')
)

$ErrorActionPreference='Stop'

function Log([string]$m){ Write-Host ('[STRESS-RUNNER] ' + $m) }
function ReadJson([string]$Path){
  if(Test-Path $Path){
    try{ return Get-Content $Path -Raw | ConvertFrom-Json -ErrorAction Stop } catch { return $null }
  }
  return $null
}
function WriteJson([string]$Path,[object]$Obj){
  $dir=Split-Path -Parent $Path
  if($dir -and -not (Test-Path $dir)){ New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  $Obj | ConvertTo-Json -Depth 100 | Set-Content -Encoding UTF8 $Path
}
function GetProp([object]$Obj,[string]$Name,[string]$Fallback=''){
  if($null -eq $Obj){ return $Fallback }
  if($Obj.PSObject.Properties.Name -contains $Name){
    $v=$Obj.$Name
    if($null -ne $v -and ([string]$v).Length -gt 0){ return [string]$v }
  }
  return $Fallback
}
function ShowLoad([string]$Label,[int]$Seconds=1){
  $spin=@('|','/','-','\')
  $sw=[Diagnostics.Stopwatch]::StartNew()
  $i=0
  while($sw.Elapsed.TotalSeconds -lt $Seconds){
    Write-Host -NoNewline ("`r" + $Label + " " + $spin[$i % 4] + " ")
    [Console]::Out.Flush()
    Start-Sleep -Milliseconds 250
    $i++
  }
  Write-Host ''
}
function NewRoundRequest([int]$Index,[object]$Round){
  $roundDir=Join-Path $Root ('data\stress-test-202\round-' + ('{0:000}' -f $Index))
  if(-not (Test-Path $roundDir)){ New-Item -ItemType Directory -Force -Path $roundDir | Out-Null }

  $requestPath=Join-Path $roundDir 'launcher-request.json'
  $request=[ordered]@{
    objective_id='DEFINE_EXPONENTIAL_OFFICIAL_INGRESS_STRESS_TEST_MVP_200_203'
    stage='E202'
    mode='Run'
    candidate_task_id='OFFICIAL_ENTRY_SAMPLE_001'
    candidate_title='Sample plan to validate the official ingress'
    official_entry_reference='DEFINE_UNIFIED_ENTRYPOINT_OFFICIAL_INGRESS_MVP'
    plan_intake_reference='DEFINE_PLAN_INTAKE_STANDARD_MVP_188_191'
    launcher_reference='DEFINE_REAL_EXECUTION_LAUNCHER_REUSABLE_MVP_184_187'
    round_index=$Index
    round_label=(GetProp $Round 'label' ('round-' + $Index))
    planned_plans=[int](GetProp $Round 'plans' '1')
    round_mode=(GetProp $Round 'mode' 'Run')
    requested_by='human'
    local_only=$true
    external_network=$false
    git_write=$false
    kanban_real_write=$false
    cline_real_write=$false
    auto_apply=$false
    destructive_actions=$false
    human_authorization_required=$true
    created_at=(Get-Date).ToString('o')
  }
  WriteJson $requestPath $request
  return $requestPath
}

if(-not (Test-Path $BenchmarkRunnerPath)){
  throw ('Missing benchmark runner definition: ' + $BenchmarkRunnerPath)
}
if(-not (Test-Path $LauncherPath)){
  throw ('Missing launcher script: ' + $LauncherPath)
}

$runnerDef=ReadJson $BenchmarkRunnerPath
if($null -eq $runnerDef){
  throw ('Invalid benchmark runner JSON: ' + $BenchmarkRunnerPath)
}

$rounds=@()
if($runnerDef.PSObject.Properties.Name -contains 'rounds' -and $runnerDef.rounds){
  $rounds=@($runnerDef.rounds)
} else {
  $rounds=@(
    [ordered]@{ round=1; label='baseline'; plans=1; mode='Run' },
    [ordered]@{ round=2; label='repeat'; plans=2; mode='Run' },
    [ordered]@{ round=3; label='growth'; plans=4; mode='Run' },
    [ordered]@{ round=4; label='stress'; plans=8; mode='Run' }
  )
}

$planSummary=[ordered]@{
  objective_id='DEFINE_EXPONENTIAL_OFFICIAL_INGRESS_STRESS_TEST_MVP_200_203'
  stage='E202'
  mode=$Mode
  benchmark_runner_path=$BenchmarkRunnerPath
  launcher_path=$LauncherPath
  rounds_count=$rounds.Count
  round_labels=@($rounds | ForEach-Object { GetProp $_ 'label' 'round' })
  created_at=(Get-Date).ToString('o')
}

$planPath=Join-Path $Root 'data\stress-test-202\stress-plan.json'
WriteJson $planPath $planSummary
Log ('PLAN written -> ' + $planPath)

if($Mode -eq 'Plan'){
  Log 'Plan mode finished. No rounds executed.'
  return
}

foreach($round in $rounds){
  $roundIndex = 1
  if($round.PSObject.Properties.Name -contains 'round'){ $roundIndex = [int]$round.round }

  $roundLabel = GetProp $round 'label' ('round-' + $roundIndex)
  $plannedPlans = [int](GetProp $round 'plans' '1')
  Log ('ROUND_START index=' + $roundIndex + ' label=' + $roundLabel + ' plans=' + $plannedPlans)

  $requestPath = NewRoundRequest -Index $roundIndex -Round $round

  ShowLoad ('LOADING ROUND ' + $roundIndex) 2

  & powershell.exe -NoProfile -ExecutionPolicy Bypass -File $LauncherPath -RequestPath $requestPath -Mode Run

  $roundReport=[ordered]@{
    objective_id='DEFINE_EXPONENTIAL_OFFICIAL_INGRESS_STRESS_TEST_MVP_200_203'
    stage='E202'
    round_index=$roundIndex
    round_label=$roundLabel
    planned_plans=$plannedPlans
    request_path=$requestPath
    launcher_mode='Run'
    status='EXECUTED'
    created_at=(Get-Date).ToString('o')
  }
  $roundReportPath=Join-Path (Split-Path -Parent $requestPath) 'stress-round-report.json'
  WriteJson $roundReportPath $roundReport
  Log ('ROUND_END index=' + $roundIndex + ' report=' + $roundReportPath)
}

Log 'All rounds completed.'
