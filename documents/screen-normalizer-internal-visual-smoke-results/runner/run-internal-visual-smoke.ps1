$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Package="ENGREMIAT_SCREEN_NORMALIZER_INTERNAL_VISUAL_SMOKE_RESULTS_001"
$Stage="MANUAL_VISUAL_SMOKE_RUNNER_SAFE_SAVE"
$Root="C:\ENGREMIAT_CORE"
$RunnerDir=Join-Path $Root "documents\screen-normalizer-internal-visual-smoke-results\runner"
[System.IO.Directory]::CreateDirectory($RunnerDir)|Out-Null
$ResultsJson=Join-Path $RunnerDir "internal-visual-smoke-results.manual.latest.json"
$ResultsTsv=Join-Path $RunnerDir "internal-visual-smoke-results.manual.latest.tsv"
$Rows='
[{"screen_id":"PROYECTOS","title":"PROYECTOS","candidate":"C:\\ENGREMIAT_CORE\\documents\\screen-normalizer-internal-candidates-generation\\generated\\PROYECTOS.candidate.isolated.ps1","opened":false,"title_ok":false,"ruta_ok":false,"rol_ok":false,"estado_ok":false,"principio_ok":false,"enter_refresh_ok":false,"help_ok":false,"m_ok":false,"back_quit_ok":false,"isolated_notice_ok":false,"human_notes":"PENDING_MANUAL_VISUAL_SMOKE"},{"screen_id":"MEMORIA_DOCUMENTACION","title":"MEMORIA Y DOCUMENTACION","candidate":"C:\\ENGREMIAT_CORE\\documents\\screen-normalizer-internal-candidates-generation\\generated\\MEMORIA_DOCUMENTACION.candidate.isolated.ps1","opened":false,"title_ok":false,"ruta_ok":false,"rol_ok":false,"estado_ok":false,"principio_ok":false,"enter_refresh_ok":false,"help_ok":false,"m_ok":false,"back_quit_ok":false,"isolated_notice_ok":false,"human_notes":"PENDING_MANUAL_VISUAL_SMOKE"},{"screen_id":"CONTROL_ESTADO","title":"CONTROL Y ESTADO","candidate":"C:\\ENGREMIAT_CORE\\documents\\screen-normalizer-internal-candidates-generation\\generated\\CONTROL_ESTADO.candidate.isolated.ps1","opened":false,"title_ok":false,"ruta_ok":false,"rol_ok":false,"estado_ok":false,"principio_ok":false,"enter_refresh_ok":false,"help_ok":false,"m_ok":false,"back_quit_ok":false,"isolated_notice_ok":false,"human_notes":"PENDING_MANUAL_VISUAL_SMOKE"},{"screen_id":"LAUNCHERS_CONFIGURACION","title":"LAUNCHERS Y CONFIGURACION","candidate":"C:\\ENGREMIAT_CORE\\documents\\screen-normalizer-internal-candidates-generation\\generated\\LAUNCHERS_CONFIGURACION.candidate.isolated.ps1","opened":false,"title_ok":false,"ruta_ok":false,"rol_ok":false,"estado_ok":false,"principio_ok":false,"enter_refresh_ok":false,"help_ok":false,"m_ok":false,"back_quit_ok":false,"isolated_notice_ok":false,"human_notes":"PENDING_MANUAL_VISUAL_SMOKE"},{"screen_id":"OPERADOR_WORKERS","title":"OPERADOR Y WORKERS","candidate":"C:\\ENGREMIAT_CORE\\documents\\screen-normalizer-internal-candidates-generation\\generated\\OPERADOR_WORKERS.candidate.isolated.ps1","opened":false,"title_ok":false,"ruta_ok":false,"rol_ok":false,"estado_ok":false,"principio_ok":false,"enter_refresh_ok":false,"help_ok":false,"m_ok":false,"back_quit_ok":false,"isolated_notice_ok":false,"human_notes":"PENDING_MANUAL_VISUAL_SMOKE"},{"screen_id":"TARJETAS","title":"TARJETAS","candidate":"C:\\ENGREMIAT_CORE\\documents\\screen-normalizer-internal-candidates-generation\\generated\\TARJETAS.candidate.isolated.ps1","opened":false,"title_ok":false,"ruta_ok":false,"rol_ok":false,"estado_ok":false,"principio_ok":false,"enter_refresh_ok":false,"help_ok":false,"m_ok":false,"back_quit_ok":false,"isolated_notice_ok":false,"human_notes":"PENDING_MANUAL_VISUAL_SMOKE"}]
'|ConvertFrom-Json
function SaveText($Path,$Text){$dir=[System.IO.Path]::GetDirectoryName([string]$Path);if(-not [string]::IsNullOrWhiteSpace($dir)){[System.IO.Directory]::CreateDirectory($dir)|Out-Null};$enc=New-Object System.Text.UTF8Encoding($false);[System.IO.File]::WriteAllText([string]$Path,[string]$Text,$enc)}
function AskBool($label){$v=Read-Host "$label (s/n)";return ($v -match "^(s|si|sí|y|yes)$")}
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function SaveResults($Results){$passed=@($Results|Where-Object{$_.opened -and $_.title_ok -and $_.ruta_ok -and $_.rol_ok -and $_.estado_ok -and $_.principio_ok -and $_.enter_refresh_ok -and $_.help_ok -and $_.m_ok -and $_.back_quit_ok -and $_.isolated_notice_ok}).Count;$summary=[ordered]@{schema="engremiat.internal_visual_smoke_results.manual.v4";package_id=$Package;stage=$Stage;created_at=(Get-Date).ToString("s");status="PASS";results=$Results;passed_count=$passed;total_count=$Results.Count;patch_launchers=$false;registry_write=$false;migration_applied=$false;git=$false};SaveText $ResultsJson ($summary|ConvertTo-Json -Depth 100);$headers=@("screen_id","title","opened","title_ok","ruta_ok","rol_ok","estado_ok","principio_ok","enter_refresh_ok","help_ok","m_ok","back_quit_ok","isolated_notice_ok","candidate","human_notes");$lines=@(($headers -join "`t"));foreach($x in $Results){$lines += (($headers|ForEach-Object{[string]$x.$_}) -join "`t")};SaveText $ResultsTsv ($lines -join [Environment]::NewLine)}
W "ENGREMIAT_PACKAGE_BEGIN package=$Package stage=$Stage" Cyan
$results=@()
if(Test-Path -LiteralPath $ResultsJson){try{$old=Get-Content -LiteralPath $ResultsJson -Raw|ConvertFrom-Json;if($old.results){$results=@($old.results);W "RESUME partial_results=$($results.Count)" Yellow}}catch{W "WARN no se pudo reanudar resultados previos" Yellow}}
foreach($r in $Rows){
  if(@($results|Where-Object{$_.screen_id -eq "$($r.screen_id)"}).Count -gt 0){W "SKIP ya registrado: $($r.screen_id)" DarkGray;continue}
  Clear-Host
  W "SMOKE VISUAL: $($r.screen_id)" Cyan
  W "Se abrira candidato aislado. Cierra con b/q y vuelve aqui para registrar resultado." Yellow
  W "Notas es opcional: puedes pulsar Enter vacio." DarkGray
  W "$($r.candidate)" DarkGray
  Read-Host "Enter para abrir candidato" | Out-Null
  powershell -NoProfile -ExecutionPolicy Bypass -File "$($r.candidate)"
  $res=[ordered]@{screen_id="$($r.screen_id)";title="$($r.title)";candidate="$($r.candidate)";opened=(AskBool "opened");title_ok=(AskBool "title_ok");ruta_ok=(AskBool "ruta_ok");rol_ok=(AskBool "rol_ok");estado_ok=(AskBool "estado_ok");principio_ok=(AskBool "principio_ok");enter_refresh_ok=(AskBool "enter_refresh_ok");help_ok=(AskBool "help_ok");m_ok=(AskBool "m_ok");back_quit_ok=(AskBool "back_quit_ok");isolated_notice_ok=(AskBool "isolated_notice_ok");human_notes=(Read-Host "Notas opcionales, Enter vacio para omitir")}
  $results += $res
  SaveResults $results
  W "OK partial_saved screen=$($r.screen_id) total_saved=$($results.Count)" Green
  Start-Sleep -Milliseconds 600
}
$results=@($results)
SaveResults $results
$passed=@($results|Where-Object{$_.opened -and $_.title_ok -and $_.ruta_ok -and $_.rol_ok -and $_.estado_ok -and $_.principio_ok -and $_.enter_refresh_ok -and $_.help_ok -and $_.m_ok -and $_.back_quit_ok -and $_.isolated_notice_ok}).Count
W "OK manual_visual_smoke_results_saved passed=$passed total=$($results.Count) json=$ResultsJson tsv=$ResultsTsv" Green
W "ENGREMIAT_PACKAGE_END package=$Package status=PASS" Cyan