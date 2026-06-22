$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function Pause($m='Enter para continuar'){Read-Host $m | Out-Null}
function AskYN($m){while($true){$a=Read-Host $m;if($a -match "^(s|S|si|SI)$"){return $true};if($a -match "^(n|N|no|NO)$"){return $false};Write-Host "Responde s o n." -ForegroundColor Yellow}}
function SaveText($Path,$Text){$dir=[System.IO.Path]::GetDirectoryName([string]$Path);if(-not [string]::IsNullOrWhiteSpace($dir)){[System.IO.Directory]::CreateDirectory($dir)|Out-Null};$enc=New-Object System.Text.UTF8Encoding($false);[System.IO.File]::WriteAllText([string]$Path,[string]$Text,$enc)}
$Package='ENGREMIAT_SCREEN_NORMALIZER_SUBSCREEN_ROUTING_ADAPTER_001'
$ResultsJson='C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\guided-navigation-smoke\guided-subscreen-navigation-smoke.manual.latest.json'
$ResultsTsv='C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\guided-navigation-smoke\guided-subscreen-navigation-smoke.manual.latest.tsv'
$Screens=@(
  [pscustomobject]@{ id='PROYECTOS'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\PROYECTOS.candidate.isolated.ps1'; sha256='F56F1F3C73F22CFFD5F6E6E5FFF1CA87EA97B8282B69CB656B13A1E013E7F465' },
  [pscustomobject]@{ id='MEMORIA_DOCUMENTACION'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\MEMORIA_DOCUMENTACION.candidate.isolated.ps1'; sha256='CA09A41904F9C0FB923457DFC7BBEE8B1A7C05CD8668526915A3FED5F07A0C24' },
  [pscustomobject]@{ id='CONTROL_ESTADO'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\CONTROL_ESTADO.candidate.isolated.ps1'; sha256='72E585DAC556CBC0B903F1B109814250F56E3CEC44D072C8997F601BD0049FEB' },
  [pscustomobject]@{ id='LAUNCHERS_CONFIGURACION'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\LAUNCHERS_CONFIGURACION.candidate.isolated.ps1'; sha256='58608C17B1BCFDB421A6CF2122DA9F1CB6D79CFB2C92242217B8B6E294618F59' },
  [pscustomobject]@{ id='OPERADOR_WORKERS'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\OPERADOR_WORKERS.candidate.isolated.ps1'; sha256='25BFF4B6AD3252F4CC180F094D8F81732AA865007B5FEB0CF8471D947FFD9E35' },
  [pscustomobject]@{ id='TARJETAS'; path='C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\TARJETAS.candidate.isolated.ps1'; sha256='ADBACC220A4D00CE025211FD7436F08698913D42F1B6465DB0F731EAAAE6AD92' }
)
$Rows=@()
function Persist($status){
  $obj=[pscustomobject]@{schema="engremiat.guided_subscreen_navigation_smoke.v2";package_id=$Package;created_at=(Get-Date).ToString("s");status=$status;total=$Rows.Count;passed=@($Rows|Where-Object{$_.visual_pass}).Count;results=$Rows;patch_existing_launchers=$false;registry_write=$false;migration_applied=$false;git=$false}
  SaveText $ResultsJson ($obj|ConvertTo-Json -Depth 100)
  $tsv=@("screen_id`topened`tvisual_pass`tadapter_return_ok`tenter_ok`thelp_ok`tm_ok`texit_ok`tanswer`tnotes")
  foreach($r in $Rows){$tsv+=("{0}`t{1}`t{2}`t{3}`t{4}`t{5}`t{6}`t{7}`t{8}`t{9}" -f $r.screen_id,$r.opened,$r.visual_pass,$r.adapter_return_ok,$r.enter_ok,$r.help_ok,$r.m_ok,$r.exit_ok,$r.answer,($r.notes -replace "`t"," " -replace "`r?`n"," "))}
  SaveText $ResultsTsv ($tsv -join [Environment]::NewLine)
}

function Show-GlobalGuide {
  Clear-Host
  W "==== ENGREMIAT PRUEBA GUIADA DE SUBPANTALLAS ====" Cyan
  W "Objetivo: comprobar navegacion real de cada pantalla normalizada." Yellow
  W ""
  W "IMPORTANTE PARA EL HUMANO" Cyan
  W "1. Se abrira una subpantalla concreta." Gray
  W "2. Dentro de esa subpantalla NO valides todavia." Gray
  W "3. Primero prueba estos comandos en la pantalla principal:" Gray
  W "   Enter vacio = refrescar/redibujar." Gray
  W "   ? = ayuda. Si entras en ayuda, vuelve con Enter vacio." Gray
  W "   m = mantenimiento/dry-run. Si entras, vuelve segun indique." Gray
  W "   b o q = salir y volver a este runner." Gray
  W "4. Solo cuando vuelvas aqui, responde s/n a cada pregunta." Gray
  W ""
  W "Regla: si escribes m dentro de una pantalla de AYUDA que solo pide Enter, NO cuenta como fallo." DarkGray
  W "La prueba de m debe hacerse en la pantalla principal de la subpantalla." DarkGray
  W ""
  W "No toca launcher general, registry ni git." Yellow
}

function Show-ScreenGuide($s,$idx,$total){
  Clear-Host
  W "==== PRUEBA $idx/$total ====" Cyan
  W ("SUBPANTALLA: {0}" -f $s.id) Yellow
  W ("PATH: {0}" -f $s.path) DarkGray
  W ""
  W "ANTES DE ABRIR, RECUERDA EL ORDEN:" Cyan
  W "A) Observa si aparece header/ruta/rol/estado/principio/indicadores." Gray
  W "B) Pulsa Enter vacio: debe refrescar o redibujar." Gray
  W "C) Escribe ?: debe abrir ayuda. En ayuda, pulsa Enter vacio para volver." Gray
  W "D) En la pantalla principal, escribe m: debe abrir mantenimiento o dry-run." Gray
  W "E) Vuelve de mantenimiento." Gray
  W "F) Escribe b o q: debe volver a este runner." Gray
  W ""
  W "NO respondas validacion hasta estar de vuelta en este runner." Yellow
}

Show-GlobalGuide
Pause "Enter para empezar la prueba guiada"
for($i=0;$i -lt $Screens.Count;$i++){
  $s=$Screens[$i]
  Show-ScreenGuide $s ($i+1) $Screens.Count
  Pause "Enter para abrir esta subpantalla"
  $opened=$false
  try { & powershell -NoProfile -ExecutionPolicy Bypass -File $s.path; $opened=$true } catch { W ("WARN subscreen_error screen={0} error={1}" -f $s.id,$_.Exception.Message) Yellow }
  Clear-Host
  W "==== VALIDACION DESPUES DE VOLVER AL RUNNER ====" Cyan
  W ("screen={0}" -f $s.id) Yellow
  W "Responde segun lo que hayas probado EN LA PANTALLA PRINCIPAL." DarkGray
  W ""
  $visual=AskYN "1) La pantalla se abrio y era legible/normalizada? s/n"
  $enter=AskYN "2) Enter vacio refresco/redibujo? s/n"
  $help=AskYN "3) ? abrio ayuda y pudiste volver con Enter? s/n"
  $maint=AskYN "4) m en pantalla principal abrio mantenimiento/dry-run? s/n"
  $exit=AskYN "5) b/q salio y volviste al runner? s/n"
  $back=AskYN "6) El runner siguio estable despues de volver? s/n"
  $notes=Read-Host "Notas opcionales Enter=sin notas"
  $pass=($visual -and $enter -and $help -and $maint -and $exit -and $back)
  $Rows += [pscustomobject]@{screen_id=$s.id;path=$s.path;opened=$opened;visual_pass=$pass;adapter_return_ok=$back;enter_ok=$enter;help_ok=$help;m_ok=$maint;exit_ok=$exit;answer=if($pass){"s"}else{"n"};notes=$notes}
  Persist "PARTIAL"
  W ("OK partial_saved screen={0} visual_pass={1} total_saved={2}" -f $s.id,$pass,$Rows.Count) Green
  Pause "Enter para continuar con la siguiente subpantalla"
}
$passed=@($Rows|Where-Object{$_.visual_pass}).Count
$total=$Rows.Count
$status=if($passed -eq $total){"PASS"}else{"WARN"}
Persist $status
W ("OK guided_subscreen_navigation_smoke_done status={0} passed={1} total={2} json={3} tsv={4}" -f $status,$passed,$total,$ResultsJson,$ResultsTsv) Green
W "ENGREMIAT_PACKAGE_END package=$Package status=$status" Cyan