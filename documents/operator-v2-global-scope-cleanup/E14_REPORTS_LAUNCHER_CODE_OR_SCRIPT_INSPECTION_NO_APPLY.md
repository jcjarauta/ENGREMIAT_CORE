# E14 Reports Launcher Code Or Script Inspection No Apply

Estado: PASS
Apply changes: NO
Delete files: NO
Commit: NO
Push: NO

## Conteo
- Code/script items: 
5

## By kind
- LOCAL_SCRIPT_REVIEW: 5

## Items

### reports/launcher/e72-probe-projects-writer-signal-20260620-122028.ps1
- kind: LOCAL_SCRIPT_REVIEW
- exists: True
- size: 8801
- modified: 2026-06-20T12:20:28
- status: ?? reports/launcher/e72-probe-projects-writer-signal-20260620-122028.ps1

```text
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectsRoot=Join-Path $Core "projects"
$ReportsDir=Join-Path $Core "reports\launcher"
$WorkerSyncDir=Join-Path $Core "documents\worker-sync"
function UX([string]$m,[string]$role="info"){ $c="Gray"; if($role -eq "title"){$c="Cyan"}elseif($role -eq "section"){$c="Yellow"}elseif($role -eq "ok"){$c="Green"}elseif($role -eq "warn"){$c="Yellow"}elseif($role -eq "err"){$c="Red"}elseif($role -eq "muted"){$c="DarkGray"}; try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m} }
function Header([string]$title,[string]$route,[string]$role,[string]$principle){Clear-Host;UX ("==== "+$title+" ====") "title";UX ("Ruta: "+$route) "muted";UX ("Rol: "+$role) "info";UX ("Principio: "+$principle) "muted";UX "" "info"}
function Short($s,[int]$n){$t=[string]$s;if([string]::IsNullOrWhiteSpace($t)){$t="-"};if($t.Length -le $n){return $t};if($n -le 3){return $t.Substring(0,$n)};return $t.Substring(0,$n-3)+"..."}
function Bar([int]$score,[string]$worker){$v=[Math]::Max(0,[Math]::Min(100,$score));$filled=[int][Math]::Floor($v/10);if($filled -gt 10){$filled=10};$empty=10-$filled;$core=("#"*$filled)+("-"*$empty);if($worker -eq "RUNNING" -and $filled -lt 10){$core=("#"*$filled)+">"+("-"*([Math]::Max(0,$empty-1)))};return "["+$core+"]"}
```

### reports/launcher/e72b-probe-heartbeat-dryrun-render-20260620-122118.ps1
- kind: LOCAL_SCRIPT_REVIEW
- exists: True
- size: 8806
- modified: 2026-06-20T12:21:18
- status: ?? reports/launcher/e72b-probe-heartbeat-dryrun-render-20260620-122118.ps1

```text
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectsRoot=Join-Path $Core "projects"
$ReportsDir=Join-Path $Core "reports\launcher"
$WorkerSyncDir=Join-Path $Core "documents\worker-sync"
function UX([string]$m,[string]$role="info"){ $c="Gray"; if($role -eq "title"){$c="Cyan"}elseif($role -eq "section"){$c="Yellow"}elseif($role -eq "ok"){$c="Green"}elseif($role -eq "warn"){$c="Yellow"}elseif($role -eq "err"){$c="Red"}elseif($role -eq "muted"){$c="DarkGray"}; try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m} }
function Header([string]$title,[string]$route,[string]$role,[string]$principle){Clear-Host;UX ("==== "+$title+" ====") "title";UX ("Ruta: "+$route) "muted";UX ("Rol: "+$role) "info";UX ("Principio: "+$principle) "muted";UX "" "info"}
function Short($s,[int]$n){$t=[string]$s;if([string]::IsNullOrWhiteSpace($t)){$t="-"};if($t.Length -le $n){return $t};if($n -le 3){return $t.Substring(0,$n)};return $t.Substring(0,$n-3)+"..."}
function Bar([int]$score,[string]$worker){$v=[Math]::Max(0,[Math]::Min(100,$score));$filled=[int][Math]::Floor($v/10);if($filled -gt 10){$filled=10};$empty=10-$filled;$core=("#"*$filled)+("-"*$empty);if($worker -eq "RUNNING" -and $filled -lt 10){$core=("#"*$filled)+">"+("-"*([Math]::Max(0,$empty-1)))};return "["+$core+"]"}
```

### reports/launcher/e76-probe-projects-event-sequence-done-20260620-123113.ps1
- kind: LOCAL_SCRIPT_REVIEW
- exists: True
- size: 8970
- modified: 2026-06-20T12:31:13
- status: ?? reports/launcher/e76-probe-projects-event-sequence-done-20260620-123113.ps1

```text
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectsRoot=Join-Path $Core "projects"
$ReportsDir=Join-Path $Core "reports\launcher"
$WorkerSyncDir=Join-Path $Core "documents\worker-sync"
function UX([string]$m,[string]$role="info"){ $c="Gray"; if($role -eq "title"){$c="Cyan"}elseif($role -eq "section"){$c="Yellow"}elseif($role -eq "ok"){$c="Green"}elseif($role -eq "warn"){$c="Yellow"}elseif($role -eq "err"){$c="Red"}elseif($role -eq "muted"){$c="DarkGray"}; try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m} }
function Header([string]$title,[string]$route,[string]$role,[string]$principle){Clear-Host;UX ("==== "+$title+" ====") "title";UX ("Ruta: "+$route) "muted";UX ("Rol: "+$role) "info";UX ("Principio: "+$principle) "muted";UX "" "info"}
function Short($s,[int]$n){$t=[string]$s;if([string]::IsNullOrWhiteSpace($t)){$t="-"};if($t.Length -le $n){return $t};if($n -le 3){return $t.Substring(0,$n)};return $t.Substring(0,$n-3)+"..."}
function Bar([int]$score,[string]$worker){$v=[Math]::Max(0,[Math]::Min(100,$score));$filled=[int][Math]::Floor($v/10);if($filled -gt 10){$filled=10};$empty=10-$filled;$core=("#"*$filled)+("-"*$empty);if($worker -eq "RUNNING" -and $filled -lt 10){$core=("#"*$filled)+">"+("-"*([Math]::Max(0,$empty-1)))};return "["+$core+"]"}
```

### reports/launcher/e78b-probe-off-on-20260620-123543.ps1
- kind: LOCAL_SCRIPT_REVIEW
- exists: True
- size: 9423
- modified: 2026-06-20T12:35:43
- status: ?? reports/launcher/e78b-probe-off-on-20260620-123543.ps1

```text
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectsRoot=Join-Path $Core "projects"
$ReportsDir=Join-Path $Core "reports\launcher"
$WorkerSyncDir=Join-Path $Core "documents\worker-sync"
function UX([string]$m,[string]$role="info"){ $c="Gray"; if($role -eq "title"){$c="Cyan"}elseif($role -eq "section"){$c="Yellow"}elseif($role -eq "ok"){$c="Green"}elseif($role -eq "warn"){$c="Yellow"}elseif($role -eq "err"){$c="Red"}elseif($role -eq "muted"){$c="DarkGray"}; try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m} }
function Header([string]$title,[string]$route,[string]$role,[string]$principle){Clear-Host;UX ("==== "+$title+" ====") "title";UX ("Ruta: "+$route) "muted";UX ("Rol: "+$role) "info";UX ("Principio: "+$principle) "muted";UX "" "info"}
function Short($s,[int]$n){$t=[string]$s;if([string]::IsNullOrWhiteSpace($t)){$t="-"};if($t.Length -le $n){return $t};if($n -le 3){return $t.Substring(0,$n)};return $t.Substring(0,$n-3)+"..."}
function Bar([int]$score,[string]$worker){$v=[Math]::Max(0,[Math]::Min(100,$score));$filled=[int][Math]::Floor($v/10);if($filled -gt 10){$filled=10};$empty=10-$filled;$core=("#"*$filled)+("-"*$empty);if($worker -eq "RUNNING" -and $filled -lt 10){$core=("#"*$filled)+">"+("-"*([Math]::Max(0,$empty-1)))};return "["+$core+"]"}
```

### reports/launcher/e94d0-run-projects-capture-20260620-134506.ps1
- kind: LOCAL_SCRIPT_REVIEW
- exists: True
- size: 976
- modified: 2026-06-20T13:45:06
- status: ?? reports/launcher/e94d0-run-projects-capture-20260620-134506.ps1

```text
$ErrorActionPreference='Continue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core='C:\ENGREMIAT_CORE'
$Projects=Join-Path $Core 'tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1'
$Diag='
C:\ENGREMIAT_CORE\reports\launcher\e94d0-projects-error-capture-20260620-134506.txt
'
function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
Start-Transcript -Path $Diag -Force|Out-Null
try{W '==== CAPTURA PROYECTOS ====' Cyan;W 'Reproduce el error. Si entras en una pantalla, usa b/q para volver o salir.' DarkGray;& powershell -NoProfile -ExecutionPolicy Bypass -File $Projects;if($LASTEXITCODE -ne 0){W ('LASTEXITCODE='+$LASTEXITCODE) Red}}catch{W ('ERR: '+$_.Exception.Message) Red;W ($_.ScriptStackTrace) DarkRed}finally{try{Stop-Transcript|Out-Null}catch{};W ('CAPTURA_GUARDADA=' + $Diag) Green;W 'Copia el contenido del TXT o pega esta ruta si no puedes abrirlo.' Yellow;Read-Host 'Enter para cerrar captura'|Out-Null}
```

## Decision
PREPARE_SEPARATE_CODE_OR_SCRIPT_COMMIT_PACKET_AFTER_REVIEW

## Siguiente
E15_PREPARE_REPORTS_LAUNCHER_CODE_OR_SCRIPT_COMMIT_PACKET_NO_EXECUTE
