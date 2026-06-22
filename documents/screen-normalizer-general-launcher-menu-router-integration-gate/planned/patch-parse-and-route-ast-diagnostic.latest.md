# E04D parse and route AST diagnostic no apply

## Decision
GO_DIAGNOSTIC_READY_NO_APPLY

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Baseline
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.menu-router-planned.latest.ps1

## Free option
10

## Previous anchors
- menu_line: 
215
- input_line: 
228
- router_line: 
234

## AST route hints
- if lines 7-7 :: if(!(Test-Path -LiteralPath $StateFile)){New-Item -ItemType Directory -Force -Path (Split-Path $StateFile -Parent)|Out-Null;[ordered]@{mode="global";active_project="";active_master_vault="";active_module="";active_module_vault="";historical_projects=@();last_command="init";next="global";updated_at=(Get-Date).ToString("s");safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false}}|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
- if lines 10-10 :: if([string]::IsNullOrWhiteSpace($p)){return "-"}
- if lines 16-20 :: if([string]::IsNullOrWhiteSpace([string]$s.active_project)){
- if lines 27-31 :: if($s -and $s.PSObject.Properties.Name -contains "mode"){
- if lines 28-28 :: if([string]$s.mode -eq "module"){return "MODULE"}
- if lines 29-29 :: if([string]$s.mode -eq "project"){return "PROJECT"}
- if lines 30-30 :: if([string]$s.mode -eq "global"){return "GLOBAL"}
- if lines 32-32 :: if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_module)){return "MODULE"}
- if lines 33-33 :: if($s -and ![string]::IsNullOrWhiteSpace([string]$s.active_project)){return "PROJECT"}
- if lines 41-41 :: if($projectPath -and (Test-Path -LiteralPath $projectPath)){Split-Path $projectPath -Leaf}elseif($projectPath){"BORRADO: "+$projectPath}else{"-"}
- if lines 42-42 :: if($moduleName){$moduleName}else{"-"}
- if lines 43-43 :: if($level -eq "MODULE" -and $s.active_module_vault){[string]$s.active_module_vault}elseif($projectPath){$projectPath}else{$Root}
- if lines 53-53 :: if(!$s -or [string]::IsNullOrWhiteSpace([string]$s.active_project)){return}
- if lines 56-56 :: if(!(Test-Path -LiteralPath $modsDir)){L " sin carpeta MODULOS" Yellow;return}
- if lines 58-58 :: if($mods.Count -eq 0){L " sin modulos" Yellow;return}
- if lines 63-63 :: if(Test-Path -LiteralPath $mjPath){try{$mj=Get-Content -LiteralPath $mjPath -Raw -Encoding UTF8|ConvertFrom-Json;$status=[string]$mj.lifecycle;$lib=[string]$mj.library_status}catch{$status="INVALID_JSON"}}
- if lines 64-64 :: if([string]$m.Name -eq [string](Get-State).active_module){" <== ACTUAL"}else{""}
- if lines 72-100 :: if($level -eq "GLOBAL"){
- if lines 117-117 :: if([string]::IsNullOrWhiteSpace($x)){return "__refresh__"}
- if lines 118-118 :: if($x -in @("refrescar","refresh","f5","menu","comandos")){return "__refresh__"}
- if lines 119-119 :: if($x -in @("?","ayuda")){return "ayuda"}
- if lines 120-120 :: if($x -in @("q","salir","exit")){return "salir"}
- if lines 121-121 :: if($x -in @("a","atras","atrás","volver","back","..","0")){return "atras"}
- if lines 122-142 :: if($level -eq "GLOBAL"){
- if lines 123-123 :: if($x -in @("1","p")){return "abrir-proyecto"}
- if lines 124-124 :: if($x -in @("2","n")){return "nuevo-proyecto"}
- if lines 125-125 :: if($x -eq "3"){return "proyectos"}
- if lines 126-126 :: if($x -in @("4","e")){return "estado"}
- if lines 128-128 :: if($x -in @("1","m","entrar-modulo","abrir-modulo")){return "abrir-modulo"}
- if lines 129-129 :: if($x -in @("2","n","nuevo-modulo")){return "nuevo-modulo"}
- if lines 130-130 :: if($x -in @("3","b","biblioteca","biblioteca-modulos","importar-modulo")){return "biblioteca"}
- if lines 131-131 :: if($x -in @("4","r","revisar-proyecto")){return "revisar-proyecto"}
- if lines 133-133 :: if($x -in @("1","c")){return "contrato"}
- if lines 134-134 :: if($x -in @("2","t")){return "tareas"}
- if lines 135-135 :: if($x -in @("3","ev","e")){return "evidencias"}
- if lines 136-136 :: if($x -in @("4","g")){return "gates"}
- if lines 137-137 :: if($x -in @("5","s")){return "preparar-smoke"}
- if lines 138-138 :: if($x -in @("6","ed","editar")){return "editar"}
- if lines 139-139 :: if($x -in @("7","o","objetivo")){return "objetivo"}
- if lines 140-140 :: if($x -in @("8","cm","cerrar","cerrar-modulo")){return "cerrar-modulo"}
- if lines 141-141 :: if($x -in @("9","pb","promover","promover-biblioteca")){return "promover"}
- if lines 148-155 :: if($level -eq "MODULE"){
- if lines 156-163 :: if($level -eq "PROJECT"){
- if lines 177-180 :: if($cmd -in @("m","mant","mantenimiento")){
- if lines 182-182 :: if($cmd -eq "__refresh__"){continue}
- if lines 183-183 :: if($cmd -eq "ayuda"){Show-Help;Read-Host "Enter para volver"|Out-Null;continue}
- if lines 184-184 :: if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}
- if lines 184-184 :: if($cmd -eq "salir"){if((Get-Level) -eq "GLOBAL"){break}else{Go-Back;continue}}
- if lines 185-185 :: if($cmd -eq "atras"){Go-Back;continue}
- if lines 199-199 :: if(-not (Test-Path -LiteralPath $scriptPath)){ Write-Host "NO_GO maintenance_capture_script_not_found" -ForegroundColor Red; return }
- if lines 217-217 :: if([string]::IsNullOrWhiteSpace($title)){$title="Mantenimiento humano desde operator"}
- if lines 219-219 :: if([string]::IsNullOrWhiteSpace($dimension)){$dimension="ux"}
- if lines 221-221 :: if($dimension -notin $allowedDimensions){$dimension="other"}
- if lines 223-223 :: if([string]::IsNullOrWhiteSpace($severity)){$severity="MEDIUM"}
- if lines 225-225 :: if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
- if lines 227-227 :: if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}
- if lines 229-229 :: if([string]::IsNullOrWhiteSpace($suggested)){$suggested="Revisar y convertir en mejora/tarea si procede"}
- if lines 230-230 :: if($title.Length -gt 120){$title=$title.Substring(0,120)}
- if lines 231-231 :: if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
- if lines 232-232 :: if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
- if lines 234-234 :: if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}

## Functions
- L lines 6-6
- Ensure-State lines 7-7
- Get-State lines 8-8
- Save-State lines 9-9
- Short-Path lines 10-10
- Set-BootGlobalKeepContext lines 11-24
- Get-Level lines 25-35
- Show-LocationBar lines 36-50
- Show-ProjectModulesInline lines 51-69
- Show-Menu lines 70-104
- Refresh-Screen lines 105-113
- Normalize-Command lines 114-144
- Go-Back lines 145-164
- Show-Help lines 165-170
- Invoke-EngremiatHumanMaintenanceCard lines 196-201
- Invoke-EngremiatHumanMaintenanceInteractiveForm lines 208-236

## Real launcher parse
- parse_ok: True
- errors: 0

## Baseline parse
- parse_ok: True
- errors: 0

## Switch candidate parse
NOT_FOUND

## If candidate parse
NOT_FOUND

## Menu anchor excerpt
  203: # Route requirement: m, mant and mantenimiento should call Invoke-EngremiatHumanMaintenanceCard and return to same screen.
  204: # ENGREMIAT_MAINTENANCE_ROUTE_NOTE_END
  205: # ENGREMIAT_HUMAN_MAINTENANCE_COMMAND_END
  206: 
  207: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_BEGIN
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
  225:   if($severity -notin @("LOW","MEDIUM","HIGH","CRITICAL")){$severity="MEDIUM"}
  226:   $observation=Read-Host "Observacion"
  227:   if([string]::IsNullOrWhiteSpace($observation)){$observation="Observacion humana pendiente de detalle"}

## Input anchor excerpt
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
  231:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  232:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  233:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  234:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  235:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  236: }
  237: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END
  238: 
  239: 

## Router anchor excerpt
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
  231:   if($observation.Length -gt 1200){$observation=$observation.Substring(0,1200)}
  232:   if($suggested.Length -gt 800){$suggested=$suggested.Substring(0,800)}
  233:   $scriptPath=Join-Path (Get-Location).Path "tools\human-maintenance-cards\new-human-maintenance-card.ps1"
  234:   if(-not(Test-Path -LiteralPath $scriptPath)){throw "HUMAN_MAINTENANCE_CAPTURE_SCRIPT_NOT_FOUND path=$scriptPath"}
  235:   & powershell -NoProfile -ExecutionPolicy Bypass -File $scriptPath -SourceScreen $SourceScreen -SourceContext $SourceContext -Title $title -Dimension $dimension -Severity $severity -Observation $observation -SuggestedAction $suggested
  236: }
  237: # ENGREMIAT_HUMAN_MAINTENANCE_INTERACTIVE_FORM_END
  238: 
  239: 

## Rule
NO_APPLY. Diagnostico solamente. No modifica launcher real, no git, no adapter.

## Next
E04E_PREPARE_AST_GUIDED_PATCH_ON_PLANNED_COPY_NO_APPLY
