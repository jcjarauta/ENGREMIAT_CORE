$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$ProjectRoots=@((Join-Path $Core "projects"),"C:\Users\pc\Desktop\ENGREMIAT_OPERATOR","C:\Users\pc\Desktop")
function UX([string]$m,[string]$role="info"){$c=switch($role){"title"{"Cyan"}"route"{"DarkGray"}"role"{"Gray"}"principle"{"DarkGray"}"section"{"Yellow"}"ok"{"Green"}"warn"{"Yellow"}"err"{"Red"}"next"{"Cyan"}"muted"{"DarkGray"}default{"Gray"}};try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
function UXOk([string]$m){UX ("[OK] "+$m) "ok"}
function UXWarn([string]$m){UX ("[WARN] "+$m) "warn"}
function P(){Write-Host "";Read-Host "[Enter] volver / refrescar"|Out-Null}
function Header([string]$section=""){Clear-Host;UX "==== PROYECTOS / CENTRO DE PROYECTOS ====" "title";UX "Ruta: INICIO > Proyectos" "route";UX "Rol: entrada humana principal para crear, abrir y operar proyectos" "role";UX "Principio: ver cartera, madurez y bloqueos antes de operar modulos" "principle";if($section){UX $section "section"};Write-Host ""}
function EnsureRoots(){foreach($r in $ProjectRoots){if($r -like (Join-Path $Core "projects")){New-Item -ItemType Directory -Force -Path $r|Out-Null}}}
function GetProjects(){EnsureRoots;$all=@();foreach($r in $ProjectRoots){if(Test-Path $r){$all+=Get-ChildItem $r -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -match "^ENGREMIAT_PROJECT_" -or (Test-Path (Join-Path $_.FullName "MODULOS")) -or (Test-Path (Join-Path $_.FullName "project.json"))}}};$all|Sort-Object LastWriteTime -Descending -Unique}
function CountFiles([string]$p,[string]$filter="*"){if(Test-Path $p){return @((Get-ChildItem $p -File -Recurse -Filter $filter -ErrorAction SilentlyContinue)|Select-Object -First 500).Count};return 0}
function CountDirs([string]$p){if(Test-Path $p){return @((Get-ChildItem $p -Directory -ErrorAction SilentlyContinue)).Count};return 0}
function ProjectSignal($p){
$dir=$p.FullName
$hasJson=Test-Path (Join-Path $dir "project.json")
$modDir=Join-Path $dir "MODULOS"
$docsDir=Join-Path $dir "documents"
$reportsDir=Join-Path $dir "reports"
$mods=CountDirs $modDir
$docs=CountFiles $docsDir "*.md"
$reports=CountFiles $reportsDir "*.json"
$ageHours=[math]::Round(((Get-Date)-$p.LastWriteTime).TotalHours,1)
$score=0
if($hasJson){$score+=20}
if(Test-Path $modDir){$score+=20}
$score+=[math]::Min(30,$mods*6)
$score+=[math]::Min(10,$reports*2)
$score+=[math]::Min(10,$docs*2)
if($ageHours -le 48){$score+=10}elseif($ageHours -le 168){$score+=5}
if($score -gt 100){$score=100}
$critical=@()
$warns=@()
if(!(Test-Path $modDir)){$critical+="sin_modulos_dir"}elseif($mods -eq 0){$critical+="sin_modulos"}
if(!$hasJson){$warns+="sin_project_json"}
if($reports -eq 0){$warns+="sin_reports"}
if($ageHours -gt 168){$warns+="sin_actividad_7d"}
$level=if($score -ge 80){"ALTA"}elseif($score -ge 55){"MEDIA"}elseif($score -ge 30){"BAJA"}else{"INICIAL"}
$block=if($critical.Count -gt 0){"BLOCK"}elseif($warns.Count -gt 0){"WARN"}else{"OK"}
$causa=if($critical.Count -gt 0){($critical -join ",")}elseif($warns.Count -gt 0){($warns -join ",")}else{"sin_bloqueos"}
[pscustomobject]@{name=$p.Name;path=$dir;last=$p.LastWriteTime;score=$score;level=$level;block=$block;cause=$causa;critical=$critical;warns=$warns;mods=$mods;reports=$reports;docs=$docs;age_hours=$ageHours}
}
function ShowProjects(){
Header "CARTERA DE PROYECTOS"
$projects=@(GetProjects)
if(!$projects.Count){UXWarn "No se han encontrado proyectos. Usa [3] crear proyecto minimo.";P;return}
$signals=@($projects|ForEach-Object{ProjectSignal $_})
$ok=@($signals|Where-Object{$_.block -eq "OK"}).Count
$warn=@($signals|Where-Object{$_.block -eq "WARN"}).Count
$block=@($signals|Where-Object{$_.block -eq "BLOCK"}).Count
UX ("Total: "+$signals.Count+"  OK="+$ok+"  WARN="+$warn+"  BLOCK="+$block) "muted"
Write-Host ""
UX "NOMBRE                                      MADUREZ BLOQ  MOD REP  CAUSA" "section"
$i=1
foreach($s in $signals){
$short=$s.name;if($short.Length -gt 42){$short=$short.Substring(0,39)+"..."}
$cause=$s.cause;if($cause.Length -gt 24){$cause=$cause.Substring(0,21)+"..."}
$line=("[{0}] {1,-42} {2,3}%/{3,-6} {4,-5} {5,3} {6,3}  {7}" -f $i,$short,$s.score,$s.level,$s.block,$s.mods,$s.reports,$cause)
$role=if($s.block -eq "OK"){"ok"}elseif($s.block -eq "WARN"){"warn"}else{"err"}
UX $line $role
$i++
}
Write-Host ""
UX "BLOCK = falta estructura minima. WARN = falta evidencia recomendada. REP=0 no bloquea por si solo." "muted"
P
}
function SelectProject(){Header "ABRIR PROYECTO";$projects=@(GetProjects);if(!$projects.Count){UXWarn "No hay proyectos detectados.";P;return};$i=1;foreach($p in $projects){$s=ProjectSignal $p;UX ("["+($i)+"] "+$p.Name+"  madurez="+$s.score+"%  bloqueo="+$s.block);$i++};Write-Host "";UX "[b] volver" "muted";$op=Read-Host "PROYECTO";if($op -eq "b"){return};$n=0;if(![int]::TryParse($op,[ref]$n) -or $n -lt 1 -or $n -gt $projects.Count){UXWarn "Seleccion no valida";Start-Sleep -Milliseconds 700;return};Start-Process explorer.exe $projects[$n-1].FullName;Header "PROYECTO ABIERTO";UXOk $projects[$n-1].FullName;P}
function NewProject(){Header "NUEVO PROYECTO MINIMO";$root=Join-Path $Core "projects";New-Item -ItemType Directory -Force -Path $root|Out-Null;$name=Read-Host "Nombre corto del proyecto";if(!$name -or !$name.Trim()){UXWarn "Cancelado: nombre vacio";P;return};$slug=($name.ToLowerInvariant() -replace "[^a-z0-9]+","-").Trim("-");if(!$slug){$slug="nuevo-proyecto"};$stamp=Get-Date -Format "yyyyMMdd-HHmmss";$dir=Join-Path $root ("ENGREMIAT_PROJECT_"+$slug+"_"+$stamp);New-Item -ItemType Directory -Force -Path $dir,(Join-Path $dir "MODULOS"),(Join-Path $dir "documents"),(Join-Path $dir "reports")|Out-Null;$obj=[ordered]@{id=("ENGREMIAT_PROJECT_"+$slug+"_"+$stamp);name=$name;created_at=(Get-Date).ToString("s");status="ACTIVE";source="PROJECTS_CENTER_NORMALIZED";modules_dir=(Join-Path $dir "MODULOS")};$obj|ConvertTo-Json -Depth 50|Set-Content (Join-Path $dir "project.json") -Encoding UTF8;Start-Process explorer.exe $dir;Header "PROYECTO CREADO";UXOk $dir;P}
function ProjectModules(){Header "MODULOS DEL PROYECTO";$projects=@(GetProjects);if(!$projects.Count){UXWarn "No hay proyectos detectados.";P;return};$i=1;foreach($p in $projects){$s=ProjectSignal $p;UX ("["+($i)+"] "+$p.Name+"  mods="+$s.mods+"  bloqueo="+$s.block);$i++};Write-Host "";UX "[b] volver" "muted";$op=Read-Host "PROYECTO_MODULOS";if($op -eq "b"){return};$n=0;if(![int]::TryParse($op,[ref]$n) -or $n -lt 1 -or $n -gt $projects.Count){UXWarn "Seleccion no valida";Start-Sleep -Milliseconds 700;return};$mod=Join-Path $projects[$n-1].FullName "MODULOS";New-Item -ItemType Directory -Force -Path $mod|Out-Null;$mods=@(Get-ChildItem $mod -Directory -ErrorAction SilentlyContinue|Sort-Object Name);Header ("MODULOS / "+$projects[$n-1].Name);if(!$mods.Count){UXWarn "Sin modulos todavia.";UX ("Carpeta: "+$mod) "muted"}else{$j=1;foreach($m in $mods){UX ("["+($j)+"] "+$m.Name);$j++}};Write-Host "";UX "[o] abrir carpeta modulos | [Enter] volver" "muted";$x=Read-Host "MODULOS";if($x -eq "o"){Start-Process explorer.exe $mod}}
function OpenProjectsRoot(){EnsureRoots;$root=Join-Path $Core "projects";Start-Process explorer.exe $root;Header "CARPETA PROYECTOS";UXOk $root;P}
function Status(){Header "ESTADO PROYECTOS";EnsureRoots;$projects=@(GetProjects);$signals=@($projects|ForEach-Object{ProjectSignal $_});UXOk ("proyectos_detectados="+$signals.Count);UXOk ("madurez_media="+([math]::Round((($signals|Measure-Object score -Average).Average),1))+"%");UXWarn ("bloqueos_warn="+@($signals|Where-Object{$_.block -eq "WARN"}).Count+" bloqueos_block="+@($signals|Where-Object{$_.block -eq "BLOCK"}).Count);foreach($r in $ProjectRoots){if(Test-Path $r){UXOk $r}else{UXWarn ("no existe: "+$r)}};P}
function Help(){Header "AYUDA PROYECTOS";UX "La vista muestra madurez y bloqueos por proyecto.";UX "Madurez: project.json + modulos + reports + docs + actividad reciente.";UX "Bloqueo OK/WARN/BLOCK segun señales faltantes." "muted";P}
function Menu(){while($true){Header;UX "[1] ver cartera de proyectos";UX "[2] abrir proyecto";UX "[3] crear proyecto minimo";UX "[4] modulos del proyecto";UX "[5] abrir carpeta proyectos";UX "[6] estado y ayuda";Write-Host "";UX "[b] volver | [Enter] refrescar | ? = ayuda" "muted";Write-Host "";$op=Read-Host "PROYECTOS";switch($op){"1"{ShowProjects};"2"{SelectProject};"3"{NewProject};"4"{ProjectModules};"5"{OpenProjectsRoot};"6"{Status};"b"{return};""{continue};"?"{Help};default{UXWarn "Opcion no reconocida";Start-Sleep -Milliseconds 700}}}}
Menu

