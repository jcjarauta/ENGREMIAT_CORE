# ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_BEGIN
function New-EngProjectsCenterMaintenanceCard {
  Clear-Host
  Write-Host "==== TARJETA DE MANTENIMIENTO CONTEXTUAL ====" -ForegroundColor Cyan
  Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
  Write-Host "Cancelar: b / q / c / cancelar" -ForegroundColor DarkGray
  Write-Host ""

  $cancelTokens = @("b","q","c","cancelar","cancel","salir")
  $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
  if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow;
 Start-Sleep -Milliseconds 500;
 return }
  $exp = Read-Host "Esperado"
  if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow;
 Start-Sleep -Milliseconds 500;
 return }
  $obs = Read-Host "Observado / que falla"
  if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow;
 Start-Sleep -Milliseconds 500;
 return }
  $act = Read-Host "Accion realizada antes del fallo"
  if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow;
 Start-Sleep -Milliseconds 500;
 return }

  if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
  if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }
  if([string]::IsNullOrWhiteSpace($obs)){ $obs = "PENDING" }
  if([string]::IsNullOrWhiteSpace($act)){ $act = "PENDING" }

  $cardsDir = "C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards"
  if(!(Test-Path $cardsDir)){ New-Item -ItemType Directory -Force -Path $cardsDir | Out-Null }
  $id = "MCARD-" + (Get-Date -Format "yyyyMMdd-HHmmss") + "-projects-center"
  $card = Join-Path $cardsDir ($id + ".md")
  @(
    "# " + $id,
    "",
    "- screen_id: PROJECTS_CENTER",
    "- route: INICIO > Proyectos",
    "- severity: " + $sev,
    "- expected: " + $exp,
    "- observed: " + $obs,
    "- action_done: " + $act,
    "- status: OPEN",
    "- created_at: " + (Get-Date).ToString("s")
  ) | Set-Content -Encoding UTF8 $card
  Write-Host ("OK tarjeta_mantenimiento_creada=" + $card) -ForegroundColor Green
  Read-Host "Enter para volver a PROYECTOS" | Out-Null
}

function Show-EngProjectsCenterHelp {
  Clear-Host
  Write-Host "==== AYUDA - PROYECTOS ====" -ForegroundColor Cyan
  Write-Host "Ruta: INICIO > Proyectos" -ForegroundColor DarkCyan
  Write-Host ""
  Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
  Write-Host "numero = abrir proyecto" -ForegroundColor Gray
  Write-Host "b = volver" -ForegroundColor Gray
  Write-Host "q = salir / volver" -ForegroundColor Gray
  Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
  Write-Host "? = ayuda" -ForegroundColor Gray
  Write-Host ""
  Read-Host "Enter para volver" | Out-Null
}
# ENG_PROJECTS_CENTER_SCREEN_MASTER_E21E_END
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core='C:\ENGREMIAT_CORE'
$ProjectsDir=Join-Path $Core 'projects'
$LauncherDir=Join-Path $Core 'tools\launcher'
$CardsView=Join-Path $LauncherDir 'ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1'
$SignalsConfig=Join-Path $Core 'documents\worker-sync\worker-signals-config.json'
$LatestSignal=Join-Path $Core 'documents\worker-sync\project-signal-latest.json'
function W($m,$c='Gray'){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function SafeId($p){$j=Join-Path $p 'project.json';

if(Test-Path $j){try{$o=Get-Content $j -Raw|ConvertFrom-Json;

if($o.project_id){return [string]$o.project_id};

if($o.id){return [string]$o.id};

if($o.name){return [string]$o.name}}catch{}};

return (Split-Path $p -Leaf)}
function WorkersState(){if(Test-Path $SignalsConfig){try{$c=Get-Content $SignalsConfig -Raw|ConvertFrom-Json;

if($c.enabled -eq $true){return 'ON'}}catch{}};

return 'OFF'}
function LatestWorkerText(){if((WorkersState) -ne 'ON'){return 'Workers OFF'};

if(Test-Path $LatestSignal){try{$s=Get-Content $LatestSignal -Raw|ConvertFrom-Json;

return (([string]$s.kind)+' / '+([string]$s.status)+' / '+([string]$s.readiness)+'%')}catch{return 'Signal unreadable'}};

return 'Sin senal'}
function GetProjects(){@(Get-ChildItem $ProjectsDir -Directory -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending)}
function GetModules($ProjectPath){$m=Join-Path $ProjectPath 'MODULOS';

if(Test-Path $m){@(Get-ChildItem $m -Directory -ErrorAction SilentlyContinue|Sort-Object Name)}else{@()}}
function ModuleId($ModulePath){$j=Join-Path $ModulePath 'module.json';

if(Test-Path $j){try{$o=Get-Content $j -Raw|ConvertFrom-Json;

if($o.module_id){return [string]$o.module_id};

if($o.id){return [string]$o.id};

if($o.name){return [string]$o.name}}catch{}};

return (Split-Path $ModulePath -Leaf)}
function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red;

Read-Host 'Enter'|Out-Null}}
function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;

Read-Host 'Enter'|Out-Null;

return};

& powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}
function Header(){Clear-Host;

W '==== PROYECTOS ====' Cyan;

W 'Ruta: INICIO > Proyectos' DarkCyan;

W 'Rol: cartera de proyectos, modulos y tarjetas vinculadas' DarkCyan;

W 'Principio: PROYECTO > MODULO > TARJETA | readonly | workers seguros' DarkCyan;

W ''}
function ProjectList(){while($true){Header;

$items=GetProjects;

if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0;

foreach($p in $items){$i++;

$ProjectIdValue=SafeId $p.FullName;

W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};

W '';

W 'numero = abrir proyecto | b/q = volver | m = mantenimiento | ? = ayuda | Enter = refrescar' DarkGray;

$c=Read-Host 'PROYECTOS';
# ENG_PROJECTS_CENTER_ROUTER_E23C_BEGIN
$__eng_projects_center_cmd = if($null -eq $c) { "" } else { [string]$c }
$__eng_projects_center_cmd = $__eng_projects_center_cmd.Trim().ToLowerInvariant()
if($__eng_projects_center_cmd -eq "m"){ New-EngProjectsCenterMaintenanceCard; continue }
if($__eng_projects_center_cmd -eq "?"){ Show-EngProjectsCenterHelp; continue }
if($__eng_projects_center_cmd -eq "q"){ return }
# ENG_PROJECTS_CENTER_ROUTER_E23C_END

if([string]::IsNullOrWhiteSpace($c)){continue};

if($c.ToLower() -eq 'b'){break};

$n=0;

if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;

Start-Sleep -Milliseconds 700}}}
function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;

while($true){Clear-Host;

W '==== PROYECTO / ACCIONES ====' Cyan;

W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan;

W 'Rol: acciones locales del proyecto' DarkCyan;

W 'Principio: sin workers reales, sin git, sin red' DarkCyan;

W '';

W ('Proyecto: '+$ProjectId) White;

W ('Ruta: '+$ProjectPath) Gray;

W ('Workers: '+(WorkersState)) Yellow;

W ('Ultima senal: '+(LatestWorkerText)) Gray;

W '';

W '[1] abrir carpeta del proyecto' White;

W '[2] abrir project.json' White;

W '[3] modulos' White;

W '[4] tarjetas canon navegacion' White;

W '[5] estado/ayuda' White;

W '[b] volver a cartera | Enter = refrescar' DarkGray;

$c=Read-Host 'PROYECTO';

if([string]::IsNullOrWhiteSpace($c)){continue};

switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow;

Start-Sleep -Milliseconds 700}}}}
function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host;

W '==== MODULOS ====' Cyan;

W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan;

W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan;

W '';

$mods=GetModules $ProjectPath;

if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;

foreach($m in $mods){$i++;

W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}};

W '';

W 'numero = abrir modulo | b = volver | Enter = refrescar' DarkGray;

$c=Read-Host 'MODULOS';

if([string]::IsNullOrWhiteSpace($c)){continue};

if($c.ToLower() -eq 'b'){return};

$n=0;

if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $mods.Count){ModuleActions $ProjectId $mods[$n-1].FullName}else{W 'Comando no reconocido' Yellow;

Start-Sleep -Milliseconds 700}}}
function ModuleActions($ProjectId,$ModulePath){$Mid=ModuleId $ModulePath;

while($true){Clear-Host;

W '==== MODULO / ACCIONES ====' Cyan;

W ('Ruta: INICIO > Proyectos > Proyecto > Modulos > '+$Mid) DarkCyan;

W 'Rol: acciones locales del modulo' DarkCyan;

W '';

W ('Proyecto: '+$ProjectId) Gray;

W ('Modulo:   '+$Mid) White;

W ('Ruta:     '+$ModulePath) Gray;

W '';

W '[1] abrir carpeta del modulo' White;

W '[2] abrir module.json' White;

W '[3] tarjetas del modulo' White;

W '[b] volver a modulos | Enter = refrescar' DarkGray;

$c=Read-Host 'MODULO';

if([string]::IsNullOrWhiteSpace($c)){continue};

switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow;

Start-Sleep -Milliseconds 700}}}}
function ProjectStatus($ProjectPath,$ProjectId){Clear-Host;

W '==== PROYECTO / ESTADO ====' Cyan;

W ('Proyecto: '+$ProjectId) White;

W ('Ruta: '+$ProjectPath) Gray;

W ('Workers: '+(WorkersState)) Yellow;

W ('Ultima senal: '+(LatestWorkerText)) Gray;

W '';

W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan;

W '';

W '[Enter] volver' DarkGray;

Read-Host|Out-Null}
ProjectList

