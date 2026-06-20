$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Mode=if($args.Count -gt 0){[string]$args[0]}else{'preview'}
function J($o,[string]$p){$d=Split-Path -Parent $p;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$dash='dashboard/kanban-real-setup-012/index.html'
$report='reports/kanban-real-setup-012/e05-launcher-report.json'
if(-not(Test-Path $dash)){throw "Missing dashboard: $dash"}
$opened=$false
$decision='PREVIEW_ONLY_NO_BROWSER_OPENED'
if($Mode -eq 'open'){$ans=Read-Host 'Escribe ABRIR para abrir el dashboard';if($ans -eq 'ABRIR'){$opened=$true;Start-Process $dash;$decision='OPENED_BY_HUMAN_CONFIRMATION'}else{$decision='OPEN_CANCELLED_BY_HUMAN'}}
$result=[ordered]@{objective='ENGREMIAT_KANBAN_REAL_SETUP_012';stage='E05';mode=$Mode;dashboard=$dash;browser_opened=$opened;decision=$decision;remote_execution=$false;git_write=$false;auto_apply=$false;shared_repo_edit=$false;timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')}
J $result $report
Write-Host ('OK dashboard='+$dash+' mode='+$Mode+' browser_opened='+$opened+' decision='+$decision) -ForegroundColor Green
