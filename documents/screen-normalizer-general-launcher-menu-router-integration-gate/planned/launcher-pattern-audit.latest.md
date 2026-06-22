# E03C launcher pattern audit no apply

## Decision
NO_GO_OPTION_9_NOT_FREE

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Planned baseline copy
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.menu-router-planned.latest.ps1

## Findings
- pattern_clear: 
True
- option_9_free: 
False
- planned_parse: 
True
- menu_hits_count: 
54
- input_hits_count: 
12
- router_hits_count: 
62
- option_hits_count: 
2

## Rule
NO_APPLY. No se modifica el launcher real. Solo se crea copia planned base y auditoria.

## Menu hits
### around line 6
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
### around line 7
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
### around line 11
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
### around line 13
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
### around line 21
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
### around line 22
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
### around line 30
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
### around line 34
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
### around line 36
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
### around line 51
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
### around line 54
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
### around line 55
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)

## Input hits
### around line 174
  172: while($true){
  173:   Refresh-Screen
  174:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
### around line 177
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
### around line 182
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
### around line 183
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
### around line 184
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
### around line 185
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
### around line 186
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
  188: 
### around line 216
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   $title=Read-Host "Titulo breve"
  217:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  218:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
### around line 218
  216:   $title=Read-Host "Titulo breve"
  217:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  218:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  219:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
### around line 222
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  221:   if($dimension -notin $allowedDimensions){$dimension="other"}
  222:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  223:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  224:   $severity=$severity.ToUpperInvariant()
### around line 226
  224:   $severity=$severity.ToUpperInvariant()
  225:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  226:   $observation=Read-Host "Observacion"
  227:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  228:   $suggested=Read-Host "Accion sugerida"
### around line 228
  226:   $observation=Read-Host "Observacion"
  227:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  228:   $suggested=Read-Host "Accion sugerida"
  229:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  230:   if($title.Length -gt 120){$title=$title.Substring(0,120)}

## Router hits
### around line 7
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
### around line 10
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
### around line 16
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
### around line 27
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
### around line 28
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
### around line 29
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
### around line 30
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
### around line 32
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
### around line 33
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
### around line 41
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
### around line 42
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
   44:   L "UBICACION" DarkCyan
### around line 43
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
   44:   L "UBICACION" DarkCyan
   45:   L (" Nivel:    "+$level) DarkCyan

## Option 9 hits
### around line 98
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
### around line 141
  139:     if($x -in @("7","o","objetivo")){return "objetivo"}
  140:     if($x -in @("8","cm","cerrar","cerrar-modulo")){return "cerrar-modulo"}
  141:     if($x -in @("9","pb","promover","promover-biblioteca")){return "promover"}
  142:   }
  143:   return $x

## Authorization required later
AUTORIZO_APLICAR_MENU_ROUTER_ADAPTER_DIFF_TRAS_REVISAR_PATRON_REAL
