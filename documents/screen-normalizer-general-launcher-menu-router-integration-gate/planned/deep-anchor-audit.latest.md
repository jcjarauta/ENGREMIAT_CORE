# E04B deep anchor audit no apply

## Decision
GO_ANCHOR_CONTEXT_READY_NO_APPLY

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Recommended free option
10

## Counts
- menu_hits: 
45
- input_hits: 
12
- router_hits: 
62
- function_hits: 
16
- loop_hits: 
1
- option_hits: 
36

## Suggested review points
- menu_best_line: 
215
- input_best_line: 
228
- router_best_line: 
234

## Rule
NO_APPLY. Este paso no modifica launcher, no crea patched definitivo y no git.

## Menu candidates
### around line 6
    1: param([string]$Root="C:\ENGREMIAT_CORE")
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""

### around line 7
    1: param([string]$Root="C:\ENGREMIAT_CORE")
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""

### around line 11
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"

### around line 13
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"

### around line 21
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}

### around line 22
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}

### around line 30
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level

### around line 34
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}

### around line 54
   46:   L (" Proyecto: "+$projectName) DarkCyan
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""

### around line 55
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}

### around line 56
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}

### around line 58
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++

### around line 72
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan

### around line 73
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline

### around line 74
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan

### around line 75
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green

### around line 76
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green

### around line 77
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green

### around line 78
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green

### around line 83
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green

### around line 84
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green

### around line 85
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green

### around line 86
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green

### around line 90
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green

### around line 91
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow

### around line 92
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }

### around line 93
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
  101:   L ""

### around line 94
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
  101:   L ""
  102:   L "refrescar/f5/Enter = refrescar pantalla | ? = ayuda | comandos = menu actual" DarkGray

### around line 95
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
  101:   L ""
  102:   L "refrescar/f5/Enter = refrescar pantalla | ? = ayuda | comandos = menu actual" DarkGray
  103:   L ""

### around line 96
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
  101:   L ""
  102:   L "refrescar/f5/Enter = refrescar pantalla | ? = ayuda | comandos = menu actual" DarkGray
  103:   L ""
  104: }


## Input candidates
### around line 174
  166:   L "AYUDA" Cyan
  167:   L "Enter/refrescar/f5 redibuja pantalla." Gray
  168:   L "a/b/atras vuelve al nivel anterior." Gray
  169:   L "q sale desde GLOBAL." Gray
  170: }
  171: Set-BootGlobalKeepContext
  172: while($true){
  173:   Refresh-Screen
  174:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}

### around line 177
  169:   L "q sale desde GLOBAL." Gray
  170: }
  171: Set-BootGlobalKeepContext
  172: while($true){
  173:   Refresh-Screen
  174:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}

### around line 182
  174:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
  188: 
  189: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  190: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001

### around line 183
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
  188: 
  189: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  190: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  191: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado

### around line 184
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
  188: 
  189: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  190: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  191: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  192: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.

### around line 185
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
  188: 
  189: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  190: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  191: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  192: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  193: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END

### around line 186
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"
  179:     continue
  180:   }
  181:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_END
  182:   if($cmd -eq "__refresh__"){continue}
  183:   if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
  184:   if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
  185:   if($cmd -eq "atras"){Go-Back;continue}
  186:   & powershell -NoProfile -ExecutionPolicy Bypass -File $Router $cmd
  187: }
  188: 
  189: # ENGREMIAT_RUNTIME_UI_INTEGRATION_BEGIN
  190: # Runtime UI adapter hook prepared by ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
  191: # Visible command proposal: runtime / acciones -> tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 -Command estado
  192: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  193: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  194: 

### around line 216
  208: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  209:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  210:   Write-Host ""
  211:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  212: Ruta: INICIO > Pantalla actual
  213: Rol: operacion guiada del sistema
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   $title=Read-Host "Titulo breve"
  217:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  218:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  219:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  221:   if($dimension -notin $allowedDimensions){$dimension="other"}
  222:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  223:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  224:   $severity=$severity.ToUpperInvariant()

### around line 218
  210:   Write-Host ""
  211:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  212: Ruta: INICIO > Pantalla actual
  213: Rol: operacion guiada del sistema
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   $title=Read-Host "Titulo breve"
  217:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  218:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  219:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  221:   if($dimension -notin $allowedDimensions){$dimension="other"}
  222:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  223:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  224:   $severity=$severity.ToUpperInvariant()
  225:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  226:   $observation=Read-Host "Observacion"

### around line 222
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   $title=Read-Host "Titulo breve"
  217:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  218:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  219:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  221:   if($dimension -notin $allowedDimensions){$dimension="other"}
  222:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  223:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  224:   $severity=$severity.ToUpperInvariant()
  225:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  226:   $observation=Read-Host "Observacion"
  227:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  228:   $suggested=Read-Host "Accion sugerida"
  229:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  230:   if($title.Length -gt 120){$title=$title.Substring(0,120)}

### around line 226
  218:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  219:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  221:   if($dimension -notin $allowedDimensions){$dimension="other"}
  222:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  223:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  224:   $severity=$severity.ToUpperInvariant()
  225:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  226:   $observation=Read-Host "Observacion"
  227:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  228:   $suggested=Read-Host "Accion sugerida"
  229:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  230:   if($title.Length -gt 120){$title=$title.Substring(0,120)}
  231:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  232:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  233:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  234:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}

### around line 228
  220:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  221:   if($dimension -notin $allowedDimensions){$dimension="other"}
  222:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  223:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  224:   $severity=$severity.ToUpperInvariant()
  225:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  226:   $observation=Read-Host "Observacion"
  227:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  228:   $suggested=Read-Host "Accion sugerida"
  229:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  230:   if($title.Length -gt 120){$title=$title.Substring(0,120)}
  231:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  232:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  233:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  234:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  235:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  236: }


## Router candidates
### around line 7
    1: param([string]$Root="C:\ENGREMIAT_CORE")
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""

### around line 10
    1: param([string]$Root="C:\ENGREMIAT_CORE")
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }

### around line 16
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""
   16:   if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State

### around line 27
   17:     $s.active_master_vault=""
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State

### around line 28
   18:   } else {
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level

### around line 29
   19:     $s.active_master_vault=Join-Path ([string]$s.active_project) "BOVEDA_PROYECTO"
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project

### around line 30
   20:   }
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module

### around line 32
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}

### around line 33
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}
   30:     if([string]$s.mode -eq "global"){return "GLOBAL"}
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}

### around line 41
   31:   }
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
   44:   L "UBICACION" DarkCyan
   45:   L (" Nivel:    "+$level) DarkCyan
   46:   L (" Proyecto: "+$projectName) DarkCyan
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{

### around line 42
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
   44:   L "UBICACION" DarkCyan
   45:   L (" Nivel:    "+$level) DarkCyan
   46:   L (" Proyecto: "+$projectName) DarkCyan
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State

### around line 43
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module
   41:   $projectName=if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
   42:   $moduleLabel=if($moduleName){$moduleName}else{"-"}
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
   44:   L "UBICACION" DarkCyan
   45:   L (" Nivel:    "+$level) DarkCyan
   46:   L (" Proyecto: "+$projectName) DarkCyan
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}

### around line 53
   43:   $currentPath=if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
   44:   L "UBICACION" DarkCyan
   45:   L (" Nivel:    "+$level) DarkCyan
   46:   L (" Proyecto: "+$projectName) DarkCyan
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}

### around line 56
   46:   L (" Proyecto: "+$projectName) DarkCyan
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++

### around line 58
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++
   67:   }
   68:   L ""

### around line 63
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan

### around line 64
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green

### around line 72
   62:     $status="NO_JSON";$lib=""
   63:     if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
   64:     $marker=if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
   65:     L (" ["+$i+"] "+$m.Name+"  "+$status+"  "+$lib+$marker) Green
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan

### around line 79
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan

### around line 117
  107:   L "ENGREMIAT TERMINAL OPERATOR" Cyan
  108:   L ("Workspace: "+$Root) Cyan
  109:   L "Sistema: HEALTHY" Green
  110:   L ""
  111:   Show-LocationBar
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){

### around line 118
  108:   L ("Workspace: "+$Root) Cyan
  109:   L "Sistema: HEALTHY" Green
  110:   L ""
  111:   Show-LocationBar
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}

### around line 119
  109:   L "Sistema: HEALTHY" Green
  110:   L ""
  111:   Show-LocationBar
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}

### around line 120
  110:   L ""
  111:   Show-LocationBar
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}

### around line 121
  111:   Show-LocationBar
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}

### around line 122
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {

### around line 123
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}

### around line 124
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}

### around line 125
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}

### around line 126
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}
  136:     if($x -in @("4","g")){return "gates"}

### around line 127
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}
  136:     if($x -in @("4","g")){return "gates"}
  137:     if($x -in @("5","s")){return "preparar-smoke"}


## Function boundaries
### around line 6
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}

### around line 7
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{

### around line 8
    4: $Router=Join-Path $PSScriptRoot "eng-router.ps1"
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State

### around line 9
    5: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"

### around line 10
    6: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""

### around line 11
    7: function Ensure-State{if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}}
    8: function Get-State{Ensure-State;return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
    9: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   10: function Short-Path([string]$p){if([string]::IsNullOrWhiteSpace($p)){return "-"};return $p}
   11: function Set-BootGlobalKeepContext{
   12:   $s=Get-State
   13:   $s.mode="global"
   14:   $s.active_module=""
   15:   $s.active_module_vault=""

### around line 25
   21:   $s.next="global"
   22:   $s.last_command="boot-global-keep-context"
   23:   Save-State $s
   24: }
   25: function Get-Level{
   26:   $s=Get-State
   27:   if($s -and $s.PSObject.Properties.Name -contains "mode"){
   28:     if([string]$s.mode -eq "module"){return "MODULE"}
   29:     if([string]$s.mode -eq "project"){return "PROJECT"}

### around line 36
   32:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
   33:   if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
   34:   return "GLOBAL"
   35: }
   36: function Show-LocationBar{
   37:   $s=Get-State
   38:   $level=Get-Level
   39:   $projectPath=[string]$s.active_project
   40:   $moduleName=[string]$s.active_module

### around line 51
   47:   L (" Modulo:   "+$moduleLabel) DarkCyan
   48:   L (" Ruta:     "+(Short-Path $currentPath)) DarkGray
   49:   L ""
   50: }
   51: function Show-ProjectModulesInline{
   52:   $s=Get-State
   53:   if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan

### around line 70
   66:     $i++
   67:   }
   68:   L ""
   69: }
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green

### around line 105
  101:   L ""
  102:   L "refrescar/f5/Enter = refrescar pantalla | ? = ayuda | comandos = menu actual" DarkGray
  103:   L ""
  104: }
  105: function Refresh-Screen{
  106:   Clear-Host
  107:   L "ENGREMIAT TERMINAL OPERATOR" Cyan
  108:   L ("Workspace: "+$Root) Cyan
  109:   L "Sistema: HEALTHY" Green

### around line 114
  110:   L ""
  111:   Show-LocationBar
  112:   Show-Menu
  113: }
  114: function Normalize-Command($raw){
  115:   $x=([string]$raw).Trim().ToLowerInvariant()
  116:   $level=Get-Level
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}

### around line 145
  141:     if($x -in @("9","pb","promover","promover-biblioteca")){return "promover"}
  142:   }
  143:   return $x
  144: }
  145: function Go-Back{
  146:   $level=Get-Level
  147:   $s=Get-State
  148:   if($level -eq "MODULE"){
  149:     $s.mode="project"

### around line 165
  161:     Save-State $s
  162:     return
  163:   }
  164: }
  165: function Show-Help{
  166:   L "AYUDA" Cyan
  167:   L "Enter/refrescar/f5 redibuja pantalla." Gray
  168:   L "a/b/atras vuelve al nivel anterior." Gray
  169:   L "q sale desde GLOBAL." Gray

### around line 196
  192: # Safety: approve/execute remain NO_GO in readonly adapter until explicit bridge is authorized.
  193: # ENGREMIAT_RUNTIME_UI_INTEGRATION_END
  194: 
  195: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_BEGIN
  196: function Invoke-EngremiatHumanMaintenanceCard {
  197:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-screen")
  198:   $scriptPath = Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  199:   if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
  200:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Dimension "ux" -Severity "INFO" -Title "Mantenimiento humano desde pantalla" -Description "Tarjeta creada desde comando m = mantenimiento." -Observation "Observacion humana pendiente de ampliar/evaluar por Observer." -SuggestedAction "Evaluar esta senal humana y convertirla en mejora/tarea si procede." | Enter = refrescar

### around line 208
  204: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  205: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  206: 
  207: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
  208: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  209:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  210:   Write-Host ""
  211:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  212: Ruta: INICIO > Pantalla actual


## Loop candidates
### around line 172
  166:   L "AYUDA" Cyan
  167:   L "Enter/refrescar/f5 redibuja pantalla." Gray
  168:   L "a/b/atras vuelve al nivel anterior." Gray
  169:   L "q sale desde GLOBAL." Gray
  170: }
  171: Set-BootGlobalKeepContext
  172: while($true){
  173:   Refresh-Screen
  174:   $cmd=Normalize-Command (Read-Host "ENGREMIAT")
  175:   # ENGREMIAT_ROUTE_BINDING_M_MAINTENANCE_BEGIN
  176:   
  177: if($cmd -in @("m","mant","mantenimiento")){
  178:     Invoke-EngremiatHumanMaintenanceInteractiveForm -SourceScreen "desktop-terminal-operator" -SourceContext "operator-readhost-route"


## Existing option hits
### around line 58
   54:   $modsDir=Join-Path ([string]$s.active_project) "MODULOS"
   55:   L "MODULOS" Cyan
   56:   if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
   57:   $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
   58:   if($mods.Count -eq 0){L " sin modulos" Yellow;return}
   59:   $i=1
   60:   foreach($m in $mods){
   61:     $mjPath=Join-Path $m.FullName "BOVEDA_MODULO\module.json"
   62:     $status="NO_JSON";$lib=""

### around line 74
   70: function Show-Menu{
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow

### around line 75
   71:   $level=Get-Level
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){

### around line 76
   72:   if($level -eq "GLOBAL"){
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan

### around line 77
   73:     L "GLOBAL" Cyan
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     L " [q] Salir" Yellow
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline

### around line 83
   79:   } elseif($level -eq "PROJECT"){
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow

### around line 84
   80:     L "PROYECTO" Cyan
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {

### around line 85
   81:     Show-ProjectModulesInline
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan

### around line 86
   82:     L "ACCIONES" Cyan
   83:     L " [1] Entrar en modulo   m" Green
   84:     L " [2] Crear modulo       n" Green
   85:     L " [3] Biblioteca modulos b" Green
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green

### around line 90
   86:     L " [4] Revisar proyecto   r" Green
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green

### around line 91
   87:     L " [a] Atras" Yellow
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green

### around line 92
   88:   } else {
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green

### around line 93
   89:     L "MODULO" Cyan
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green

### around line 94
   90:     L " [1] Contrato           c" Green
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green

### around line 95
   91:     L " [2] Tareas             t" Green
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow

### around line 96
   92:     L " [3] Evidencias         ev" Green
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }

### around line 97
   93:     L " [4] Gates              g" Green
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
  101:   L ""

### around line 98
   94:     L " [5] Smoke              s" Green
   95:     L " [6] Editar artefacto   ed" Green
   96:     L " [7] Definir objetivo   o" Green
   97:     L " [8] Cerrar modulo      cm" Green
   98:     L " [9] Promover biblioteca pb" Green
   99:     L " [a] Atras" Yellow
  100:   }
  101:   L ""
  102:   L "refrescar/f5/Enter = refrescar pantalla | ? = ayuda | comandos = menu actual" DarkGray

### around line 121
  117:   if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
  118:   if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}

### around line 123
  119:   if($x -in @("?","ayuda")){return "ayuda"}
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){

### around line 124
  120:   if($x -in @("q","salir","exit")){return "salir"}
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}

### around line 125
  121:   if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}

### around line 126
  122:   if($level -eq "GLOBAL"){
  123:     if($x -in @("1","p")){return "abrir-proyecto"}
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}

### around line 128
  124:     if($x -in @("2","n")){return "nuevo-proyecto"}
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {

### around line 129
  125:     if($x -eq "3"){return "proyectos"}
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}

### around line 130
  126:     if($x -in @("4","e")){return "estado"}
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}

### around line 131
  127:   } elseif($level -eq "PROJECT"){
  128:     if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}

### around line 133
  129:     if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}
  136:     if($x -in @("4","g")){return "gates"}
  137:     if($x -in @("5","s")){return "preparar-smoke"}

### around line 134
  130:     if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}
  136:     if($x -in @("4","g")){return "gates"}
  137:     if($x -in @("5","s")){return "preparar-smoke"}
  138:     if($x -in @("6","ed","editar")){return "editar"}

### around line 135
  131:     if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
  132:   } else {
  133:     if($x -in @("1","c")){return "contrato"}
  134:     if($x -in @("2","t")){return "tareas"}
  135:     if($x -in @("3","ev","e")){return "evidencias"}
  136:     if($x -in @("4","g")){return "gates"}
  137:     if($x -in @("5","s")){return "preparar-smoke"}
  138:     if($x -in @("6","ed","editar")){return "editar"}
  139:     if($x -in @("7","o","objetivo")){return "objetivo"}


## Next
E04C_PREPARE_PATCH_WITH_MANUAL_ANCHORS_FROM_AUDIT_NO_APPLY
