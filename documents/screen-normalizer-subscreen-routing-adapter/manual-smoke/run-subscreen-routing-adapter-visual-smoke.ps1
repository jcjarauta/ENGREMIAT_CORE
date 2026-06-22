$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function SaveText($Path,$Text){$dir=[System.IO.Path]::GetDirectoryName([string]$Path);if(-not [string]::IsNullOrWhiteSpace($dir)){[System.IO.Directory]::CreateDirectory($dir)|Out-Null};$enc=New-Object System.Text.UTF8Encoding($false);[System.IO.File]::WriteAllText([string]$Path,[string]$Text,$enc)}
$Package = 'ENGREMIAT_SCREEN_NORMALIZER_SUBSCREEN_ROUTING_ADAPTER_001'
$Adapter = 'C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1'
$ResultsJson = 'C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\manual-smoke\subscreen-routing-adapter-visual-smoke.manual.latest.json'
$ResultsTsv = 'C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\manual-smoke\subscreen-routing-adapter-visual-smoke.manual.latest.tsv'
$Screens = @('PROYECTOS','MEMORIA_DOCUMENTACION','CONTROL_ESTADO','LAUNCHERS_CONFIGURACION','OPERADOR_WORKERS','TARJETAS')
$Rows = @()
W "ENGREMIAT_PACKAGE_BEGIN package=$Package stage=RUN_MANUAL_VISUAL_SMOKE_FOR_ADAPTER" Cyan
W ""
W "Se abrira el adapter aislado. Prueba cada opcion 1..6." Yellow
W "Para cada pantalla comprueba: abre, vuelve, Enter refresca, ? ayuda, m mantenimiento, b/q salir." Yellow
W "Cuando termines el adapter, responde s/n por cada pantalla. Notas opcionales." Yellow
W ""
Read-Host "Enter para abrir adapter"
& powershell -NoProfile -ExecutionPolicy Bypass -File $Adapter
foreach($s in $Screens){
  W ""
  W ("VALIDACION VISUAL screen={0}" -f $s) Cyan
  $ok = Read-Host "PASS visual? s/n"
  $notes = Read-Host "Notas opcionales Enter=sin notas"
  $pass = ($ok -eq "s" -or $ok -eq "S" -or $ok -eq "si" -or $ok -eq "SI")
  $Rows += [pscustomobject]@{ screen_id=$s; visual_pass=$pass; answer=$ok; notes=$notes }
  $json = [pscustomobject]@{ schema="engremiat.subscreen_routing_adapter_visual_smoke_results.v1"; package_id=$Package; created_at=(Get-Date).ToString("s"); status="PARTIAL"; adapter=$Adapter; results=$Rows } | ConvertTo-Json -Depth 100
  SaveText $ResultsJson $json
  $tsvLines = @("screen_id`tvisual_pass`tanswer`tnotes")
  foreach($r in $Rows){$tsvLines += ("{0}`t{1}`t{2}`t{3}" -f $r.screen_id,$r.visual_pass,$r.answer,($r.notes -replace "`t"," " -replace "`r?`n"," "))}
  SaveText $ResultsTsv ($tsvLines -join [Environment]::NewLine)
  W ("OK partial_saved screen={0} total_saved={1}" -f $s,$Rows.Count) Green
}
$passed = @($Rows|Where-Object{$_.visual_pass}).Count
$total = $Rows.Count
$status = if($passed -eq $total){"PASS"}else{"WARN"}
$final = [pscustomobject]@{ schema="engremiat.subscreen_routing_adapter_visual_smoke_results.v1"; package_id=$Package; created_at=(Get-Date).ToString("s"); status=$status; adapter=$Adapter; total=$total; passed=$passed; results=$Rows; patch_existing_launchers=$false; registry_write=$false; migration_applied=$false; git=$false }
$json = $final | ConvertTo-Json -Depth 100
SaveText $ResultsJson $json
$tsvLines = @("screen_id`tvisual_pass`tanswer`tnotes")
foreach($r in $Rows){$tsvLines += ("{0}`t{1}`t{2}`t{3}" -f $r.screen_id,$r.visual_pass,$r.answer,($r.notes -replace "`t"," " -replace "`r?`n"," "))}
SaveText $ResultsTsv ($tsvLines -join [Environment]::NewLine)
W ("OK subscreen_routing_adapter_visual_smoke_done status={0} passed={1} total={2} json={3} tsv={4}" -f $status,$passed,$total,$ResultsJson,$ResultsTsv) Green
W "ENGREMIAT_PACKAGE_END package=$Package status=$status" Cyan