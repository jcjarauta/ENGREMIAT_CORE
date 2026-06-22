param(
  [Parameter(Mandatory=$true)][string]$Package,
  [Parameter(Mandatory=$true)][string]$Stage,
  [Parameter(Mandatory=$true)][string]$Step,
  [Parameter(Mandatory=$true)][ValidateSet('PASS','WARN','FAIL','BLOCKED','PAUSED')][string]$Status,
  [Parameter(Mandatory=$false)][string]$Report = '',
  [Parameter(Mandatory=$false)][string]$Next = '',
  [Parameter(Mandatory=$false)][int]$Readiness = 30,
  [Parameter(Mandatory=$false)][string]$Summary = '' 
)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function TS($v){if($null -eq $v){return ''};return (($v | Out-String).Trim())}
function RunGit([string]$gitArgs){$psi=New-Object System.Diagnostics.ProcessStartInfo;$psi.FileName='cmd.exe';$psi.Arguments='/c git '+$gitArgs;$psi.RedirectStandardOutput=$true;$psi.RedirectStandardError=$true;$psi.UseShellExecute=$false;$p=[System.Diagnostics.Process]::Start($psi);$out=$p.StandardOutput.ReadToEnd();$err=$p.StandardError.ReadToEnd();$p.WaitForExit();[pscustomobject]@{ExitCode=$p.ExitCode;Stdout=(TS $out);Stderr=(TS $err)}}
$Root=(Get-Location).Path
$DataDir=Join-Path $Root 'data/operator-v2-self-state-sync'
$DocDir=Join-Path $Root 'documents/operator-v2-self-state-sync'
New-Item -ItemType Directory -Force -Path $DataDir,$DocDir | Out-Null
$RegistryPath=Join-Path $DataDir 'v2-state.registry.json'
$LatestPath=Join-Path $DataDir 'v2-state.latest.json'
$EventsPath=Join-Path $DataDir 'v2-state.events.jsonl'
$IndexPath=Join-Path $DocDir 'V2_STATE_INDEX.md'
$Head=RunGit 'rev-parse --short HEAD'
$Sync=RunGit 'rev-list --left-right --count origin/main...HEAD'
$GitStatus=RunGit 'status --short'
if($Head.ExitCode -ne 0 -or (TS $Head.Stdout) -match '^usage: git'){throw 'git_head_invalid'}
if($Sync.ExitCode -ne 0 -or (TS $Sync.Stdout) -match '^usage: git'){throw 'git_sync_invalid'}
$GitState=[ordered]@{head=(TS $Head.Stdout);rev_sync=(TS $Sync.Stdout);tree_clean=([string]::IsNullOrWhiteSpace((TS $GitStatus.Stdout)));status_short=(TS $GitStatus.Stdout);push_executed=$false}
if(Test-Path $RegistryPath){$Registry=Get-Content -LiteralPath $RegistryPath -Raw | ConvertFrom-Json}else{$Registry=[pscustomobject]@{schema='ENGREMIAT_OPERATOR_V2_STATE_REGISTRY_V1';objectives=@();stages=@();evidence=@();decisions=@();risks=@();next_action='';git_state=$GitState}}
$Now=(Get-Date).ToString('s')
$Event=[ordered]@{ts=$Now;event='V2_STATE_UPDATE';package=$Package;stage=$Stage;step=$Step;status=$Status;report=$Report;next=$Next;readiness=$Readiness;summary=$Summary;head=$GitState.head;rev_sync=$GitState.rev_sync;tree_clean=$GitState.tree_clean}
$Latest=[ordered]@{schema='ENGREMIAT_OPERATOR_V2_STATE_LATEST_V1';updated_at=$Now;active_objective=[ordered]@{id=$Package;title='Operador V2 self-state sync';status=if($Status -eq 'PASS'){'ACTIVE'}else{$Status};purpose='Mantener V2 actualizado desde cada bloque cerrado.';active_stage=$Stage;readiness=$Readiness;next_action=$Next};last_stage=$Stage;last_step=$Step;last_status=$Status;last_report=$Report;readiness=$Readiness;git_state=$GitState;next_action=$Next;human_summary=$Summary}
$Registry.updated_at=$Now
$Registry.git_state=$GitState
$Registry.next_action=$Next
if(-not $Registry.PSObject.Properties.Name.Contains('events_count')){$Registry | Add-Member -NotePropertyName events_count -NotePropertyValue 0 -Force}
$Registry.events_count=[int]$Registry.events_count+1
if(-not $Registry.PSObject.Properties.Name.Contains('last_event')){$Registry | Add-Member -NotePropertyName last_event -NotePropertyValue $Event -Force}else{$Registry.last_event=$Event}
$Registry | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $RegistryPath -Encoding UTF8
$Latest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $LatestPath -Encoding UTF8
($Event | ConvertTo-Json -Compress -Depth 8) | Add-Content -LiteralPath $EventsPath -Encoding UTF8
$Index=@('# V2 STATE INDEX','','Estado vivo del Operador V2.','','## Ultima actualizacion','- Package: '+$Package,'- Stage: '+$Stage,'- Step: '+$Step,'- Status: '+$Status,'- Readiness: '+$Readiness,'- Head: '+$GitState.head,'- Rev sync: '+$GitState.rev_sync,'- Tree clean: '+$GitState.tree_clean,'','## Resumen humano',$Summary,'','## Report',$Report,'','## NEXT',$Next)
$Index | Set-Content -LiteralPath $IndexPath -Encoding UTF8
$null=Get-Content -LiteralPath $RegistryPath -Raw | ConvertFrom-Json
$null=Get-Content -LiteralPath $LatestPath -Raw | ConvertFrom-Json
[pscustomobject]@{status='PASS';registry=$RegistryPath;latest=$LatestPath;events=$EventsPath;index=$IndexPath;next=$Next} | ConvertTo-Json -Depth 5
