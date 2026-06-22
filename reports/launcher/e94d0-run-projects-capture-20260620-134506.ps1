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