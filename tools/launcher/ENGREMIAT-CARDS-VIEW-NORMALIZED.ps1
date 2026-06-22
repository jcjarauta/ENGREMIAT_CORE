param([string]$ProjectId="",[string]$ModuleId="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$TablePath=Join-Path $Core "documents\module-cards\project-module-card-table.normalized.json"
$CardDir=Join-Path $Core "documents\module-cards"
$DetailView=Join-Path $Core "tools\launcher\ENGREMIAT-CARD-DETAIL-VIEW-NORMALIZED.ps1"
$ExampleCard=Join-Path $Core "documents\module-cards\module-linked-card.example.json"
function W($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function Short($s,$n){$v=[string]$s;if($v.Length -le $n){return $v};return $v.Substring(0,$n)}
function Norm($s){return ([string]$s).Trim()}
function RowFromCard($card,$path,$num){return [ordered]@{num=$num;card_id=[string]$card.card_id;project_id=[string]$card.project_id;module_id=[string]$card.module_id;type=[string]$card.type;status=[string]$card.status;priority=[string]$card.priority;risk=[string]$card.risk;title=[string]$card.title;human_gate=[string]$card.human_gate;suggested_action=[string]$card.suggested_action;path=[string]$path}}
function LoadRows(){
  $projectFilter=Norm $ProjectId
  $moduleFilter=Norm $ModuleId
  $all=@()
  if(Test-Path $TablePath){try{$t=Get-Content $TablePath -Raw|ConvertFrom-Json;foreach($r in @($t.rows)){$all+=$r}}catch{}}
  $filtered=@($all|Where-Object{(([string]::IsNullOrWhiteSpace($projectFilter)) -or (Norm $_.project_id) -eq $projectFilter) -and (([string]::IsNullOrWhiteSpace($moduleFilter)) -or (Norm $_.module_id) -eq $moduleFilter)})
  if($filtered.Count -gt 0){return @($filtered)}
  $fallback=@()
  foreach($f in @(Get-ChildItem $CardDir -Filter "CARD-*.json" -File -ErrorAction SilentlyContinue)){try{$c=Get-Content $f.FullName -Raw|ConvertFrom-Json;if((([string]::IsNullOrWhiteSpace($projectFilter)) -or (Norm $c.project_id) -eq $projectFilter) -and (([string]::IsNullOrWhiteSpace($moduleFilter)) -or (Norm $c.module_id) -eq $moduleFilter)){$fallback+=RowFromCard $c $f.FullName ($fallback.Count+1)}}catch{}}
  return @($fallback)
}
while($true){
  Clear-Host
  W "==== TARJETAS ====" Cyan
  if([string]::IsNullOrWhiteSpace($ProjectId) -and [string]::IsNullOrWhiteSpace($ModuleId)){W "Ruta: INICIO > Tarjetas" DarkGray}else{W "Ruta: INICIO > Proyectos > Proyecto > Modulos > Tarjetas" DarkGray}
  W "Rol: vista readonly de tarjetas vinculadas a proyecto y modulo" DarkGray
  W "Principio: PROYECTO > MODULO > TARJETA | PROPOSED no ejecuta | human_gate=SI" DarkGray
  if(-not [string]::IsNullOrWhiteSpace($ProjectId)){W ("Filtro proyecto: "+$ProjectId) DarkGray}
  if(-not [string]::IsNullOrWhiteSpace($ModuleId)){W ("Filtro modulo:   "+$ModuleId) DarkGray}
  W ""
  $rows=@(LoadRows)
  if($rows.Count -lt 1){W "No hay tarjetas normalizadas para este filtro." Yellow}else{
    W "#  CARD                 PROYECTO          MODULO                       TIPO     ESTADO     PRIO  RIESGO  GATE  TITULO" Cyan
    W "-- -------------------- ---------------- ---------------------------- -------- ---------- ----- ------- ----- ------------------------------" DarkGray
    $i=0
    foreach($r in $rows){$i++;$line=("{0,-2} {1,-20} {2,-16} {3,-28} {4,-8} {5,-10} {6,-5} {7,-7} {8,-5} {9}" -f $i,(Short $r.card_id 20),(Short $r.project_id 16),(Short $r.module_id 28),(Short $r.type 8),(Short $r.status 10),(Short $r.priority 5),(Short $r.risk 7),(Short $r.human_gate 5),(Short $r.title 30));W $line}
  }
  W ""
Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
  $op=Read-Host "TARJETAS"
  if([string]::IsNullOrWhiteSpace($op)){continue}
  if($op -eq "b" -or $op -eq "q"){break}
  if($op -eq "d"){W ("DEBUG table="+$TablePath) Cyan;W ("DEBUG card_dir="+$CardDir) Cyan;W ("DEBUG rows_loaded="+$rows.Count) Cyan;Read-Host "Enter para volver"|Out-Null;continue}
  if($op -eq "v"){if(Test-Path $ExampleCard){$checker=Join-Path $Core "tools\module-cards\check-card-to-module-flow.ps1";if(Test-Path $checker){& powershell -NoProfile -ExecutionPolicy Bypass -File $checker -CardPath $ExampleCard;Read-Host "Enter para volver"|Out-Null}};continue}
  $num=0
  if([int]::TryParse($op,[ref]$num) -and $num -ge 1 -and $num -le $rows.Count){$selected=$rows[$num-1];$cardPath=[string]$selected.path;if([string]::IsNullOrWhiteSpace($cardPath)){$cardPath=Join-Path $CardDir ([string]$selected.card_id+".json")};if(Test-Path $DetailView){& powershell -NoProfile -ExecutionPolicy Bypass -File $DetailView -CardPath $cardPath -CardId ([string]$selected.card_id)}else{W "No existe vista detalle." Red;Read-Host "Enter para volver"|Out-Null};continue}
}

