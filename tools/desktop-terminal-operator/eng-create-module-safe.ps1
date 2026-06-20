param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$State=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
$ReportDir=Join-Path $Root "reports\operator-navigation-model"
$FreezeValidator=Join-Path $Root "data\operator-navigation-freeze\Validate-OperatorFreeze.ps1"
function Write-Line([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Box([string]$t,[object[]]$l,[string]$c="Cyan"){Write-Line "";Write-Line "==== $t ====" $c;foreach($x in $l){Write-Line ([string]$x) $c}}
function Safe-Name([string]$Name){$s=($Name -replace "[^a-zA-Z0-9_-]","-").Trim("-");if([string]::IsNullOrWhiteSpace($s)){return "nuevo-modulo"};return $s}
function Count-Files([string]$p){if(!(Test-Path -LiteralPath $p)){return 0};return @(Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue).Count}
try{
  New-Item -ItemType Directory -Force -Path $ReportDir|Out-Null
  Box "ENGREMIAT_PACKAGE_BEGIN" @("package=ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001","stage=EXT01_CREATE_MODULE_SAFE","mode=WRITE_PROJECT_ONLY","goal=create_new_module_from_official_master_reference") "Cyan"
  if(Test-Path -LiteralPath $FreezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $FreezeValidator;if($LASTEXITCODE -ne 0){throw "freeze_validator_failed_before_module_create"}}
  if(!(Test-Path -LiteralPath $State)){throw "missing_state=$State"}
  $s=Get-Content -LiteralPath $State -Raw -Encoding UTF8|ConvertFrom-Json
  $project=[string]$s.active_project
  if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "active_project_missing_or_not_exists=$project"}
  $vault=Join-Path $project "BOVEDA_PROYECTO"
  $official=Join-Path $vault "00_PLANTILLA_MAESTRA_OFICIAL"
  $mods=Join-Path $project "MODULOS"
  if(!(Test-Path -LiteralPath $official)){throw "missing_official_master_template=$official"}
  New-Item -ItemType Directory -Force -Path $mods|Out-Null
  Clear-Host
  Box "CREAR MODULO SEGURO" @("Proyecto: $project","Plantilla oficial: $official","Destino base: $mods") "Cyan"
  $raw=(Read-Host "Nombre del modulo").Trim()
  $safe=Safe-Name $raw
  if(!$safe.StartsWith("MODULE_")){$moduleName="MODULE_"+$safe}else{$moduleName=$safe}
  $modulePath=Join-Path $mods $moduleName
  if(Test-Path -LiteralPath $modulePath){throw "module_already_exists=$modulePath"}
  $moduleVault=Join-Path $modulePath "BOVEDA_MODULO"
  $control=Join-Path $moduleVault "00_CONTROL"
  $reference=Join-Path $moduleVault "00_PLANTILLA_MAESTRA_REFERENCIA"
  New-Item -ItemType Directory -Force -Path $modulePath,$moduleVault,$control,$reference|Out-Null
  $sourceInfo=Join-Path $reference "SOURCE_TEMPLATE_REFERENCE.json"
  [ordered]@{kind="REFERENCE_TO_OFFICIAL_MASTER_TEMPLATE";template_source=$official;note="No se copia toda la plantilla para evitar duplicacion y rutas largas. Este modulo referencia la plantilla oficial congelada.";created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $sourceInfo -Encoding UTF8
  $moduleJson=Join-Path $control "module.json"
  [ordered]@{module=$moduleName;title=$raw;lifecycle="ACTIVE_IN_PROJECT";library_status="LOCAL_PROJECT_MODULE";objective="Modulo creado desde EXT01_CREATE_MODULE_SAFE";project_path=$project;module_path=$modulePath;official_master_template=$official;reference_file=$sourceInfo;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $moduleJson -Encoding UTF8
  $readme=Join-Path $moduleVault ("README_"+$moduleName+".md")
  Set-Content -LiteralPath $readme -Encoding UTF8 -Value @("# $moduleName","","Modulo creado de forma segura desde el operador Engremiat.","","## Proyecto","$project","","## Plantilla maestra oficial","$official","","## Contrato","- No modifica el nucleo congelado.","- No duplica toda la plantilla maestra.","- Mantiene referencia a la plantilla oficial.","- Puede ampliarse con tareas, evidencias y vistas propias.")
  $index=Join-Path $moduleVault "MODULE_INDEX.md"
  Set-Content -LiteralPath $index -Encoding UTF8 -Value @("# INDEX $moduleName","","- 00_CONTROL/module.json","- README_$moduleName.md","- 00_PLANTILLA_MAESTRA_REFERENCIA/SOURCE_TEMPLATE_REFERENCE.json")
  $required=@($modulePath,$moduleVault,$control,$reference,$sourceInfo,$moduleJson,$readme,$index)
  $missing=@()
  foreach($r in $required){if(!(Test-Path -LiteralPath $r)){$missing+=$r}}
  if($missing.Count -gt 0){throw "missing_after_module_create="+($missing -join ";")}
  $s.mode="module";$s.active_project=$project;$s.active_master_vault=$vault;$s.active_module=$modulePath;$s.active_module_vault=$moduleVault;$s.last_command="create-module-safe";$s.next="modulo";$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $State -Encoding UTF8
  if(Test-Path -LiteralPath $FreezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $FreezeValidator;if($LASTEXITCODE -ne 0){throw "freeze_validator_failed_after_module_create"}}
  $report=Join-Path $ReportDir ("ext01-create-module-safe-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
  [ordered]@{package="ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001";stage="EXT01_CREATE_MODULE_SAFE";status="PASS";project=$project;module=$moduleName;module_path=$modulePath;module_json=$moduleJson;official_master_template=$official;freeze_validation_after="PASS";files=(Count-Files $modulePath);created_at=(Get-Date).ToString("s");next="TEST_OPERATOR_MODULE_LEVEL_OR_EXT02_SELECTOR"}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $report -Encoding UTF8
  Box "OK" @("status=PASS","module=$moduleName","module_path=$modulePath","module_json=$moduleJson","official_master_template=$official","report=$report","next=TEST_OPERATOR_MODULE_LEVEL_OR_EXT02_SELECTOR") "Green"
  Box "COPIAR" @("Modulo creado sin tocar nucleo congelado.","El estado queda en nivel MODULO con este modulo activo.","Siguiente recomendado: probar operador y despues EXT02_MODULE_SELECTOR_SAFE.") "Magenta"
  Start-Process explorer.exe $modulePath
  Box "ENGREMIAT_PACKAGE_END" @("package=ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001","status=PASS") "Cyan"
}catch{Box "ERR" @("status=FAIL",$_.Exception.Message) "Red";throw}
