# E21D_BIS expand projects center boundary NO_APPLY

## Decision
GO_BOUNDARY_EXPANDED_READY_FOR_STABLE_REWRITE_NO_APPLY

## Target
- path: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1
- parse: 
True
- total_lines: 
24
- hit_lines: 
16, 17, 18, 19, 20, 21, 22, 23
- expanded: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\projects-center-boundary-expanded-for-rewrite.latest.txt

## ReadHost lines
- line 16 :: function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red;Read-Host 'Enter'|Out-Null}}
- line 17 :: function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;Read-Host 'Enter'|Out-Null;return};& powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}
- line 19 :: function ProjectList(){while($true){Header;$items=GetProjects;if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0;foreach($p in $items){$i++;$ProjectIdValue=SafeId $p.FullName;W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};W '';W 'numero = abrir proyecto | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){break};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
- line 20 :: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;while($true){Clear-Host;W '==== PROYECTO / ACCIONES ====' Cyan;W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan;W 'Rol: acciones locales del proyecto' DarkCyan;W 'Principio: sin workers reales, sin git, sin red' DarkCyan;W '';W ('Proyecto: '+$ProjectId) White;W ('Ruta: '+$ProjectPath) Gray;W ('Workers: '+(WorkersState)) Yellow;W ('Ultima senal: '+(LatestWorkerText)) Gray;W '';W '[1] abrir carpeta del proyecto' White;W '[2] abrir project.json' White;W '[3] modulos' White;W '[4] tarjetas canon navegacion' White;W '[5] estado/ayuda' White;W '[b] volver a cartera | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
- line 21 :: function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host;W '==== MODULOS ====' Cyan;W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan;W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan;W '';$mods=GetModules $ProjectPath;if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;foreach($m in $mods){$i++;W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}};W '';W 'numero = abrir modulo | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'MODULOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){return};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $mods.Count){ModuleActions $ProjectId $mods[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
- line 22 :: function ModuleActions($ProjectId,$ModulePath){$Mid=ModuleId $ModulePath;while($true){Clear-Host;W '==== MODULO / ACCIONES ====' Cyan;W ('Ruta: INICIO > Proyectos > Proyecto > Modulos > '+$Mid) DarkCyan;W 'Rol: acciones locales del modulo' DarkCyan;W '';W ('Proyecto: '+$ProjectId) Gray;W ('Modulo:   '+$Mid) White;W ('Ruta:     '+$ModulePath) Gray;W '';W '[1] abrir carpeta del modulo' White;W '[2] abrir module.json' White;W '[3] tarjetas del modulo' White;W '[b] volver a modulos | Enter = refrescar' DarkGray;$c=Read-Host 'MODULO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
- line 23 :: function ProjectStatus($ProjectPath,$ProjectId){Clear-Host;W '==== PROYECTO / ESTADO ====' Cyan;W ('Proyecto: '+$ProjectId) White;W ('Ruta: '+$ProjectPath) Gray;W ('Workers: '+(WorkersState)) Yellow;W ('Ultima senal: '+(LatestWorkerText)) Gray;W '';W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}

## Project screen lines
- line 18
- line 19
- line 20
- line 21
- line 22

## Expanded boundary
```text
   12: function LatestWorkerText(){if((WorkersState) -ne 'ON'){return 'Workers OFF'};if(Test-Path $LatestSignal){try{$s=Get-Content $LatestSignal -Raw|ConvertFrom-Json;return (([string]$s.kind)+' / '+([string]$s.status)+' / '+([string]$s.readiness)+'%')}catch{return 'Signal unreadable'}};return 'Sin senal'}
      12.1: function LatestWorkerText(){if((WorkersState) -ne 'ON'){return 'Workers OFF'}
      12.2: if(Test-Path $LatestSignal){try{$s=Get-Content $LatestSignal -Raw|ConvertFrom-Json
      12.3: return (([string]$s.kind)+' / '+([string]$s.status)+' / '+([string]$s.readiness)+'%')}catch{return 'Signal unreadable'}}
      12.4: return 'Sin senal'}

   13: function GetProjects(){@(Get-ChildItem $ProjectsDir -Directory -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending)}

   14: function GetModules($ProjectPath){$m=Join-Path $ProjectPath 'MODULOS';if(Test-Path $m){@(Get-ChildItem $m -Directory -ErrorAction SilentlyContinue|Sort-Object Name)}else{@()}}
      14.1: function GetModules($ProjectPath){$m=Join-Path $ProjectPath 'MODULOS'
      14.2: if(Test-Path $m){@(Get-ChildItem $m -Directory -ErrorAction SilentlyContinue|Sort-Object Name)}else{@()}}

   15: function ModuleId($ModulePath){$j=Join-Path $ModulePath 'module.json';if(Test-Path $j){try{$o=Get-Content $j -Raw|ConvertFrom-Json;if($o.module_id){return [string]$o.module_id};if($o.id){return [string]$o.id};if($o.name){return [string]$o.name}}catch{}};return (Split-Path $ModulePath -Leaf)}
      15.1: function ModuleId($ModulePath){$j=Join-Path $ModulePath 'module.json'
      15.2: if(Test-Path $j){try{$o=Get-Content $j -Raw|ConvertFrom-Json
      15.3: if($o.module_id){return [string]$o.module_id}
      15.4: if($o.id){return [string]$o.id}
      15.5: if($o.name){return [string]$o.name}}catch{}}
      15.6: return (Split-Path $ModulePath -Leaf)}

   16: function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red;Read-Host 'Enter'|Out-Null}}
      16.1: function OpenPath($p){if(Test-Path $p){Start-Process $p}else{W "NO_GO no existe: $p" Red
      16.2: Read-Host 'Enter'|Out-Null}}

   17: function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red;Read-Host 'Enter'|Out-Null;return};& powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}
      17.1: function CardsFor($ProjectId,$ModuleId){if(!(Test-Path $CardsView)){W "NO_GO falta vista tarjetas: $CardsView" Red
      17.2: Read-Host 'Enter'|Out-Null
      17.3: return}
      17.4: & powershell -NoProfile -ExecutionPolicy Bypass -File $CardsView -ProjectId $ProjectId -ModuleId $ModuleId}

   18: function Header(){Clear-Host;W '==== PROYECTOS ====' Cyan;W 'Ruta: INICIO > Proyectos' DarkCyan;W 'Rol: cartera de proyectos, modulos y tarjetas vinculadas' DarkCyan;W 'Principio: PROYECTO > MODULO > TARJETA | readonly | workers seguros' DarkCyan;W ''}
      18.1: function Header(){Clear-Host
      18.2: W '==== PROYECTOS ====' Cyan
      18.3: W 'Ruta: INICIO > Proyectos' DarkCyan
      18.4: W 'Rol: cartera de proyectos, modulos y tarjetas vinculadas' DarkCyan
      18.5: W 'Principio: PROYECTO > MODULO > TARJETA | readonly | workers seguros' DarkCyan
      18.6: W ''}

   19: function ProjectList(){while($true){Header;$items=GetProjects;if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0;foreach($p in $items){$i++;$ProjectIdValue=SafeId $p.FullName;W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};W '';W 'numero = abrir proyecto | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){break};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
      19.1: function ProjectList(){while($true){Header
      19.2: $items=GetProjects
      19.3: if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0
      19.4: foreach($p in $items){$i++
      19.5: $ProjectIdValue=SafeId $p.FullName
      19.6: W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}}
      19.7: W ''
      19.8: W 'numero = abrir proyecto | b = volver | Enter = refrescar' DarkGray
      19.9: $c=Read-Host 'PROYECTOS'
      19.10: if([string]::IsNullOrWhiteSpace($c)){continue}
      19.11: if($c.ToLower() -eq 'b'){break}
      19.12: $n=0
      19.13: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow
      19.14: Start-Sleep -Milliseconds 700}}}

   20: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath;while($true){Clear-Host;W '==== PROYECTO / ACCIONES ====' Cyan;W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan;W 'Rol: acciones locales del proyecto' DarkCyan;W 'Principio: sin workers reales, sin git, sin red' DarkCyan;W '';W ('Proyecto: '+$ProjectId) White;W ('Ruta: '+$ProjectPath) Gray;W ('Workers: '+(WorkersState)) Yellow;W ('Ultima senal: '+(LatestWorkerText)) Gray;W '';W '[1] abrir carpeta del proyecto' White;W '[2] abrir project.json' White;W '[3] modulos' White;W '[4] tarjetas canon navegacion' White;W '[5] estado/ayuda' White;W '[b] volver a cartera | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
      20.1: function ProjectActions($ProjectPath){$ProjectId=SafeId $ProjectPath
      20.2: while($true){Clear-Host
      20.3: W '==== PROYECTO / ACCIONES ====' Cyan
      20.4: W ('Ruta: INICIO > Proyectos > '+$ProjectId) DarkCyan
      20.5: W 'Rol: acciones locales del proyecto' DarkCyan
      20.6: W 'Principio: sin workers reales, sin git, sin red' DarkCyan
      20.7: W ''
      20.8: W ('Proyecto: '+$ProjectId) White
      20.9: W ('Ruta: '+$ProjectPath) Gray
      20.10: W ('Workers: '+(WorkersState)) Yellow
      20.11: W ('Ultima senal: '+(LatestWorkerText)) Gray
      20.12: W ''
      20.13: W '[1] abrir carpeta del proyecto' White
      20.14: W '[2] abrir project.json' White
      20.15: W '[3] modulos' White
      20.16: W '[4] tarjetas canon navegacion' White
      20.17: W '[5] estado/ayuda' White
      20.18: W '[b] volver a cartera | Enter = refrescar' DarkGray
      20.19: $c=Read-Host 'PROYECTO'
      20.20: if([string]::IsNullOrWhiteSpace($c)){continue}
      20.21: switch($c.ToLower()){'1'{OpenPath $ProjectPath}'2'{OpenPath (Join-Path $ProjectPath 'project.json')}'3'{ModulesScreen $ProjectPath $ProjectId}'4'{CardsFor 'ENGREMIAT_CORE' 'MODULE_OPERATOR_NAVIGATION'}'5'{ProjectStatus $ProjectPath $ProjectId}'b'{return}default{W 'Comando no reconocido' Yellow
      20.22: Start-Sleep -Milliseconds 700}}}}

   21: function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host;W '==== MODULOS ====' Cyan;W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan;W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan;W '';$mods=GetModules $ProjectPath;if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0;foreach($m in $mods){$i++;W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}};W '';W 'numero = abrir modulo | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'MODULOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){return};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $mods.Count){ModuleActions $ProjectId $mods[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
      21.1: function ModulesScreen($ProjectPath,$ProjectId){while($true){Clear-Host
      21.2: W '==== MODULOS ====' Cyan
      21.3: W ('Ruta: INICIO > Proyectos > '+$ProjectId+' > Modulos') DarkCyan
      21.4: W 'Rol: modulos del proyecto y tarjetas vinculadas' DarkCyan
      21.5: W ''
      21.6: $mods=GetModules $ProjectPath
      21.7: if($mods.Count -eq 0){W 'No hay carpeta MODULOS o no contiene modulos.' Yellow}else{$i=0
      21.8: foreach($m in $mods){$i++
      21.9: W ('['+$i+'] '+(ModuleId $m.FullName)+'  '+$m.Name) White}}
      21.10: W ''
      21.11: W 'numero = abrir modulo | b = volver | Enter = refrescar' DarkGray
      21.12: $c=Read-Host 'MODULOS'
      21.13: if([string]::IsNullOrWhiteSpace($c)){continue}
      21.14: if($c.ToLower() -eq 'b'){return}
      21.15: $n=0
      21.16: if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $mods.Count){ModuleActions $ProjectId $mods[$n-1].FullName}else{W 'Comando no reconocido' Yellow
      21.17: Start-Sleep -Milliseconds 700}}}

   22: function ModuleActions($ProjectId,$ModulePath){$Mid=ModuleId $ModulePath;while($true){Clear-Host;W '==== MODULO / ACCIONES ====' Cyan;W ('Ruta: INICIO > Proyectos > Proyecto > Modulos > '+$Mid) DarkCyan;W 'Rol: acciones locales del modulo' DarkCyan;W '';W ('Proyecto: '+$ProjectId) Gray;W ('Modulo:   '+$Mid) White;W ('Ruta:     '+$ModulePath) Gray;W '';W '[1] abrir carpeta del modulo' White;W '[2] abrir module.json' White;W '[3] tarjetas del modulo' White;W '[b] volver a modulos | Enter = refrescar' DarkGray;$c=Read-Host 'MODULO';if([string]::IsNullOrWhiteSpace($c)){continue};switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}}
      22.1: function ModuleActions($ProjectId,$ModulePath){$Mid=ModuleId $ModulePath
      22.2: while($true){Clear-Host
      22.3: W '==== MODULO / ACCIONES ====' Cyan
      22.4: W ('Ruta: INICIO > Proyectos > Proyecto > Modulos > '+$Mid) DarkCyan
      22.5: W 'Rol: acciones locales del modulo' DarkCyan
      22.6: W ''
      22.7: W ('Proyecto: '+$ProjectId) Gray
      22.8: W ('Modulo:   '+$Mid) White
      22.9: W ('Ruta:     '+$ModulePath) Gray
      22.10: W ''
      22.11: W '[1] abrir carpeta del modulo' White
      22.12: W '[2] abrir module.json' White
      22.13: W '[3] tarjetas del modulo' White
      22.14: W '[b] volver a modulos | Enter = refrescar' DarkGray
      22.15: $c=Read-Host 'MODULO'
      22.16: if([string]::IsNullOrWhiteSpace($c)){continue}
      22.17: switch($c.ToLower()){'1'{OpenPath $ModulePath}'2'{OpenPath (Join-Path $ModulePath 'module.json')}'3'{CardsFor $ProjectId $Mid}'b'{return}default{W 'Comando no reconocido' Yellow
      22.18: Start-Sleep -Milliseconds 700}}}}

   23: function ProjectStatus($ProjectPath,$ProjectId){Clear-Host;W '==== PROYECTO / ESTADO ====' Cyan;W ('Proyecto: '+$ProjectId) White;W ('Ruta: '+$ProjectPath) Gray;W ('Workers: '+(WorkersState)) Yellow;W ('Ultima senal: '+(LatestWorkerText)) Gray;W '';W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan;W '';W '[Enter] volver' DarkGray;Read-Host|Out-Null}
      23.1: function ProjectStatus($ProjectPath,$ProjectId){Clear-Host
      23.2: W '==== PROYECTO / ESTADO ====' Cyan
      23.3: W ('Proyecto: '+$ProjectId) White
      23.4: W ('Ruta: '+$ProjectPath) Gray
      23.5: W ('Workers: '+(WorkersState)) Yellow
      23.6: W ('Ultima senal: '+(LatestWorkerText)) Gray
      23.7: W ''
      23.8: W 'Tarjetas: entrar por [3] modulos > modulo > [3] tarjetas del modulo.' Cyan
      23.9: W ''
      23.10: W '[Enter] volver' DarkGray
      23.11: Read-Host|Out-Null}

   24: ProjectList

```

## Next
E21E_PREPARE_PROJECTS_CENTER_REWRITE_FROM_EXPANDED_BOUNDARY_NO_APPLY
