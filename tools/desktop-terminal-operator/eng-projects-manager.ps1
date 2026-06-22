# ENG_PROJECTS_MANAGER_SCREEN_MASTER_E17B_BEGIN
function New-EngProjectsManagerMaintenanceCard {
  Clear-Host
Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
  Write-Host "Ruta: PROYECTOS ACTIVOS" -ForegroundColor DarkCyan
  Write-Host "Cancelar: b / q / c / cancelar" -ForegroundColor DarkGray
  Write-Host ""

  $cancelTokens = @("b","q","c","cancelar","cancel","salir")

Write-Host ""
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
Write-Host ""
  $sev = Read-Host "Severidad LOW/MEDIUM/HIGH/BLOCKER"
  if($cancelTokens -contains $sev.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  $exp = Read-Host "Esperado"
  if($cancelTokens -contains $exp.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  $obs = Read-Host "Observado / que falla"
  if($cancelTokens -contains $obs.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }
  $act = Read-Host "Accion realizada antes del fallo"
  if($cancelTokens -contains $act.Trim().ToLowerInvariant()){ Write-Host "CANCELADO tarjeta_mantenimiento" -ForegroundColor Yellow; Start-Sleep -Milliseconds 500; return }

  if([string]::IsNullOrWhiteSpace($sev)){ $sev = "MEDIUM" }
  if([string]::IsNullOrWhiteSpace($exp)){ $exp = "PENDING" }
  if([string]::IsNullOrWhiteSpace($obs)){ $obs = "PENDING" }
  if([string]::IsNullOrWhiteSpace($act)){ $act = "PENDING" }

  $cardsDir = "C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards"
  if(!(Test-Path $cardsDir)){ New-Item -ItemType Directory -Force -Path $cardsDir | Out-Null }
  $id = "MCARD-" + (Get-Date -Format "yyyyMMdd-HHmmss") + "-projects-active"
  $card = Join-Path $cardsDir ($id + ".md")
  @(
    "# " + $id,
    "",
    "- screen_id: PROJECTS_ACTIVE",
    "- route: PROYECTOS ACTIVOS",
    "- severity: " + $sev,
    "- expected: " + $exp,
    "- observed: " + $obs,
    "- action_done: " + $act,
    "- status: OPEN",
    "- created_at: " + (Get-Date).ToString("s")
  ) | Set-Content -Encoding UTF8 $card
  Write-Host ("OK tarjeta_mantenimiento_creada=" + $card) -ForegroundColor Green
  Read-Host "Enter para volver a PROYECTOS ACTIVOS" | Out-Null
}

function Show-EngProjectsManagerHelp {
  Clear-Host
  Write-Host "==== AYUDA - PROYECTOS ACTIVOS ====" -ForegroundColor Cyan
  Write-Host "Ruta: PROYECTOS ACTIVOS" -ForegroundColor DarkCyan
  Write-Host ""
  Write-Host "Enter = refrescar pantalla" -ForegroundColor Gray
  Write-Host "numero = abrir espacio de trabajo" -ForegroundColor Gray
  Write-Host "oN = abrir carpeta del proyecto N" -ForegroundColor Gray
  Write-Host "hN = historico del proyecto N" -ForegroundColor Gray
  Write-Host "v = historico" -ForegroundColor Gray
  Write-Host "n = nuevo proyecto" -ForegroundColor Gray
  Write-Host "m = crear tarjeta de mantenimiento contextual" -ForegroundColor Gray
  Write-Host "q = salir" -ForegroundColor Gray
  Write-Host ""
  Read-Host "Enter para volver" | Out-Null
}
# ENG_PROJECTS_MANAGER_SCREEN_MASTER_E17B_END
param([string]$Mode="menu")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function B([string]$t,[object[]]$l,[string]$c="Cyan"){Write-Host "";Write-Host "==== $t ====" -ForegroundColor $c;foreach($x in $l){Write-Host ([string]$x) -ForegroundColor $c}}
function D([string]$p){[System.IO.Directory]::CreateDirectory($p)|Out-Null}
function SetProp([object]$o,[string]$n,[object]$v){if($o.PSObject.Properties.Name -contains $n){$o.$n=$v}else{$o|Add-Member -NotePropertyName $n -NotePropertyValue $v -Force}}
function LoadJsonOrNew([string]$p){if(Test-Path -LiteralPath $p){try{return (Get-Content -LiteralPath $p -Raw -Encoding UTF8|ConvertFrom-Json)}catch{}};return [pscustomobject]@{}}
function GetActivePath{ $p="C:\ENGREMIAT_CORE\data\desktop-terminal-operator\operator-state.v1.json"; if(!(Test-Path -LiteralPath $p)){return ""}; try{$s=Get-Content -LiteralPath $p -Raw -Encoding UTF8|ConvertFrom-Json; foreach($k in @("active_project_path","current_project_path","active_project","current_project")){if($s.PSObject.Properties.Name -contains $k){$v=[string]$s.$k;if($v -and (Test-Path -LiteralPath $v)){return (Resolve-Path -LiteralPath $v).Path}}}}catch{}; return "" }
function EnsureProjectJson([string]$projectPath,[string]$status){$control=Join-Path $projectPath "BOVEDA_PROYECTO\00_CONTROL";D $control;$pjp=Join-Path $control "project.json";$pj=LoadJsonOrNew $pjp;SetProp $pj "project_id" (Split-Path -Leaf $projectPath);SetProp $pj "name" (Split-Path -Leaf $projectPath);SetProp $pj "path" $projectPath;SetProp $pj "status" $status;SetProp $pj "operator_status" $status;SetProp $pj "updated_at" ((Get-Date).ToString("s"));$pj|ConvertTo-Json -Depth 80|Set-Content -LiteralPath $pjp -Encoding UTF8}
function GetProjects([string]$base){if(!(Test-Path -LiteralPath $base)){return @()};$activePath=GetActivePath;$items=@();$dirs=@(Get-ChildItem -LiteralPath $base -Directory -Filter "ENGREMIAT_PROJECT_*" -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending);foreach($d in $dirs){$resolved=(Resolve-Path -LiteralPath $d.FullName).Path;$status="HISTORICO";if($activePath -ne "" -and $resolved -eq $activePath){$status="ACTIVO"};$items+=[pscustomobject]@{Name=$d.Name;Path=$resolved;Status=$status;LastWriteTime=$d.LastWriteTime}};return @($items)}
function SaveActive([string]$projectPath){$root="C:\ENGREMIAT_CORE";$base="C:\Users\pc\Desktop\ENGREMIAT_OPERATOR";$statePath=Join-Path $root "data\desktop-terminal-operator\operator-state.v1.json";D (Split-Path -Parent $statePath);$resolved=(Resolve-Path -LiteralPath $projectPath).Path;$state=LoadJsonOrNew $statePath;$name=Split-Path -Leaf $resolved;SetProp $state "active_project" $resolved;SetProp $state "active_project_path" $resolved;SetProp $state "active_project_name" $name;SetProp $state "current_project" $resolved;SetProp $state "current_project_path" $resolved;SetProp $state "updated_at" ((Get-Date).ToString("s"));SetProp $state "last_project_lifecycle_action" ([ordered]@{action="activate";project=$resolved;created_at=(Get-Date).ToString("s")});$state|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $statePath -Encoding UTF8;foreach($d in @(Get-ChildItem -LiteralPath $base -Directory -Filter "ENGREMIAT_PROJECT_*" -ErrorAction SilentlyContinue)){if((Resolve-Path -LiteralPath $d.FullName).Path -eq $resolved){EnsureProjectJson $d.FullName "ACTIVO"}else{EnsureProjectJson $d.FullName "HISTORICO"}}}
function SendHistoric([string]$projectPath){$resolved=(Resolve-Path -LiteralPath $projectPath).Path;EnsureProjectJson $resolved "HISTORICO";$active=GetActivePath;if($active -eq $resolved){$statePath="C:\ENGREMIAT_CORE\data\desktop-terminal-operator\operator-state.v1.json";$state=LoadJsonOrNew $statePath;foreach($k in @("active_project","active_project_path","active_project_name","current_project","current_project_path")){SetProp $state $k ""};SetProp $state "updated_at" ((Get-Date).ToString("s"));SetProp $state "last_project_lifecycle_action" ([ordered]@{action="historify_active";project=$resolved;created_at=(Get-Date).ToString("s")});$state|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $statePath -Encoding UTF8}}
function ShowWorkspace($project){while($true){Clear-Host;B "ESPACIO DE TRABAJO" @($project.Name,$project.Path,("Estado: "+$project.Status)) "Cyan";Write-Host " [1] Carpeta del proyecto" -ForegroundColor Green;Write-Host " [2] Módulos del proyecto" -ForegroundColor Green;Write-Host " [3] Espacio módulo inicio" -ForegroundColor Green;Write-Host " [4] Control del proyecto" -ForegroundColor Yellow;Write-Host " [b] Atrás" -ForegroundColor Yellow;Write-Host "";Write-Host "Enter = refrescar | b = volver | 1 carpeta | 2 modulos | 3 modulo inicio | 4 control" -ForegroundColor DarkGray;$a=Read-Host "PROYECTO";if([string]::IsNullOrWhiteSpace($a)){continue};$a=$a.Trim().ToLowerInvariant();if($a -eq "b"){break};if($a -eq "1"){Start-Process explorer.exe $project.Path;continue};if($a -eq "2"){& powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-project-modules-screen.ps1" -ProjectPath $project.Path;continue};if($a -eq "3"){$p=Join-Path $project.Path "MODULOS\MODULE_inicio\BOVEDA_MODULO";if(Test-Path -LiteralPath $p){Start-Process explorer.exe $p}else{B "NO_GO" @("No existe: $p") "Yellow";Read-Host "Enter"};continue};if($a -eq "4"){$p=Join-Path $project.Path "BOVEDA_PROYECTO\00_CONTROL";if(Test-Path -LiteralPath $p){Start-Process explorer.exe $p}else{B "NO_GO" @("No existe: $p") "Yellow";Read-Host "Enter"};continue}}}
try{
  $root="C:\ENGREMIAT_CORE";$base="C:\Users\pc\Desktop\ENGREMIAT_OPERATOR"
  while($true){
    Clear-Host
    $projects=GetProjects $base
    $active=@($projects|Where-Object{$_.Status -eq "ACTIVO"}|Sort-Object LastWriteTime -Descending)
    $hist=@($projects|Where-Object{$_.Status -ne "ACTIVO"}|Sort-Object LastWriteTime -Descending)
Write-Host "Ruta: PROYECTOS ACTIVOS" -ForegroundColor DarkCyan
Write-Host "[?] Ayuda  [m] Mantenimiento  [Enter] Refrescar" -ForegroundColor DarkGray
    B "PROYECTOS ACTIVOS" @("numero = espacio de trabajo | oN = abrir carpeta | hN = historico | v = historico | n = nuevo | q = salir") "Cyan"
    if($active.Count -eq 0){W " No hay proyectos activos." "Yellow"}else{for($i=0;$i -lt $active.Count;$i++){W (" ["+($i+1)+"] "+$active[$i].Name+"  "+$active[$i].LastWriteTime.ToString("yyyy-MM-dd HH:mm")+"  ACTIVO") "Green"}}
    W "";W "[v] Historico  [n] Nuevo  [q] Salir" "Yellow";W ""
    $a=Read-Host "ENGREMIAT"
# ENG_PROJECTS_MANAGER_ROUTER_E17B_BEGIN
$__eng_projects_cmd = if($null -eq $a) { "" } else { [string]$a }
$__eng_projects_cmd = $__eng_projects_cmd.Trim().ToLowerInvariant()
if($__eng_projects_cmd -eq "m"){ New-EngProjectsManagerMaintenanceCard; continue }
if($__eng_projects_cmd -eq "?"){ Show-EngProjectsManagerHelp; continue }
# ENG_PROJECTS_MANAGER_ROUTER_E17B_END
    if([string]::IsNullOrWhiteSpace($a)){continue};$a=$a.Trim().ToLowerInvariant();if($a -eq "q"){break}
    if($a -eq "n"){$creator=Join-Path $root "tools\desktop-terminal-operator\eng-new-project-safe.ps1";if(Test-Path -LiteralPath $creator){& powershell -NoProfile -ExecutionPolicy Bypass -File $creator}else{B "NO_GO" @("No encuentro creador: $creator") "Yellow";Read-Host "Enter"};$latest=@(Get-ChildItem -LiteralPath $base -Directory -Filter "ENGREMIAT_PROJECT_*" -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 1);if($latest.Count -gt 0){SaveActive $latest[0].FullName};continue}
    if($a -eq "v"){while($true){Clear-Host;$projects=GetProjects $base;$hist=@($projects|Where-Object{$_.Status -ne "ACTIVO"}|Sort-Object LastWriteTime -Descending);B "HISTORICO" @("numero = activar | oN = abrir carpeta | b = atras") "Yellow";if($hist.Count -eq 0){W " Historico vacio." "Yellow"}else{for($i=0;$i -lt $hist.Count;$i++){W (" ["+($i+1)+"] "+$hist[$i].Name+"  "+$hist[$i].LastWriteTime.ToString("yyyy-MM-dd HH:mm")+"  HISTORICO") "Gray"}};W "";$h=Read-Host "HISTORICO";if([string]::IsNullOrWhiteSpace($h)){continue};$h=$h.Trim().ToLowerInvariant();if($h -eq "b"){break};if($h -match "^o(\d+)$"){$idx=[int]$Matches[1]-1;if($idx -ge 0 -and $idx -lt $hist.Count){Start-Process explorer.exe $hist[$idx].Path};continue};$hn=0;if([int]::TryParse($h,[ref]$hn) -and $hn -ge 1 -and $hn -le $hist.Count){SaveActive $hist[($hn-1)].Path;break}};continue}
    if($a -match "^o(\d+)$"){$idx=[int]$Matches[1]-1;if($idx -ge 0 -and $idx -lt $active.Count){Start-Process explorer.exe $active[$idx].Path};continue}
    if($a -match "^h(\d+)$"){$idx=[int]$Matches[1]-1;if($idx -ge 0 -and $idx -lt $active.Count){SendHistoric $active[$idx].Path};continue}
    $n=0;if([int]::TryParse($a,[ref]$n) -and $n -ge 1 -and $n -le $active.Count){ShowWorkspace $active[($n-1)];continue}
  }
}catch{B "ERR" @("status=FAIL",$_.Exception.Message) "Red";Read-Host "Enter para salir";exit 1}




