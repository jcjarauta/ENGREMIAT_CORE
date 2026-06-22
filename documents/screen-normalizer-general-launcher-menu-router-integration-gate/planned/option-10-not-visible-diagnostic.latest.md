# E08B option 10 not visible diagnostic no apply

## Decision
NO_GO_OPTION_10_NOT_IN_VISIBLE_GLOBAL_MENU

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Checks
- launcher_parse: 
True
- option10_hits_count: 
2
- global_hits_count: 
15
- visible_menu_hits_count: 
5
- read_hits_count: 
9
- visible_menu_block_start: 
74
- visible_menu_block_end: 
78
- option10_inside_visible_block: 
False

## Manual evidence
El operador abierto no muestra [10]. Menu visible actual: [1], [2], [3], [4], [q].

## Rule
NO_APPLY. Este paso solo diagnostica. No modifica launcher, adapter ni git.

## Visible menu lines
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


## Option 10 hits
### around line 216
  208: function Invoke-EngremiatHumanMaintenanceInteractiveForm {
  209:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  210:   Write-Host ""
  211:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  212: Ruta: INICIO > Pantalla actual
  213: Rol: operacion guiada del sistema
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  217:   $title=Read-Host "Titulo breve"
  218:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  219:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  220:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  221:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}

### around line 230
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  225:   $severity=$severity.ToUpperInvariant()
  226:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  227:   $observation=Read-Host "Observacion"
  228:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  229:   $suggested=Read-Host "Accion sugerida"
  230:   if ($suggested -eq '10') {
  231:     $adapter = Join-Path $PSScriptRoot "screen-normalizer-general-launcher-adapter.ps1"
  232:     if (Test-Path $adapter) {
  233:       & powershell -NoProfile -ExecutionPolicy Bypass -File $adapter
  234:     } else {
  235:       Write-Host "Screen normalizer adapter pendiente de conectar." -ForegroundColor Yellow
  236:       Write-Host "Ruta esperada: $adapter" -ForegroundColor DarkGray
  237:     }
  238:     return


## GLOBAL hits
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

### around line 122
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

### around line 157
  149:     $s.mode="project"
  150:     $s.active_module=""
  151:     $s.active_module_vault=""
  152:     $s.next="proyecto"
  153:     Save-State $s
  154:     return
  155:   }
  156:   if($level -eq "PROJECT"){
  157:     $s.mode="global"
  158:     $s.active_module=""
  159:     $s.active_module_vault=""
  160:     $s.next="global"
  161:     Save-State $s
  162:     return
  163:   }
  164: }
  165: function Show-Help{

### around line 160
  152:     $s.next="proyecto"
  153:     Save-State $s
  154:     return
  155:   }
  156:   if($level -eq "PROJECT"){
  157:     $s.mode="global"
  158:     $s.active_module=""
  159:     $s.active_module_vault=""
  160:     $s.next="global"
  161:     Save-State $s
  162:     return
  163:   }
  164: }
  165: function Show-Help{
  166:   L "AYUDA" Cyan
  167:   L "Enter/refrescar/f5 redibuja pantalla." Gray
  168:   L "a/b/atras vuelve al nivel anterior." Gray

### around line 169
  161:     Save-State $s
  162:     return
  163:   }
  164: }
  165: function Show-Help{
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

### around line 171
  163:   }
  164: }
  165: function Show-Help{
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


## Read/input hits
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

### around line 217
  209:   param([string]$SourceScreen="desktop-terminal-operator",[string]$SourceContext="operator-interactive-form")
  210:   Write-Host ""
  211:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  212: Ruta: INICIO > Pantalla actual
  213: Rol: operacion guiada del sistema
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  217:   $title=Read-Host "Titulo breve"
  218:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  219:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  220:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  221:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  225:   $severity=$severity.ToUpperInvariant()

### around line 219
  211:   Write-Host "==== MANTENIMIENTO HUMANO ====" -ForegroundColor Cyan
  212: Ruta: INICIO > Pantalla actual
  213: Rol: operacion guiada del sistema
  214: Principio: contexto visible | acciones claras | mantenimiento humano disponible
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  217:   $title=Read-Host "Titulo breve"
  218:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  219:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  220:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  221:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  225:   $severity=$severity.ToUpperInvariant()
  226:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  227:   $observation=Read-Host "Observacion"

### around line 223
  215:   Write-Host "Deja un campo vacio para usar valor por defecto." -ForegroundColor DarkGray
  216:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan
  217:   $title=Read-Host "Titulo breve"
  218:   if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
  219:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  220:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  221:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  225:   $severity=$severity.ToUpperInvariant()
  226:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  227:   $observation=Read-Host "Observacion"
  228:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  229:   $suggested=Read-Host "Accion sugerida"
  230:   if ($suggested -eq '10') {
  231:     $adapter = Join-Path $PSScriptRoot "screen-normalizer-general-launcher-adapter.ps1"

### around line 227
  219:   $dimension=Read-Host "Dimension [ux/software/architecture/documentation/security/hardware/humans/financing/growth/governance/operations/workers/other]"
  220:   if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
  221:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  225:   $severity=$severity.ToUpperInvariant()
  226:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  227:   $observation=Read-Host "Observacion"
  228:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  229:   $suggested=Read-Host "Accion sugerida"
  230:   if ($suggested -eq '10') {
  231:     $adapter = Join-Path $PSScriptRoot "screen-normalizer-general-launcher-adapter.ps1"
  232:     if (Test-Path $adapter) {
  233:       & powershell -NoProfile -ExecutionPolicy Bypass -File $adapter
  234:     } else {
  235:       Write-Host "Screen normalizer adapter pendiente de conectar." -ForegroundColor Yellow

### around line 229
  221:   $allowedDimensions=@("ux","software","architecture","documentation","security","hardware","humans","financing","growth","governance","operations","workers","other")
  222:   if($dimension -notin $allowedDimensions){$dimension="other"}
  223:   $severity=Read-Host "Severidad [LOW/MEDIUM/HIGH/CRITICAL]"
  224:   if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
  225:   $severity=$severity.ToUpperInvariant()
  226:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  227:   $observation=Read-Host "Observacion"
  228:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
  229:   $suggested=Read-Host "Accion sugerida"
  230:   if ($suggested -eq '10') {
  231:     $adapter = Join-Path $PSScriptRoot "screen-normalizer-general-launcher-adapter.ps1"
  232:     if (Test-Path $adapter) {
  233:       & powershell -NoProfile -ExecutionPolicy Bypass -File $adapter
  234:     } else {
  235:       Write-Host "Screen normalizer adapter pendiente de conectar." -ForegroundColor Yellow
  236:       Write-Host "Ruta esperada: $adapter" -ForegroundColor DarkGray
  237:     }

### around line 240
  232:     if (Test-Path $adapter) {
  233:       & powershell -NoProfile -ExecutionPolicy Bypass -File $adapter
  234:     } else {
  235:       Write-Host "Screen normalizer adapter pendiente de conectar." -ForegroundColor Yellow
  236:       Write-Host "Ruta esperada: $adapter" -ForegroundColor DarkGray
  237:     }
  238:     return
  239:   }
  240:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  241:   if($title.Length -gt 120){$title=$title.Substring(0,120)}
  242:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  243:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  244:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  245:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  246:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  247: }
  248: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END

### around line 243
  235:       Write-Host "Screen normalizer adapter pendiente de conectar." -ForegroundColor Yellow
  236:       Write-Host "Ruta esperada: $adapter" -ForegroundColor DarkGray
  237:     }
  238:     return
  239:   }
  240:   if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
  241:   if($title.Length -gt 120){$title=$title.Substring(0,120)}
  242:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  243:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  244:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  245:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  246:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  247: }
  248: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END
  249: 
  250: 


## Next
E08C_REPAIR_OPTION_10_VISIBLE_GLOBAL_MENU_ON_PLANNED_COPY_NO_APPLY
