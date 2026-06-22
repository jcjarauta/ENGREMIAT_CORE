# E13B rollback eng-context after manual fail

## Decision
NO_GO_APPEND_FOOTER_PATTERN_ROLLED_BACK

## Resultado
- target: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-context.ps1
- backup_restored: 
C:\ENGREMIAT_CORE\backups\screen-master-template\eng-context.before-e12-screen-template-20260620-204223.ps1
- parse_before: 
True
- parse_after: 
True
- candidate_markers_after_rollback: 
False
- card: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards\MCARD-20260620-204410-eng-context-router.md

## Diagnóstico
La pantalla mostrada es PROYECTOS ACTIVOS. El candidato E11 añadió footer al final del archivo, pero no integró el router real de esa pantalla. Resultado: no aparecen encabezados/rutas/comandos comunes y los comandos no funcionan.

## Contexto detectado
### around line 5
    1: param([string]$Command="abrir-proyecto",[string]$Root="C:\ENGREMIAT_CORE")
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    5: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    6: function Desktop-Path{return [Environment]::GetFolderPath("Desktop")}
    7: function Ensure-State{
    8:   if(!(Test-Path -LiteralPath $StateFile)){
    9:     New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null
   10:     $desktop=Desktop-Path
   11:     [ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_project_parent=$desktop;project_roots=@($desktop);last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8
   12:   }
   13: }

### around line 6
    2: $ErrorActionPreference="Stop"
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    5: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    6: function Desktop-Path{return [Environment]::GetFolderPath("Desktop")}
    7: function Ensure-State{
    8:   if(!(Test-Path -LiteralPath $StateFile)){
    9:     New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null
   10:     $desktop=Desktop-Path
   11:     [ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_project_parent=$desktop;project_roots=@($desktop);last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8
   12:   }
   13: }
   14: function Get-State{Ensure-State;$s=Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json;if(!($s.PSObject.Properties.Name -contains "last_project_parent")){$s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue (Desktop-Path)};if(!($s.PSObject.Properties.Name -contains "project_roots")){$s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($s.last_project_parent)};return $s}

### around line 7
    3: [Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
    4: $StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
    5: function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
    6: function Desktop-Path{return [Environment]::GetFolderPath("Desktop")}
    7: function Ensure-State{
    8:   if(!(Test-Path -LiteralPath $StateFile)){
    9:     New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null
   10:     $desktop=Desktop-Path
   11:     [ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_project_parent=$desktop;project_roots=@($desktop);last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8
   12:   }
   13: }
   14: function Get-State{Ensure-State;$s=Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json;if(!($s.PSObject.Properties.Name -contains "last_project_parent")){$s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue (Desktop-Path)};if(!($s.PSObject.Properties.Name -contains "project_roots")){$s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($s.last_project_parent)};return $s}
   15: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}

### around line 14
   10:     $desktop=Desktop-Path
   11:     [ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_project_parent=$desktop;project_roots=@($desktop);last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8
   12:   }
   13: }
   14: function Get-State{Ensure-State;$s=Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json;if(!($s.PSObject.Properties.Name -contains "last_project_parent")){$s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue (Desktop-Path)};if(!($s.PSObject.Properties.Name -contains "project_roots")){$s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($s.last_project_parent)};return $s}
   15: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   16: function Resolve-ParentPath([string]$InputPath,[string]$DefaultParent){
   17:   $p=$InputPath.Trim()
   18:   if([string]::IsNullOrWhiteSpace($p)){$p=$DefaultParent}
   19:   $p=[Environment]::ExpandEnvironmentVariables($p)
   20:   try{return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path}catch{New-Item -ItemType Directory -Force -Path $p|Out-Null;return (Resolve-Path -LiteralPath $p).Path}
   21: }
   22: function Get-ProjectRoots{

### around line 15
   11:     [ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_project_parent=$desktop;project_roots=@($desktop);last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8
   12:   }
   13: }
   14: function Get-State{Ensure-State;$s=Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json;if(!($s.PSObject.Properties.Name -contains "last_project_parent")){$s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue (Desktop-Path)};if(!($s.PSObject.Properties.Name -contains "project_roots")){$s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($s.last_project_parent)};return $s}
   15: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   16: function Resolve-ParentPath([string]$InputPath,[string]$DefaultParent){
   17:   $p=$InputPath.Trim()
   18:   if([string]::IsNullOrWhiteSpace($p)){$p=$DefaultParent}
   19:   $p=[Environment]::ExpandEnvironmentVariables($p)
   20:   try{return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path}catch{New-Item -ItemType Directory -Force -Path $p|Out-Null;return (Resolve-Path -LiteralPath $p).Path}
   21: }
   22: function Get-ProjectRoots{
   23:   $s=Get-State

### around line 16
   12:   }
   13: }
   14: function Get-State{Ensure-State;$s=Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json;if(!($s.PSObject.Properties.Name -contains "last_project_parent")){$s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue (Desktop-Path)};if(!($s.PSObject.Properties.Name -contains "project_roots")){$s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($s.last_project_parent)};return $s}
   15: function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
   16: function Resolve-ParentPath([string]$InputPath,[string]$DefaultParent){
   17:   $p=$InputPath.Trim()
   18:   if([string]::IsNullOrWhiteSpace($p)){$p=$DefaultParent}
   19:   $p=[Environment]::ExpandEnvironmentVariables($p)
   20:   try{return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path}catch{New-Item -ItemType Directory -Force -Path $p|Out-Null;return (Resolve-Path -LiteralPath $p).Path}
   21: }
   22: function Get-ProjectRoots{
   23:   $s=Get-State
   24:   $roots=@()

### around line 22
   18:   if([string]::IsNullOrWhiteSpace($p)){$p=$DefaultParent}
   19:   $p=[Environment]::ExpandEnvironmentVariables($p)
   20:   try{return (Resolve-Path -LiteralPath $p -ErrorAction Stop).Path}catch{New-Item -ItemType Directory -Force -Path $p|Out-Null;return (Resolve-Path -LiteralPath $p).Path}
   21: }
   22: function Get-ProjectRoots{
   23:   $s=Get-State
   24:   $roots=@()
   25:   $desktop=Desktop-Path
   26:   if($desktop){$roots+=$desktop}
   27:   if($s.last_project_parent){$roots+=[string]$s.last_project_parent}
   28:   if($s.active_project -and (Test-Path -LiteralPath ([string]$s.active_project))){$roots+=(Split-Path ([string]$s.active_project) -Parent)}
   29:   if($s.PSObject.Properties.Name -contains "project_roots" -and $s.project_roots){foreach($r in @($s.project_roots)){if([string]$r){$roots+=[string]$r}}}
   30:   return @($roots|Where-Object{$_}|Sort-Object -Unique)

### around line 32
   28:   if($s.active_project -and (Test-Path -LiteralPath ([string]$s.active_project))){$roots+=(Split-Path ([string]$s.active_project) -Parent)}
   29:   if($s.PSObject.Properties.Name -contains "project_roots" -and $s.project_roots){foreach($r in @($s.project_roots)){if([string]$r){$roots+=[string]$r}}}
   30:   return @($roots|Where-Object{$_}|Sort-Object -Unique)
   31: }
   32: function Get-Projects{
   33:   $items=@()
   34:   foreach($r in Get-ProjectRoots){
   35:     if(Test-Path -LiteralPath $r){$items+=@(Get-ChildItem -LiteralPath $r -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -like "ENGREMIAT_PROJECT_*"})}
   36:   }
   37:   $s=Get-State
   38:   if($s.active_project -and (Test-Path -LiteralPath ([string]$s.active_project))){$items+=@(Get-Item -LiteralPath ([string]$s.active_project))}
   39:   return @($items|Sort-Object FullName -Unique|Sort-Object LastWriteTime -Descending)
   40: }

### around line 41
   37:   $s=Get-State
   38:   if($s.active_project -and (Test-Path -LiteralPath ([string]$s.active_project))){$items+=@(Get-Item -LiteralPath ([string]$s.active_project))}
   39:   return @($items|Sort-Object FullName -Unique|Sort-Object LastWriteTime -Descending)
   40: }
   41: function Set-Project-ParentMemory([string]$Parent){
   42:   $s=Get-State
   43:   $roots=@()
   44:   if($s.PSObject.Properties.Name -contains "project_roots" -and $s.project_roots){$roots+=@($s.project_roots)}
   45:   $roots+=$Parent
   46:   $s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue $Parent
   47:   $s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($roots|Where-Object{$_}|Sort-Object -Unique)
   48:   Save-State $s
   49: }

### around line 50
   46:   $s|Add-Member -Force -NotePropertyName last_project_parent -NotePropertyValue $Parent
   47:   $s|Add-Member -Force -NotePropertyName project_roots -NotePropertyValue @($roots|Where-Object{$_}|Sort-Object -Unique)
   48:   Save-State $s
   49: }
   50: function New-Project{
   51:   param([string]$Name)
   52:   $s=Get-State
   53:   if([string]::IsNullOrWhiteSpace($Name)){$Name="nuevo-proyecto"}
   54:   $safe=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-")
   55:   if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"}
   56:   $desktop=Desktop-Path
   57:   $remembered=$desktop
   58:   if($s.last_project_parent -and (Test-Path -LiteralPath ([string]$s.last_project_parent))){$remembered=[string]$s.last_project_parent}

### around line 53
   49: }
   50: function New-Project{
   51:   param([string]$Name)
   52:   $s=Get-State
   53:   if([string]::IsNullOrWhiteSpace($Name)){$Name="nuevo-proyecto"}
   54:   $safe=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-")
   55:   if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"}
   56:   $desktop=Desktop-Path
   57:   $remembered=$desktop
   58:   if($s.last_project_parent -and (Test-Path -LiteralPath ([string]$s.last_project_parent))){$remembered=[string]$s.last_project_parent}
   59:   $templateSource=""
   60:   if($s.PSObject.Properties.Name -contains "current_template_source" -and [string]$s.current_template_source -and (Test-Path -LiteralPath ([string]$s.current_template_source))){$templateSource=[string]$s.current_template_source}
   61:   while($true){

### around line 55
   51:   param([string]$Name)
   52:   $s=Get-State
   53:   if([string]::IsNullOrWhiteSpace($Name)){$Name="nuevo-proyecto"}
   54:   $safe=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-")
   55:   if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"}
   56:   $desktop=Desktop-Path
   57:   $remembered=$desktop
   58:   if($s.last_project_parent -and (Test-Path -LiteralPath ([string]$s.last_project_parent))){$remembered=[string]$s.last_project_parent}
   59:   $templateSource=""
   60:   if($s.PSObject.Properties.Name -contains "current_template_source" -and [string]$s.current_template_source -and (Test-Path -LiteralPath ([string]$s.current_template_source))){$templateSource=[string]$s.current_template_source}
   61:   while($true){
   62:     Clear-Host
   63:     L "CREAR PROYECTO DESDE PLANTILLA MAESTRA ORIGINAL" Cyan

### around line 61
   57:   $remembered=$desktop
   58:   if($s.last_project_parent -and (Test-Path -LiteralPath ([string]$s.last_project_parent))){$remembered=[string]$s.last_project_parent}
   59:   $templateSource=""
   60:   if($s.PSObject.Properties.Name -contains "current_template_source" -and [string]$s.current_template_source -and (Test-Path -LiteralPath ([string]$s.current_template_source))){$templateSource=[string]$s.current_template_source}
   61:   while($true){
   62:     Clear-Host
   63:     L "CREAR PROYECTO DESDE PLANTILLA MAESTRA ORIGINAL" Cyan
   64:     L ("Nombre:           "+$safe) Gray
   65:     L ("Ruta recordada:   "+$remembered) Green
   66:     L ("Plantilla origen: "+$(if($templateSource){$templateSource}else{"NO_CONFIGURADA"})) Yellow
   67:     L ""
   68:     if([string]::IsNullOrWhiteSpace($templateSource)){throw "current_template_source_not_configured"}
   69:     L "Indica carpeta BASE donde se creara la carpeta ENGREMIAT_PROJECT_*." DarkCyan

### around line 72
   68:     if([string]::IsNullOrWhiteSpace($templateSource)){throw "current_template_source_not_configured"}
   69:     L "Indica carpeta BASE donde se creara la carpeta ENGREMIAT_PROJECT_*." DarkCyan
   70:     L "Enter = usar ruta recordada | . = workspace actual | escritorio = Escritorio | ruta absoluta = usar esa ruta" DarkGray
   71:     L ""
   72:     $parentRaw=(Read-Host "Carpeta base").Trim()
   73:     if([string]::IsNullOrWhiteSpace($parentRaw)){$parentRaw=$remembered}
   74:     if($parentRaw -eq "."){$parentRaw=$Root}
   75:     if($parentRaw.ToLowerInvariant() -eq "escritorio"){$parentRaw=$desktop}
   76:     $parentRaw=[Environment]::ExpandEnvironmentVariables($parentRaw)
   77:     if(![System.IO.Path]::IsPathRooted($parentRaw)){$parentRaw=Join-Path $Root $parentRaw}
   78:     if(!(Test-Path -LiteralPath $parentRaw)){L ("WARN ruta no existe, se creara: "+$parentRaw) Yellow;New-Item -ItemType Directory -Force -Path $parentRaw|Out-Null}
   79:     $parent=(Resolve-Path -LiteralPath $parentRaw).Path
   80:     $projectName="ENGREMIAT_PROJECT_"+$safe+"_"+(Get-Date -Format "yyyyMMdd-HHmmss")

### around line 86
   82:     L ""
   83:     L "DESTINO FINAL DEL PROYECTO" Cyan
   84:     L $p Green
   85:     L ""
   86:     $ok=(Read-Host "Crear aqui usando plantilla maestra original? Enter/s = si | n = cambiar ruta").Trim().ToLowerInvariant()
   87:     if($ok -in @("n","no","cambiar","c")){continue}
   88:     $vault=Join-Path $p "BOVEDA_PROYECTO"
   89:     $mods=Join-Path $p "MODULOS"
   90:     $archivos=Join-Path $p "ARCHIVOS"
   91:     $plantillas=Join-Path $archivos "PLANTILLAS"
   92:     $dest=Join-Path $plantillas "OBSIDIAN_REAL_TEMPLATE_PACKAGE"
   93:     $sourceName=Split-Path $templateSource -Leaf
   94:     $destVault=Join-Path $dest $sourceName

### around line 129
  125:     Start-Sleep -Milliseconds 1200
  126:     return $p
  127:   }
  128: }
  129: function Set-Project-State([string]$Project){$s=Get-State;$s.mode="project";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="abrir-proyecto";$s.next="proyecto";Save-State $s}
  130: function Set-Module-State([string]$Project,[string]$ModulePath,[string]$ModuleName,[string]$LastCommand){$s=Get-State;$s.mode="module";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module=$ModuleName;$s.active_module_vault=Join-Path $ModulePath "BOVEDA_MODULO";$s.last_command=$LastCommand;$s.next="modulo";Save-State $s}
  131: function Back-To-Global{$s=Get-State;$s.mode="global";$s.active_module="";$s.active_module_vault="";$s.last_command="back-global";$s.next="global";Save-State $s}
  132: function Clean-StaleActiveProject{
  133:   $s=Get-State
  134:   $active=[string]$s.active_project
  135:   if($active -and !(Test-Path -LiteralPath $active)){
  136:     L ("WARN active_project borrado, limpiando estado: "+$active) Yellow
  137:     $s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="clean-stale-active-project";Save-State $s

### around line 130
  126:     return $p
  127:   }
  128: }
  129: function Set-Project-State([string]$Project){$s=Get-State;$s.mode="project";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="abrir-proyecto";$s.next="proyecto";Save-State $s}
  130: function Set-Module-State([string]$Project,[string]$ModulePath,[string]$ModuleName,[string]$LastCommand){$s=Get-State;$s.mode="module";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module=$ModuleName;$s.active_module_vault=Join-Path $ModulePath "BOVEDA_MODULO";$s.last_command=$LastCommand;$s.next="modulo";Save-State $s}
  131: function Back-To-Global{$s=Get-State;$s.mode="global";$s.active_module="";$s.active_module_vault="";$s.last_command="back-global";$s.next="global";Save-State $s}
  132: function Clean-StaleActiveProject{
  133:   $s=Get-State
  134:   $active=[string]$s.active_project
  135:   if($active -and !(Test-Path -LiteralPath $active)){
  136:     L ("WARN active_project borrado, limpiando estado: "+$active) Yellow
  137:     $s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="clean-stale-active-project";Save-State $s
  138:     return ""

### around line 131
  127:   }
  128: }
  129: function Set-Project-State([string]$Project){$s=Get-State;$s.mode="project";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="abrir-proyecto";$s.next="proyecto";Save-State $s}
  130: function Set-Module-State([string]$Project,[string]$ModulePath,[string]$ModuleName,[string]$LastCommand){$s=Get-State;$s.mode="module";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module=$ModuleName;$s.active_module_vault=Join-Path $ModulePath "BOVEDA_MODULO";$s.last_command=$LastCommand;$s.next="modulo";Save-State $s}
  131: function Back-To-Global{$s=Get-State;$s.mode="global";$s.active_module="";$s.active_module_vault="";$s.last_command="back-global";$s.next="global";Save-State $s}
  132: function Clean-StaleActiveProject{
  133:   $s=Get-State
  134:   $active=[string]$s.active_project
  135:   if($active -and !(Test-Path -LiteralPath $active)){
  136:     L ("WARN active_project borrado, limpiando estado: "+$active) Yellow
  137:     $s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="clean-stale-active-project";Save-State $s
  138:     return ""
  139:   }

### around line 132
  128: }
  129: function Set-Project-State([string]$Project){$s=Get-State;$s.mode="project";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module="";$s.active_module_vault="";$s.last_command="abrir-proyecto";$s.next="proyecto";Save-State $s}
  130: function Set-Module-State([string]$Project,[string]$ModulePath,[string]$ModuleName,[string]$LastCommand){$s=Get-State;$s.mode="module";$s.active_project=$Project;$s.active_master_vault=Join-Path $Project "BOVEDA_PROYECTO";$s.active_module=$ModuleName;$s.active_module_vault=Join-Path $ModulePath "BOVEDA_MODULO";$s.last_command=$LastCommand;$s.next="modulo";Save-State $s}
  131: function Back-To-Global{$s=Get-State;$s.mode="global";$s.active_module="";$s.active_module_vault="";$s.last_command="back-global";$s.next="global";Save-State $s}
  132: function Clean-StaleActiveProject{
  133:   $s=Get-State
  134:   $active=[string]$s.active_project
  135:   if($active -and !(Test-Path -LiteralPath $active)){
  136:     L ("WARN active_project borrado, limpiando estado: "+$active) Yellow
  137:     $s.mode="global";$s.active_project="";$s.active_master_vault="";$s.active_module="";$s.active_module_vault="";$s.next="global";$s.last_command="clean-stale-active-project";Save-State $s
  138:     return ""
  139:   }
  140:   return $active

### around line 142
  138:     return ""
  139:   }
  140:   return $active
  141: }
  142: function Select-Project {
  143:   $manager = "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1"
  144:   if(Test-Path -LiteralPath $manager){
  145:     & powershell -NoProfile -ExecutionPolicy Bypass -File $manager
  146:     return
  147:   }
  148:   Write-Host ""
  149:   Write-Host "==== NO_GO ====" -ForegroundColor Yellow
  150:   Write-Host "No se encuentra el gestor de proyectos: $manager" -ForegroundColor Yellow

### around line 151
  147:   }
  148:   Write-Host ""
  149:   Write-Host "==== NO_GO ====" -ForegroundColor Yellow
  150:   Write-Host "No se encuentra el gestor de proyectos: $manager" -ForegroundColor Yellow
  151:   Read-Host "Enter para volver"
  152: }
  153: function Show-Projects{
  154:   while($true){
  155:     Clear-Host
  156:     L "PROYECTOS" Cyan
  157:     $active=Clean-StaleActiveProject
  158:     $projects=@(Get-Projects)
  159:     if($projects.Count -eq 0){L "sin proyectos detectados" Yellow}else{

### around line 153
  149:   Write-Host "==== NO_GO ====" -ForegroundColor Yellow
  150:   Write-Host "No se encuentra el gestor de proyectos: $manager" -ForegroundColor Yellow
  151:   Read-Host "Enter para volver"
  152: }
  153: function Show-Projects{
  154:   while($true){
  155:     Clear-Host
  156:     L "PROYECTOS" Cyan
  157:     $active=Clean-StaleActiveProject
  158:     $projects=@(Get-Projects)
  159:     if($projects.Count -eq 0){L "sin proyectos detectados" Yellow}else{
  160:       $i=1
  161:       foreach($p in $projects){

### around line 154
  150:   Write-Host "No se encuentra el gestor de proyectos: $manager" -ForegroundColor Yellow
  151:   Read-Host "Enter para volver"
  152: }
  153: function Show-Projects{
  154:   while($true){
  155:     Clear-Host
  156:     L "PROYECTOS" Cyan
  157:     $active=Clean-StaleActiveProject
  158:     $projects=@(Get-Projects)
  159:     if($projects.Count -eq 0){L "sin proyectos detectados" Yellow}else{
  160:       $i=1
  161:       foreach($p in $projects){
  162:         $kind=if($active -and ([string]$p.FullName -eq $active)){"ACTIVO"}else{"HISTORICO"}

### around line 162
  158:     $projects=@(Get-Projects)
  159:     if($projects.Count -eq 0){L "sin proyectos detectados" Yellow}else{
  160:       $i=1
  161:       foreach($p in $projects){
  162:         $kind=if($active -and ([string]$p.FullName -eq $active)){"ACTIVO"}else{"HISTORICO"}
  163:         $color=if($kind -eq "ACTIVO"){"Green"}else{"DarkGray"}
  164:         L (" ["+$i+"] "+$p.Name+"  "+$p.LastWriteTime.ToString("yyyy-MM-dd HH:mm")+"  "+$kind) $color
  165:         $i++
  166:       }
  167:     }
  168:     L " [b] Atras" Yellow
  169:     L ""
  170:     L "refrescar/f5/Enter = redibujar pantalla | numero = entrar | b/atras = volver" DarkGray

### around line 172
  168:     L " [b] Atras" Yellow
  169:     L ""
  170:     L "refrescar/f5/Enter = redibujar pantalla | numero = entrar | b/atras = volver" DarkGray
  171:     L ""
  172:     $sel=(Read-Host "ENGREMIAT").Trim().ToLowerInvariant()
  173:     if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
  174:     if($sel -in @("b","a","atras","atrás","volver","back","0")){return}
  175:     if(!($sel -match "^\d+$")){continue}
  176:     $idx=[int]$sel-1
  177:     if($idx -lt 0 -or $idx -ge $projects.Count){continue}
  178:     Set-Project-State ([string]$projects[$idx].FullName)
  179:     return
  180:   }

### around line 182
  178:     Set-Project-State ([string]$projects[$idx].FullName)
  179:     return
  180:   }
  181: }
  182: function Select-Module{
  183:   param([switch]$Create)
  184:   $s=Get-State
  185:   $project=[string]$s.active_project
  186:   if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "no_active_project"}
  187:   $modsDir=Join-Path $project "MODULOS"
  188:   New-Item -ItemType Directory -Force -Path $modsDir|Out-Null
  189:   if($Create){
  190:     while($true){

### around line 183
  179:     return
  180:   }
  181: }
  182: function Select-Module{
  183:   param([switch]$Create)
  184:   $s=Get-State
  185:   $project=[string]$s.active_project
  186:   if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "no_active_project"}
  187:   $modsDir=Join-Path $project "MODULOS"
  188:   New-Item -ItemType Directory -Force -Path $modsDir|Out-Null
  189:   if($Create){
  190:     while($true){
  191:       Clear-Host

### around line 190
  186:   if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "no_active_project"}
  187:   $modsDir=Join-Path $project "MODULOS"
  188:   New-Item -ItemType Directory -Force -Path $modsDir|Out-Null
  189:   if($Create){
  190:     while($true){
  191:       Clear-Host
  192:       L "CREAR MODULO" Cyan
  193:       L "Solo comandos de este paso: nombre = crear | b = atras" DarkCyan
  194:       L " [b] Atras" Yellow
  195:       L ""
  196:       L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | texto = crear modulo" DarkGray
  197:       L ""
  198:       $name=(Read-Host "Nombre del modulo").Trim()

### around line 198
  194:       L " [b] Atras" Yellow
  195:       L ""
  196:       L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | texto = crear modulo" DarkGray
  197:       L ""
  198:       $name=(Read-Host "Nombre del modulo").Trim()
  199:       $x=$name.ToLowerInvariant()
  200:       if([string]::IsNullOrWhiteSpace($name) -or $x -in @("refrescar","refresh","f5","menu","comandos")){continue}
  201:       if($x -in @("b","a","atras","atrás","volver","back","..","0")){return}
  202:       $safe=($name -replace "[^a-zA-Z0-9_-]","_")
  203:       if($safe -notlike "MODULE_*"){$safe="MODULE_"+$safe}
  204:       $modulePath=Join-Path $modsDir $safe
  205:       New-Item -ItemType Directory -Force -Path (Join-Path $modulePath "BOVEDA_MODULO")|Out-Null
  206:       $mj=Join-Path $modulePath "BOVEDA_MODULO\module.json"

### around line 208
  204:       $modulePath=Join-Path $modsDir $safe
  205:       New-Item -ItemType Directory -Force -Path (Join-Path $modulePath "BOVEDA_MODULO")|Out-Null
  206:       $mj=Join-Path $modulePath "BOVEDA_MODULO\module.json"
  207:       if(!(Test-Path $mj)){[ordered]@{module=$safe;lifecycle="ACTIVE_IN_PROJECT";library_status="NOT_READY";objective="";created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $mj -Encoding UTF8}
  208:       Set-Module-State $project $modulePath $safe "nuevo-modulo"
  209:       return
  210:     }
  211:   }
  212:   while($true){
  213:     Clear-Host
  214:     L "ENTRAR EN MODULO" Cyan
  215:     L "Solo comandos de este paso: numero = entrar | b = atras" DarkCyan
  216:     $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)

### around line 212
  208:       Set-Module-State $project $modulePath $safe "nuevo-modulo"
  209:       return
  210:     }
  211:   }
  212:   while($true){
  213:     Clear-Host
  214:     L "ENTRAR EN MODULO" Cyan
  215:     L "Solo comandos de este paso: numero = entrar | b = atras" DarkCyan
  216:     $mods=@(Get-ChildItem -LiteralPath $modsDir -Directory -ErrorAction SilentlyContinue|Where-Object{$_.Name -ne ".obsidian"}|Sort-Object Name)
  217:     if($mods.Count -eq 0){L "sin modulos" Yellow}else{$i=1;foreach($m in $mods){L (" ["+$i+"] "+$m.Name) Green;$i++}}
  218:     L " [b] Atras" Yellow
  219:     L ""
  220:     L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | numero = entrar" DarkGray

### around line 222
  218:     L " [b] Atras" Yellow
  219:     L ""
  220:     L "refrescar/f5/Enter = redibujar pantalla | b/atras = volver | numero = entrar" DarkGray
  221:     L ""
  222:     $sel=(Read-Host "Elige modulo").Trim().ToLowerInvariant()
  223:     if([string]::IsNullOrWhiteSpace($sel) -or $sel -in @("refrescar","refresh","f5","menu","comandos")){continue}
  224:     if($sel -in @("b","a","atras","atrás","volver","back","..","0")){return}
  225:     if(!($sel -match "^\d+$")){continue}
  226:     $idx=[int]$sel-1
  227:     if($idx -lt 0 -or $idx -ge $mods.Count){continue}
  228:     Set-Module-State $project ([string]$mods[$idx].FullName) ([string]$mods[$idx].Name) "abrir-modulo"
  229:     return
  230:   }

### around line 233
  229:     return
  230:   }
  231: }
  232: $cmd=$Command.Trim().ToLowerInvariant()
  233: if($cmd -in @("open-project","project-open")){$cmd="abrir-proyecto"}elseif($cmd -in @("new-project","create-project","project-new","project-create")){$cmd="nuevo-proyecto"}elseif($cmd -in @("projects","proyectos","ver-proyectos","list-projects","project-list")){$cmd="projects"}elseif($cmd -in @("open-module","enter-module","module-open","module-enter","entrar-modulo")){$cmd="abrir-modulo"}elseif($cmd -in @("new-module","create-module","module-new","module-create","crear-modulo")){$cmd="nuevo-modulo"}
  234: if($cmd -eq "abrir-proyecto"){Select-Project;exit}
  235: if($cmd -eq "nuevo-proyecto"){$name=Read-Host "Nombre del proyecto";$p=New-Project $name;Set-Project-State $p;exit}
  236: if($cmd -eq "projects"){Show-Projects;exit}
  237: if($cmd -eq "abrir-modulo"){Select-Module;exit}
  238: if($cmd -eq "nuevo-modulo"){Select-Module -Create;exit}
  239: L ("WARN comando_contexto_no_soportado="+$cmd) Yellow
  240: exit 1
  241: 

### around line 235
  231: }
  232: $cmd=$Command.Trim().ToLowerInvariant()
  233: if($cmd -in @("open-project","project-open")){$cmd="abrir-proyecto"}elseif($cmd -in @("new-project","create-project","project-new","project-create")){$cmd="nuevo-proyecto"}elseif($cmd -in @("projects","proyectos","ver-proyectos","list-projects","project-list")){$cmd="projects"}elseif($cmd -in @("open-module","enter-module","module-open","module-enter","entrar-modulo")){$cmd="abrir-modulo"}elseif($cmd -in @("new-module","create-module","module-new","module-create","crear-modulo")){$cmd="nuevo-modulo"}
  234: if($cmd -eq "abrir-proyecto"){Select-Project;exit}
  235: if($cmd -eq "nuevo-proyecto"){$name=Read-Host "Nombre del proyecto";$p=New-Project $name;Set-Project-State $p;exit}
  236: if($cmd -eq "projects"){Show-Projects;exit}
  237: if($cmd -eq "abrir-modulo"){Select-Module;exit}
  238: if($cmd -eq "nuevo-modulo"){Select-Module -Create;exit}
  239: L ("WARN comando_contexto_no_soportado="+$cmd) Yellow
  240: exit 1
  241: 
  242: 
  243: # ENGREMIAT_E02E_PROJECTS_MANAGER_ROUTE

### around line 238
  234: if($cmd -eq "abrir-proyecto"){Select-Project;exit}
  235: if($cmd -eq "nuevo-proyecto"){$name=Read-Host "Nombre del proyecto";$p=New-Project $name;Set-Project-State $p;exit}
  236: if($cmd -eq "projects"){Show-Projects;exit}
  237: if($cmd -eq "abrir-modulo"){Select-Module;exit}
  238: if($cmd -eq "nuevo-modulo"){Select-Module -Create;exit}
  239: L ("WARN comando_contexto_no_soportado="+$cmd) Yellow
  240: exit 1
  241: 
  242: 
  243: # ENGREMIAT_E02E_PROJECTS_MANAGER_ROUTE
  244: function Invoke-EngremiatProjectsManager {
  245:   $manager = "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1"
  246:   if(Test-Path -LiteralPath $manager){

### around line 244
  240: exit 1
  241: 
  242: 
  243: # ENGREMIAT_E02E_PROJECTS_MANAGER_ROUTE
  244: function Invoke-EngremiatProjectsManager {
  245:   $manager = "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1"
  246:   if(Test-Path -LiteralPath $manager){
  247:     & powershell -NoProfile -ExecutionPolicy Bypass -File $manager
  248:     return
  249:   }
  250:   Write-Host "NO_GO manager missing: $manager" -ForegroundColor Yellow
  251:   Read-Host "Enter para volver"
  252: }

### around line 251
  247:     & powershell -NoProfile -ExecutionPolicy Bypass -File $manager
  248:     return
  249:   }
  250:   Write-Host "NO_GO manager missing: $manager" -ForegroundColor Yellow
  251:   Read-Host "Enter para volver"
  252: }
  253: function Show-EngremiatProjects { Invoke-EngremiatProjectsManager }
  254: function Show-Projects { Invoke-EngremiatProjectsManager }
  255: function Invoke-ProjectsView { Invoke-EngremiatProjectsManager }

### around line 253
  249:   }
  250:   Write-Host "NO_GO manager missing: $manager" -ForegroundColor Yellow
  251:   Read-Host "Enter para volver"
  252: }
  253: function Show-EngremiatProjects { Invoke-EngremiatProjectsManager }
  254: function Show-Projects { Invoke-EngremiatProjectsManager }
  255: function Invoke-ProjectsView { Invoke-EngremiatProjectsManager }

### around line 254
  250:   Write-Host "NO_GO manager missing: $manager" -ForegroundColor Yellow
  251:   Read-Host "Enter para volver"
  252: }
  253: function Show-EngremiatProjects { Invoke-EngremiatProjectsManager }
  254: function Show-Projects { Invoke-EngremiatProjectsManager }
  255: function Invoke-ProjectsView { Invoke-EngremiatProjectsManager }

### around line 255
  251:   Read-Host "Enter para volver"
  252: }
  253: function Show-EngremiatProjects { Invoke-EngremiatProjectsManager }
  254: function Show-Projects { Invoke-EngremiatProjectsManager }
  255: function Invoke-ProjectsView { Invoke-EngremiatProjectsManager }


## Next
E14_AUDIT_REAL_PROJECTS_ACTIVE_ROUTER_NO_APPLY
