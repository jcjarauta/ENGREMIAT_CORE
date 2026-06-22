param([string]$AuthorizationCode="")
$ErrorActionPreference="Stop"
$ProgressPreference="SilentlyContinue"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package="ENGREMIAT_SCREEN_MAINTENANCE_ROUTE_BINDING_001"
$stage="APPLY_ROUTE_BINDING_M_MAINTENANCE_PENDING_AUTH"
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
  if($AuthorizationCode -ne "AUTORIZO_BIND_M_MANTENIMIENTO_OPERATOR"){
    W "NO_GO authorization_required=True authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION required=AUTORIZO_BIND_M_MANTENIMIENTO_OPERATOR" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO" Cyan
    exit 0
  }
  $target=Join-Path $root "tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1"
  if(-not(Test-Path -LiteralPath $target)){throw "TARGET_NOT_FOUND path=$target"}
  $tokens=$null;$errs=$null;[System.Management.Automation.Language.Parser]::ParseFile($target,[ref]$tokens,[ref]$errs)|Out-Null
  if($errs.Count -gt 0){throw "TARGET_PARSE_BEFORE_FAIL line=$($errs[0].Extent.StartLineNumber) msg=$($errs[0].Message)"}
  $lines=Get-Content -LiteralPath $target -Encoding UTF8
  $raw=($lines -join [Environment]::NewLine)
  if($raw -notmatch "function\s+Invoke-EngremiatHumanMaintenanceCard"){throw "HELPER_NOT_PRESENT"}
  if($raw -match "ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN"){W "OK route_binding_already_present target=$target" Green;W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan;exit 0}
  $idx=-1;$varName=""
  for($i=0;$i -lt $lines.Count;$i++){
    $m=[regex]::Match($lines[$i],"^\s*\$(\w+)\s*=\s*Read-Host\b")
    if($m.Success){$idx=$i;$varName=$m.Groups[1].Value;break}
  }
  if($idx -lt 0){throw "NO_SAFE_READHOST_BINDING_POINT_FOUND"}
  $indent=([regex]::Match($lines[$idx],"^(\s*)")).Groups[1].Value
  $block=@(
    "$indent# ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN",
    "$indent" + 'if($' + $varName + ' -in @("m","mant","mantenimiento")){',
    "$indent  " + 'Invoke-EngremiatHumanMaintenanceCard -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"',
    "$indent  " + 'continue',
    "$indent" + '}',
    "$indent# ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END"
  )
  $newLines=New-Object System.Collections.Generic.List[string]
  for($j=0;$j -lt $lines.Count;$j++){
    $newLines.Add($lines[$j])|Out-Null
    if($j -eq $idx){foreach($b in $block){$newLines.Add($b)|Out-Null}}
  }
  $candidate=($newLines -join [Environment]::NewLine)
  $tokens2=$null;$errs2=$null;[System.Management.Automation.Language.Parser]::ParseInput($candidate,[ref]$tokens2,[ref]$errs2)|Out-Null
  if($errs2.Count -gt 0){throw "CANDIDATE_PARSE_FAIL_NO_WRITE line=$($errs2[0].Extent.StartLineNumber) msg=$($errs2[0].Message)"}
  $backupDir=Join-Path $root "documents\screen-maintenance-route-binding\backups"
  New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
  $ts=Get-Date -Format "yyyyMMdd-HHmmss"
  $backup=Join-Path $backupDir ("Start-EngremiatDesktopOperator.before-route-binding-"+$ts+".ps1")
  Copy-Item -LiteralPath $target -Destination $backup -Force
  Set-Content -LiteralPath $target -Value $candidate -Encoding UTF8
  $tokens3=$null;$errs3=$null;[System.Management.Automation.Language.Parser]::ParseFile($target,[ref]$tokens3,[ref]$errs3)|Out-Null
  if($errs3.Count -gt 0){Copy-Item -LiteralPath $backup -Destination $target -Force;throw "TARGET_PARSE_AFTER_WRITE_FAIL_RESTORED line=$($errs3[0].Extent.StartLineNumber) msg=$($errs3[0].Message)"}
  $after=Get-Content -LiteralPath $target -Raw -Encoding UTF8
  if($after -notmatch "ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN"){throw "ROUTE_BINDING_MARKER_NOT_FOUND_AFTER_WRITE"}
  if($after -notmatch "Invoke-EngremiatHumanMaintenanceCard"){throw "ROUTE_BINDING_HELPER_CALL_NOT_FOUND_AFTER_WRITE"}
  $reportDir=Join-Path $root "reports\screen-maintenance-route-binding"
  New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
  $reportPath=Join-Path $reportDir ("apply-route-binding-m-maintenance-"+$ts+".json")
  $report=[ordered]@{schema="engremiat.route_binding_apply_report.v1";package_id=$package;stage=$stage;created_at=(Get-Date).ToString("s");status="PASS";authorization_status="EXPLICIT_AUTH_GRANTED";target=$target;backup=$backup;readhost_variable=$varName;route_binding_marker_present=$true;target_parse_ok=$true;real_execution=$false;system_mutation=$true;screen_mutation=$true;worker=$false;browser=$false;network=$false;git=$false;next="E05_SMOKE_ROUTE_BINDING_STATIC_VERIFY"}
  $report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $reportPath -Encoding UTF8
  W "OK route_binding_m_maintenance_applied target=$target readhost_variable=$varName backup=$backup" Green
  W "OK package_id=$package stage=$stage status=PASS authorization_status=EXPLICIT_AUTH_GRANTED report=$reportPath next=E05_SMOKE_ROUTE_BINDING_STATIC_VERIFY" Green
  W "ENGREMIAT_PACKAGE_END package=$package status=PASS" Cyan
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
