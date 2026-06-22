# E21C extract projects center compact boundary NO_APPLY

## Decision
GO_COMPACT_BOUNDARY_CONFIRMED_PREPARE_FULL_REWRITE_NO_APPLY

## Target
- path: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1
- parse: 
True
- line_count: 
24
- extracted_line: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\projects-center-compact-boundary-line19.latest.txt

## Compact line checks
- has_projects: 
True
- has_readhost: 
True
- has_loop: 
True
- has_switch: 
False
- has_b: 
True
- has_enter: 
True

## Context
```powershell
   11: function WorkersState(){if(Test-Path $SignalsConfig){try{$c=Get-Content $SignalsConfig -Raw|ConvertFrom-Json;if($c.enabled -eq $true){return 'ON'}}catch{}};return 'OFF'}
   12: function LatestWorkerText(){if((WorkersState) -ne 'ON'){return 'Workers OFF'};if(Test-Path $LatestSignal){try{$s=Get-Content $LatestSignal -Raw|ConvertFrom-Json;return (([string]$s.kind)+' / '+([string]$s.status)+' / '+([string]$s.readiness)+'%')}catch{return 'Signal unreadable'}};return 'Sin senal'}
   13: function GetProjects(){@(Get-ChildItem $ProjectsDir -Directory -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending)}
   14: function GetModules($ProjectPath){$m=Join-Path $ProjectPath 'MODULOS';if(Test-Path $m){@(Get-ChildItem $m -Directory -ErrorAction SilentlyContinue|Sort-Object Name)}else{@()}}
   15: function ModuleId($ModulePath){$j=Join-Path $ModulePath 'module.json';if(Test-Path $j){try{$o=Get-Content $j -Raw|ConvertFrom-Json;if($o.module_id){return [string]$o.module_id};if($o.id){return [string]$o.id};if($o.name){return [string]$o.name}}catch{}};return (Split-Path $ModulePath -Leaf)}
   16: function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red;Read-Host 'Enter'|Out-Null}}
   17: function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;Read-Host 'Enter'|Out-Null;return};& powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}
   18: function Header(){Clear-Host;W '==== PROYECTOS ====' Cyan;W 'Ruta: INICIO > Proyectos' DarkCyan;W 'Rol: cartera de proyectos, modulos y tarjetas vinculadas' DarkCyan;W 'Principio: PROYECTO > MODULO > TARJETA | readonly | workers seguros' DarkCyan;W ''}
   19: function ProjectList(){while($true){Header;$items=GetProjects;if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0;foreach($p in $items){$i++;$ProjectIdValue=SafeId $p.FullName;W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};W '';W 'numero = abrir proyecto | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){break};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   20: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;while($true){Clear-Host;W '==== PROYECTO / ACCIONES ====' Cyan;W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan;W 'Rol: acciones locales del proyecto' DarkCyan;W 'Principio: sin workers reales, sin git, sin red' DarkCyan;W '';W ('Proyecto: '+$ProjectId) White;W ('Ruta: '+$ProjectPath) Gray;W ('Workers: '+(WorkersState)) Yellow;W ('Ultima senal: '+(LatestWorkerText)) Gray;W '';W '[1] abrir carpeta del proyecto' White;W '[2] abrir project.json' White;W '[3] modulos' White;W '[4] tarjetas canon navegacion' White;W '[5] estado/ayuda' White;W '[b] volver a cartera | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   21: function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host;W '==== MODULOS ====' Cyan;W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan;W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan;W '';$mods=GetModules $ProjectPath;if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;foreach($m in $mods){$i++;W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}};W '';W 'numero = abrir modulo | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'MODULOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){return};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $mods.Count){ModuleActions $ProjectId $mods[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
   22: function ModuleActions($ProjectId,$ModulePath){$Mid=ModuleId $ModulePath;while($true){Clear-Host;W '==== MODULO / ACCIONES ====' Cyan;W ('Ruta: INICIO > Proyectos > Proyecto > Modulos > '+$Mid) DarkCyan;W 'Rol: acciones locales del modulo' DarkCyan;W '';W ('Proyecto: '+$ProjectId) Gray;W ('Modulo:   '+$Mid) White;W ('Ruta:     '+$ModulePath) Gray;W '';W '[1] abrir carpeta del modulo' White;W '[2] abrir module.json' White;W '[3] tarjetas del modulo' White;W '[b] volver a modulos | Enter = refrescar' DarkGray;$c=Read-Host 'MODULO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
   23: function ProjectStatus($ProjectPath,$ProjectId){Clear-Host;W '==== PROYECTO / ESTADO ====' Cyan;W ('Proyecto: '+$ProjectId) White;W ('Ruta: '+$ProjectPath) Gray;W ('Workers: '+(WorkersState)) Yellow;W ('Ultima senal: '+(LatestWorkerText)) Gray;W '';W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
   24: ProjectList
```

## Strategy
No parchear esta línea con regex. Si se confirma que la pantalla está comprimida en una sola línea, el siguiente bloque debe reescribir la frontera completa de PROYECTOS con una versión multilinea estable, manteniendo comportamiento existente y añadiendo q/m/?.

## Next
E21D_PREPARE_PROJECTS_CENTER_FULL_BOUNDARY_REWRITE_NO_APPLY
