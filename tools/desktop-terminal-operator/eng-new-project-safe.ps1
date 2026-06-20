param([string]$ProjectName="",[string]$BaseDir="C:\Users\pc\Desktop\ENGREMIAT_OPERATOR",[switch]$NoPause)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function B([string]$t,[object[]]$l,[string]$c="Cyan"){W "";W "==== $t ====" $c;foreach($x in $l){W ([string]$x) $c}}
function D([string]$p){[System.IO.Directory]::CreateDirectory($p)|Out-Null}
function CF([string]$p){if(!(Test-Path -LiteralPath $p)){return 0};return @(Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue).Count}
function Mirror([string]$src,[string]$dst,[string]$tag,[string]$logDir){if(!(Test-Path -LiteralPath $src)){throw "source_missing tag=$tag path=$src"};D $dst;D $logDir;$log=Join-Path $logDir ("robocopy-"+$tag+"-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".log");& robocopy $src $dst /MIR /R:2 /W:1 /NFL /NDL /NP /LOG:$log|Out-Null;if($LASTEXITCODE -gt 7){throw "robocopy_failed tag=$tag code=$LASTEXITCODE log=$log"};return $log}
try{
  $root="C:\ENGREMIAT_CORE"
  $stage="eng-new-project-safe-v2-canonical-core-templates"
  $reports=Join-Path $root "reports\operator-navigation-model"
  $registry=Join-Path $root "templates\ENGREMIAT_TEMPLATE_REGISTRY_V2.json"
  $masterTemplate=Join-Path $root "templates\MASTER_PROJECT_TEMPLATE_V2"
  $moduleTemplate=Join-Path $root "templates\MODULE_INICIO_TEMPLATE_V2"
  D $reports
  B "CREAR PROYECTO V2" @("Paso=$stage","BaseDir=$BaseDir","MasterTemplate=$masterTemplate","ModuleTemplate=$moduleTemplate") "Cyan"
  if(!(Test-Path -LiteralPath $registry)){throw "template_registry_missing=$registry"}
  foreach($r in @("00_HOME\PROJECT_HOME.md","00_CONTROL\project.template.json","11_AGRUPACION_MANUAL\SYSTEM_GROUPING_MODEL.md")){if(!(Test-Path -LiteralPath (Join-Path $masterTemplate $r))){throw "master_template_required_missing=$r"}}
  foreach($r in @("00_HOME\MODULE_HOME.md","06_RELACIONES\MODULE_GROUPING_MODEL.md")){if(!(Test-Path -LiteralPath (Join-Path $moduleTemplate $r))){throw "module_template_required_missing=$r"}}
  if([string]::IsNullOrWhiteSpace($ProjectName)){$ProjectName=Read-Host "Nombre corto del proyecto"}
  if([string]::IsNullOrWhiteSpace($ProjectName)){$ProjectName="nuevo-proyecto"}
  $safe=($ProjectName -replace "[^a-zA-Z0-9_-]","-").Trim("-")
  if([string]::IsNullOrWhiteSpace($safe)){$safe="nuevo-proyecto"}
  D $BaseDir
  $stamp=Get-Date -Format "yyyyMMdd-HHmmss"
  $project=Join-Path $BaseDir ("ENGREMIAT_PROJECT_"+$safe+"_"+$stamp)
  $masterDst=Join-Path $project "BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL"
  $moduleRefDst=Join-Path $project "MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA"
  $projectControl=Join-Path $project "BOVEDA_PROYECTO\00_CONTROL"
  $moduleControl=Join-Path $project "MODULOS\MODULE_inicio\BOVEDA_MODULO\00_CONTROL"
  D $project;D $projectControl;D $moduleControl
  $logMaster=Mirror $masterTemplate $masterDst "copy-canonical-master-v2" $reports
  $logModule=Mirror $moduleTemplate $moduleRefDst "copy-canonical-module-v2" $reports
  [ordered]@{project_id=("PROJECT_"+$safe+"_"+$stamp);name=$safe;created_at=(Get-Date).ToString("s");creator=$stage;template_registry=$registry;master_template=$masterTemplate;module_template=$moduleTemplate;master=$masterDst;module_inicio=$moduleRefDst;status="ACTIVO";operator_status="ACTIVO"}|ConvertTo-Json -Depth 40|Set-Content -LiteralPath (Join-Path $projectControl "project.json") -Encoding UTF8
  [ordered]@{module_id="MODULE_inicio";name="inicio";created_at=(Get-Date).ToString("s");creator=$stage;template_reference=$moduleRefDst;source_template=$moduleTemplate;status="ACTIVO"}|ConvertTo-Json -Depth 40|Set-Content -LiteralPath (Join-Path $moduleControl "module.json") -Encoding UTF8
  Set-Content -LiteralPath (Join-Path $project "00_INICIO_GRAFO_OPERATIVO.md") -Encoding UTF8 -Value @("# 00_INICIO_GRAFO_OPERATIVO","","Proyecto creado desde plantillas canonicas CORE.","","MasterTemplate: $masterTemplate","ModuleTemplate: $moduleTemplate","RuntimeDependsOnSourceProject: false")
  $missing=@()
  foreach($r in @("BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\00_HOME\PROJECT_HOME.md","BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\00_CONTROL\project.template.json","BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL\11_AGRUPACION_MANUAL\SYSTEM_GROUPING_MODEL.md","MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA\00_HOME\MODULE_HOME.md","MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA\06_RELACIONES\MODULE_GROUPING_MODEL.md","BOVEDA_PROYECTO\00_CONTROL\project.json","MODULOS\MODULE_inicio\BOVEDA_MODULO\00_CONTROL\module.json","00_INICIO_GRAFO_OPERATIVO.md")){if(!(Test-Path -LiteralPath (Join-Path $project $r))){$missing+=$r}}
  if($missing.Count -gt 0){throw "missing_after_create="+($missing -join ",")}
  $report=Join-Path $reports ("new-project-safe-v2-canonical-"+$stamp+".json")
  [ordered]@{status="PASS";stage=$stage;project=$project;base_dir=$BaseDir;template_registry=$registry;master_template=$masterTemplate;module_template=$moduleTemplate;runtime_depends_on_source_project=$false;master_files=CF $masterDst;module_ref_files=CF $moduleRefDst;log_master=$logMaster;log_module=$logModule;missing=$missing;next="manager_should_activate_latest"}|ConvertTo-Json -Depth 50|Set-Content -LiteralPath $report -Encoding UTF8
  B "OK CREAR PROYECTO" @("status=PASS","project=$project","master_files=$(CF $masterDst)","module_ref_files=$(CF $moduleRefDst)","runtime_depends_on_source_project=false","report=$report") "Green"
  Start-Process explorer.exe $project
  if(-not $NoPause){Read-Host "Enter para volver"}
}catch{
  $errReport=Join-Path "C:\ENGREMIAT_CORE\reports\operator-navigation-model" ("new-project-error-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
  [ordered]@{status="FAIL";step="eng-new-project-safe-v2-canonical-core-templates";message=$_.Exception.Message;base_dir=$BaseDir;runtime_depends_on_source_project=$false;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 30|Set-Content -LiteralPath $errReport -Encoding UTF8
  B "ERR CREAR PROYECTO" @("Paso=eng-new-project-safe-v2-canonical-core-templates","Mensaje=$($_.Exception.Message)","Reporte=$errReport") "Red"
  if(-not $NoPause){Read-Host "Enter para volver"}
  exit 1
}
