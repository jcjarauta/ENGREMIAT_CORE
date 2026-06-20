$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function B([string]$t,[object[]]$l,[string]$c="Cyan"){W "";W "==== $t ====" $c;foreach($x in $l){W ([string]$x) $c}}
function EnsureDir([string]$p){[System.IO.Directory]::CreateDirectory($p)|Out-Null}
function CF([string]$p){if(!(Test-Path -LiteralPath $p)){return 0};return @(Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue).Count}
function Mirror([string]$src,[string]$dst,[string]$tag,[string]$logDir){if(!(Test-Path -LiteralPath $src)){throw "source_missing=$src"};EnsureDir $dst;EnsureDir $logDir;$log=Join-Path $logDir ("robocopy-"+$tag+"-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".log");& robocopy $src $dst /MIR /R:2 /W:1 /NFL /NDL /NP /LOG:$log|Out-Null;if($LASTEXITCODE -gt 7){throw "robocopy_failed tag=$tag code=$LASTEXITCODE log=$log"};return $log}
try{
$root="C:\ENGREMIAT_CORE"
$pkg="ENGREMIAT_TEMPLATE_IMPROVEMENT_001"
$stage="E09D1_NEW_SAFE_PROJECT_LAUNCHER_V2_REPAIRED"
$base="C:\Users\pc\Desktop\ENGREMIAT_OPERATOR"
$activeProject="C:\Users\pc\Desktop\ENGREMIAT_OPERATOR\ENGREMIAT_PROJECT_p3_20260619-224903"
$sourceMaster=Join-Path $activeProject "BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL"
$sourceModuleRef=Join-Path $activeProject "MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA"
$rep=Join-Path $root "reports\template-improvement\e09d1-new-safe-project-launcher-v2"
$freezeValidator=Join-Path $root "data\operator-navigation-freeze\Validate-OperatorFreeze.ps1"
EnsureDir $rep;EnsureDir $base
B "ENGREMIAT_PACKAGE_BEGIN" @("package=$pkg","stage=$stage","mode=CREATE_TEST_PROJECT_FROM_TEMPLATE_V2_SAFE","goal=create_full_project_without_old_brittle_launcher") "Cyan"
if(Test-Path -LiteralPath $freezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $freezeValidator;if($LASTEXITCODE -ne 0){throw "freeze_validator_failed_before_e09d1"}}
if(!(Test-Path -LiteralPath $sourceMaster)){throw "source_master_missing=$sourceMaster"}
if(!(Test-Path -LiteralPath $sourceModuleRef)){throw "source_module_ref_missing=$sourceModuleRef"}
$name=Read-Host "NOMBRE_CORTO_PROYECTO_NUEVO_EJ_prueba_v2"
if([string]::IsNullOrWhiteSpace($name)){$name="prueba_v2"}
$safe=($name -replace "[^a-zA-Z0-9_-]","-").Trim("-")
if([string]::IsNullOrWhiteSpace($safe)){$safe="prueba_v2"}
$stamp=Get-Date -Format "yyyyMMdd-HHmmss"
$project=Join-Path $base ("ENGREMIAT_PROJECT_"+$safe+"_"+$stamp)
$masterDst=Join-Path $project "BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL"
$moduleRefDst=Join-Path $project "MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA"
$controlDir=Join-Path $project "BOVEDA_PROYECTO\00_CONTROL"
$modControl=Join-Path $project "MODULOS\MODULE_inicio\BOVEDA_MODULO\00_CONTROL"
EnsureDir $project;EnsureDir $controlDir;EnsureDir $modControl
$logMaster=Mirror $sourceMaster $masterDst "copy-master-v2" $rep
$logModule=Mirror $sourceModuleRef $moduleRefDst "copy-module-ref-v2" $rep
[ordered]@{project_id=("PROJECT_"+$safe+"_"+$stamp);name=$safe;created_at=(Get-Date).ToString("s");template="MASTER_V2_SAFE_LAUNCHER";master_template=$masterDst;module_inicio=$moduleRefDst}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath (Join-Path $controlDir "project.json") -Encoding UTF8
[ordered]@{module_id="MODULE_inicio";name="inicio";created_at=(Get-Date).ToString("s");template_reference=$moduleRefDst;role="initial_module"}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath (Join-Path $modControl "module.json") -Encoding UTF8
$required=@("BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\00_HOME\PROJECT_HOME.md","BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\00_HOME\GRAPH_INDEX.md","BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\00_CONTROL\project.template.json","BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\11_AGRUPACION_MANUAL\SYSTEM_GROUPING_MODEL.md","MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA\06_RELACIONES\MODULE_GROUPING_MODEL.md","BOVEDA_PROYECTO\00_CONTROL\project.json","MODULOS\MODULE_inicio\BOVEDA_MODULO\00_CONTROL\module.json")
$missing=@();foreach($r in $required){if(!(Test-Path -LiteralPath (Join-Path $project $r))){$missing+=$r}}
$jsonErrors=@();Get-ChildItem -LiteralPath $project -Recurse -File -Filter *.json -ErrorAction SilentlyContinue|ForEach-Object{try{Get-Content -LiteralPath $_.FullName -Raw -Encoding UTF8|ConvertFrom-Json|Out-Null}catch{$jsonErrors+=$_.FullName}}
if($missing.Count -gt 0){throw "missing_after_create="+($missing -join ",")}
if($jsonErrors.Count -gt 0){throw "json_errors_after_create="+($jsonErrors -join ",")}
if(Test-Path -LiteralPath $freezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $freezeValidator;if($LASTEXITCODE -ne 0){throw "freeze_validator_failed_after_e09d1"}}
$summary=Join-Path $rep "E09D1_NEW_SAFE_PROJECT_CREATED_SUMMARY.md"
Set-Content -LiteralPath $summary -Encoding UTF8 -Value @("# E09D1 proyecto nuevo creado con launcher seguro V2","","## Estado","PASS","","## Proyecto","$project","","## Conteos","- Master files: $(CF $masterDst)","- Module ref files: $(CF $moduleRefDst)","","## Validacion","- Missing: $($missing.Count)","- JSON errors: $($jsonErrors.Count)","- Freeze validator: PASS","","## Siguiente","Abrir el proyecto en Obsidian y revisar grafo / probar operador.")
$report=[ordered]@{package=$pkg;stage=$stage;status="PASS";project=$project;master=$masterDst;module_ref=$moduleRefDst;master_files=CF $masterDst;module_ref_files=CF $moduleRefDst;missing=$missing;json_errors=$jsonErrors;log_master=$logMaster;log_module=$logModule;summary=$summary;next="OPEN_NEW_PROJECT_AND_VERIFY_GRAPH"}
$json=Join-Path $rep "e09d1-new-safe-project-launcher-v2-repaired.json";$report|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $json -Encoding UTF8
B "OK" @("package_id=$pkg","stage=$stage","status=PASS","project=$project","master_files=$(CF $masterDst)","module_ref_files=$(CF $moduleRefDst)","summary=$summary","report=$json","next=OPEN_NEW_PROJECT_AND_VERIFY_GRAPH") "Green"
B "COPIAR" @("Proyecto V2 creado con launcher nuevo seguro.","Abre esta carpeta en Obsidian: $project","Si funciona, despues sustituimos o integramos el launcher antiguo.") "Magenta"
B "ENGREMIAT_PACKAGE_END" @("package=$pkg","status=PASS") "Cyan"
Start-Process explorer.exe $project
}catch{B "ERR" @("status=FAIL",$_.Exception.Message) "Red";throw}
