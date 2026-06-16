param([ValidateSet("preview","open")] [string]$Mode="preview")
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$html='dashboard/dual-pc-development-workflow/index.html'
$report='reports/dual-pc-development-workflow/e05-dashboard-launcher-result.json'
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
if(-not(Test-Path $html)){throw "Dashboard no encontrado: $html"}
$opened=$false
$decision='PREVIEW_ONLY_NO_BROWSER_OPENED'
if($Mode -eq "open"){$ans=Read-Host "Escribe ABRIR para abrir dashboard en navegador";if($ans -eq "ABRIR"){Start-Process $html;$opened=$true;$decision="OPENED_BY_HUMAN_CONFIRMATION"}else{$decision="OPEN_CANCELLED_BY_HUMAN"}}
$result=[ordered]@{objective="ENGREMIAT_DUAL_PC_DEVELOPMENT_WORKFLOW_009B";stage="E05";mode=$Mode;dashboard=$html;browser_opened=$opened;decision=$decision;git_write=$false;remote_execution=$false;main_pc_touched=$false}
J $result $report
Write-Host ("OK dashboard="+$html+" mode="+$Mode+" browser_opened="+$opened+" decision="+$decision+" next=E06_CLOSE_DUAL_PC_WORKFLOW") -ForegroundColor Green
