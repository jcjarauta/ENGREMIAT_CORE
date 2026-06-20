$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = (Resolve-Path (Join-Path $ScriptDir "..\..")).Path
Set-Location -LiteralPath $Root

function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function D($p){if(!(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
function W($p,[string[]]$a){$d=Split-Path $p -Parent;D $d;$a|Set-Content -LiteralPath $p -Encoding UTF8}
function J($p,$o){$d=Split-Path $p -Parent;D $d;$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
function Slug($s){$x=([string]$s).ToLowerInvariant();$x=$x -replace "[^a-z0-9]+","-";$x=$x.Trim("-");if([string]::IsNullOrWhiteSpace($x)){$x="proyecto"};return $x}
function ObsidianUri($path){return "obsidian://open?path="+[uri]::EscapeDataString($path)}
function CopyTree($src,$dst){D $dst;robocopy $src $dst /E /XD ".git" ".trash" ".obsidian\cache" /XF "*.tmp" | Out-Null;$code=$LASTEXITCODE;if($code -gt 7){throw "robocopy_failed code=$code src=$src dst=$dst"}}

function RegisterVault($vaultPath){
  $obs=Join-Path $vaultPath ".obsidian";D $obs
  J (Join-Path $obs "app.json") ([ordered]@{attachmentFolderPath="06_EVIDENCIAS";alwaysUpdateLinks=$true;newFileLocation="folder";newFileFolderPath="10_INDICE";showLineNumber=$false;spellcheck=$false})
  J (Join-Path $obs "core-plugins.json") ([ordered]@{"file-explorer"=$true;"global-search"=$true;switcher=$true;graph=$true;backlink=$true;canvas=$true;"outgoing-link"=$true;"tag-pane"=$true;"page-preview"=$true;"command-palette"=$true;"note-composer"=$true;templates=$false;"daily-notes"=$false;"markdown-importer"=$false;"word-count"=$true;slides=$false;"audio-recorder"=$false;workspaces=$true;"file-recovery"=$true;publish=$false;sync=$false})
  J (Join-Path $obs "graph.json") ([ordered]@{search="";showTags=$false;showAttachments=$false;hideUnresolved=$true;showOrphans=$true;collapseFilter=$false;collapseGroups=$false;collapseDisplay=$false;collapseForces=$false;collapseColorGroups=$false})
  $obsRoot=Join-Path ([Environment]::GetFolderPath("ApplicationData")) "obsidian";D $obsRoot
  $reg=Join-Path $obsRoot "obsidian.json"
  if(Test-Path -LiteralPath $reg){Copy-Item -LiteralPath $reg -Destination (Join-Path $obsRoot ("obsidian.json.bak-engremiat-"+(Get-Date -Format "yyyyMMdd-HHmmss"))) -Force;$cfg=Get-Content -LiteralPath $reg -Raw -Encoding UTF8|ConvertFrom-Json}else{$cfg=[pscustomobject]@{vaults=[pscustomobject]@{}}}
  if($null -eq $cfg.vaults){$cfg|Add-Member -NotePropertyName vaults -NotePropertyValue ([pscustomobject]@{}) -Force}
  $exists=$false
  foreach($prop in $cfg.vaults.PSObject.Properties){if([string]$prop.Value.path -eq [string]$vaultPath){$exists=$true;$prop.Value.open=$true}}
  if(!$exists){$key="engremiat_"+([guid]::NewGuid().ToString("N").Substring(0,12));$cfg.vaults|Add-Member -NotePropertyName $key -NotePropertyValue ([ordered]@{path=$vaultPath;ts=[int][double]::Parse((Get-Date -UFormat %s));open=$true}) -Force}
  $cfg|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $reg -Encoding UTF8
}

function CreateOpenScripts($targetDir,$scriptName,$vaultPath){
  $openPs1=Join-Path $targetDir ($scriptName+".ps1")
  $openCmd=Join-Path $targetDir ($scriptName+".cmd")
  W $openPs1 @(
    '$ErrorActionPreference="Stop"',
    '[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()',
    '$VaultPath="'+($vaultPath.Replace('"','""'))+'"',
    'if(!(Test-Path -LiteralPath $VaultPath)){throw "vault_path_not_found"}',
    '$url="obsidian://open?path="+[uri]::EscapeDataString($VaultPath)',
    'Start-Process $url',
    'Start-Sleep -Milliseconds 800',
    'Start-Process explorer.exe -ArgumentList @($VaultPath)'
  )
  W $openCmd @('@echo off','set "SCRIPT=%~dp0'+$scriptName+'.ps1"','powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"') 'ASCII'
  return $openCmd
}

L "NUEVO PROYECTO ENGREMIAT" Cyan
$title=Read-Host "Titulo del proyecto"
$objective=Read-Host "Objetivo principal"
$limits=Read-Host "Limites / restricciones"
$acceptance=Read-Host "Criterio de aceptacion"
if([string]::IsNullOrWhiteSpace($title)){throw "title_required"}
if([string]::IsNullOrWhiteSpace($objective)){throw "objective_required"}
if([string]::IsNullOrWhiteSpace($limits)){$limits="local only, sin worker real, sin git"}
if([string]::IsNullOrWhiteSpace($acceptance)){$acceptance="Boveda maestra desde plantilla y boveda de modulo separada creadas correctamente."}

$template="C:\ENGREMIAT_CORE\obsidian-vaults\ENGREMIAT_MASTER_VAULT_20260619-123146"
if(!(Test-Path -LiteralPath $template)){throw "master_template_not_found"}

$slug=Slug $title
$ts=Get-Date -Format "yyyyMMdd-HHmmss"
$id="SIM_PROJECT_${ts}_${slug}"
$desktop=[Environment]::GetFolderPath("Desktop")
$projectHome=Join-Path $desktop "ENGREMIAT_PROJECT_${slug}_${ts}"
$masterVault=Join-Path $projectHome "BOVEDA_MAESTRA"
$modulesRoot=Join-Path $projectHome "MODULOS"
$moduleHome=Join-Path $modulesRoot "MODULE_inicio"
$moduleVault=Join-Path $moduleHome "BOVEDA_MODULO"
$moduleSystem=Join-Path $moduleHome "_system"
$systemDir=Join-Path $projectHome "_system"
$globalReports=Join-Path $Root "reports\project-start-flow"
$globalDash=Join-Path $Root "dashboard\project-start-flow"
$globalBase=Join-Path $Root "data\project-start-flow\$id"

foreach($p in @($projectHome,$masterVault,$modulesRoot,$moduleHome,$moduleVault,$moduleSystem,$systemDir,$globalReports,$globalDash,$globalBase)){D $p}

CopyTree $template $masterVault

$templateModules=Join-Path $template "03_MODULOS"
if(Test-Path -LiteralPath $templateModules){CopyTree $templateModules $moduleVault}else{foreach($p in @("00_CONTROL","01_CONTRATO","02_ROADMAP","03_TAREAS","04_EVIDENCIAS","05_RESULTADOS","06_APRENDIZAJE","07_CANVAS","10_INDICE")){D (Join-Path $moduleVault $p)}}

$embeddedModules=Join-Path $masterVault "03_MODULOS"
if(Test-Path -LiteralPath $embeddedModules){Remove-Item -LiteralPath $embeddedModules -Recurse -Force}
D $embeddedModules

RegisterVault $masterVault
RegisterVault $moduleVault

$masterOpenCmd=CreateOpenScripts $projectHome "ABRIR_BOVEDA_MAESTRA" $masterVault
$moduleOpenCmd=CreateOpenScripts $moduleHome "ABRIR_BOVEDA_MODULO" $moduleVault
$moduleUri=ObsidianUri $moduleVault
$masterUri=ObsidianUri $masterVault

$intake=[ordered]@{project_id=$id;title=$title;objective=$objective;limits=$limits;acceptance=$acceptance;status="pending_human_review";template_source=$template;desktop_project_home=$projectHome;master_vault=$masterVault;modules_root=$modulesRoot;initial_module_folder=$moduleHome;initial_module_vault=$moduleVault;master_open_cmd=$masterOpenCmd;module_open_cmd=$moduleOpenCmd;next="revisar-proyecto";safety=[ordered]@{local_only=$true;no_worker_real=$true;no_git=$true;no_network=$true}}
J (Join-Path $globalBase "project-intake.json") $intake
J (Join-Path $systemDir "project-intake.json") $intake
J (Join-Path $moduleSystem "module-link.json") ([ordered]@{module_id="MODULE_inicio";project_id=$id;module_vault=$moduleVault;master_vault=$masterVault;module_open_cmd=$moduleOpenCmd})

W (Join-Path $projectHome "README_PROYECTO.md") @(
  "# Proyecto ENGREMIAT",
  "",
  "## Vision global",
  "Abrir: ABRIR_BOVEDA_MAESTRA.cmd",
  "",
  "## Trabajo de modulo",
  "Abrir: MODULOS\MODULE_inicio\ABRIR_BOVEDA_MODULO.cmd",
  "",
  "## Arquitectura",
  "- BOVEDA_MAESTRA: vision global, roadmap, decisiones y enlaces a modulos.",
  "- MODULOS: bovedas independientes para trabajar el detalle de cada modulo.",
  "",
  "## Plantilla usada",
  $template
)

W (Join-Path $masterVault "HOME.md") @(
  "# $title",
  "",
  "## Boveda maestra",
  "Aqui vive la vision global del proyecto.",
  "",
  "## Vision global",
  "- [[00_VISION_GLOBAL/VISION_GLOBAL]]",
  "- [[00_VISION_GLOBAL/PROJECT_STATUS]]",
  "- [[02_ROADMAP/ROADMAP_INICIAL]]",
  "",
  "## Modulos separados",
  "- [[03_MODULOS/MODULES_INDEX]]",
  "",
  "## Abrir modulo inicial",
  "[Abrir boveda MODULE_inicio]($moduleUri)",
  "",
  "## Objetivo",
  $objective
)

D (Join-Path $masterVault "00_VISION_GLOBAL")
D (Join-Path $masterVault "02_ROADMAP")
D (Join-Path $masterVault "03_MODULOS")
D (Join-Path $masterVault "04_GATES")
D (Join-Path $masterVault "08_CANVAS")

W (Join-Path $masterVault "00_VISION_GLOBAL\VISION_GLOBAL.md") @("# Vision global del proyecto","","## Objetivo",$objective,"","## Limites",$limits,"","## Criterio de aceptacion",$acceptance,"","## Modulos","[[../03_MODULOS/MODULES_INDEX]]")
W (Join-Path $masterVault "00_VISION_GLOBAL\PROJECT_STATUS.md") @("# Estado global","","- Project ID: $id","- Status: pending_human_review","- Boveda maestra: $masterVault","- Carpeta modulos: $modulesRoot","- Boveda modulo inicio: $moduleVault","- Template source: $template")
W (Join-Path $masterVault "02_ROADMAP\ROADMAP_INICIAL.md") @("# Roadmap inicial","","1. Revisar vision global.","2. Abrir boveda del modulo inicio.","3. Aprobar o ajustar proyecto.","4. Preparar smoke worker futuro.")
W (Join-Path $masterVault "03_MODULOS\MODULES_INDEX.md") @("# Indice de modulos","","## MODULE_inicio","- Carpeta: $moduleHome","- Boveda: $moduleVault","- [Abrir boveda MODULE_inicio]($moduleUri)","","## Regla","Cada nuevo modulo debe crearse dentro de MODULOS con su propia BOVEDA_MODULO.")
W (Join-Path $masterVault "03_MODULOS\MODULE_inicio_CARD.md") @("# MODULE_inicio","","## Tarjeta de enlace desde boveda maestra","","Boveda del modulo: $moduleVault","","[Abrir boveda MODULE_inicio]($moduleUri)")
W (Join-Path $masterVault "04_GATES\GATE_REVIEW_PROJECT_START.md") @("# Gate humano - inicio de proyecto","","Estado: pending_human_review","","Opciones futuras: APPROVE / ADJUST / BLOCK")

W (Join-Path $moduleVault "HOME.md") @(
  "# MODULE_inicio",
  "",
  "## Boveda de modulo",
  "Aqui se trabaja el detalle del modulo.",
  "",
  "## Proyecto",
  $title,
  "",
  "## Volver a vision global",
  "[Abrir boveda maestra]($masterUri)",
  "",
  "## Navegacion",
  "- [[01_CONTRATO/MODULE_CONTRACT]]",
  "- [[02_ROADMAP/MODULE_ROADMAP]]",
  "- [[03_TAREAS/TASK_INDEX]]"
)
D (Join-Path $moduleVault "01_CONTRATO")
D (Join-Path $moduleVault "02_ROADMAP")
D (Join-Path $moduleVault "03_TAREAS")
D (Join-Path $moduleVault "00_CONTROL")
if(!(Test-Path -LiteralPath (Join-Path $moduleVault "01_CONTRATO\MODULE_CONTRACT.md"))){W (Join-Path $moduleVault "01_CONTRATO\MODULE_CONTRACT.md") @("# Contrato MODULE_inicio","","## Entrada","Objetivo, limites y criterio de aceptacion.","","## Salida","Tareas, evidencias, resultado y aprendizaje.")}
if(!(Test-Path -LiteralPath (Join-Path $moduleVault "02_ROADMAP\MODULE_ROADMAP.md"))){W (Join-Path $moduleVault "02_ROADMAP\MODULE_ROADMAP.md") @("# Roadmap MODULE_inicio","","1. Definir contrato.","2. Crear tareas.","3. Preparar evidencia.","4. Preparar smoke worker.")}
if(!(Test-Path -LiteralPath (Join-Path $moduleVault "03_TAREAS\TASK_INDEX.md"))){W (Join-Path $moduleVault "03_TAREAS\TASK_INDEX.md") @("# Tareas MODULE_inicio","","- T01 Definir contrato.","- T02 Preparar estructura.","- T03 Preparar smoke futuro.")}
J (Join-Path $moduleVault "00_CONTROL\module.json") ([ordered]@{module_id="MODULE_inicio";project_id=$id;type="module_vault";master_vault=$masterVault;module_vault=$moduleVault;template_source=$templateModules;next="definir-contrato-modulo";safety=[ordered]@{local_only=$true;no_worker_real=$true}})

$canvas=@{nodes=@(@{id="home";type="file";file="HOME.md";x=0;y=0;width=360;height=220},@{id="vision";type="file";file="00_VISION_GLOBAL/VISION_GLOBAL.md";x=420;y=0;width=360;height=220},@{id="modules";type="file";file="03_MODULOS/MODULES_INDEX.md";x=840;y=0;width=360;height=220},@{id="module_card";type="file";file="03_MODULOS/MODULE_inicio_CARD.md";x=1260;y=0;width=360;height=220},@{id="roadmap";type="file";file="02_ROADMAP/ROADMAP_INICIAL.md";x=420;y=280;width=360;height=220},@{id="gate";type="file";file="04_GATES/GATE_REVIEW_PROJECT_START.md";x=840;y=280;width=360;height=220});edges=@(@{id="e1";fromNode="home";fromSide="right";toNode="vision";toSide="left"},@{id="e2";fromNode="vision";fromSide="right";toNode="modules";toSide="left"},@{id="e3";fromNode="modules";fromSide="right";toNode="module_card";toSide="left"},@{id="e4";fromNode="vision";fromSide="bottom";toNode="roadmap";toSide="top"},@{id="e5";fromNode="roadmap";fromSide="right";toNode="gate";toSide="left"})}
J (Join-Path $masterVault "08_CANVAS\PROJECT_MASTER.canvas") $canvas

$report=[ordered]@{package_id="ENGREMIAT_PROJECT_START_FLOW_001";stage="E01L_COMMAND_NUEVO_PROYECTO_RUNTIME_TEMPLATE_SPLIT_MODULES";status="PASS";readiness=100;decision="GO_PROJECT_CREATED_FROM_MASTER_TEMPLATE_WITH_SEPARATE_MODULE_VAULT";project_id=$id;template_source=$template;desktop_project_home=$projectHome;master_vault=$masterVault;modules_root=$modulesRoot;initial_module_folder=$moduleHome;initial_module_vault=$moduleVault;master_open_cmd=$masterOpenCmd;module_open_cmd=$moduleOpenCmd;next="revisar-proyecto"}
$reportPath=Join-Path $globalReports "e01l-command-nuevo-proyecto-runtime-${id}.json"
J $reportPath $report
J (Join-Path $systemDir "project-start-report.json") $report

$html=Join-Path $globalDash "${id}_dashboard.html"
W $html @("<!doctype html><html lang='es'><head><meta charset='utf-8'><title>ENGREMIAT Proyecto</title></head><body>","<h1>Proyecto ENGREMIAT creado desde plantilla</h1>","<p>Boveda maestra: $masterVault</p>","<p>Boveda modulo inicio: $moduleVault</p>","<p>Template: $template</p>","<p>Next: revisar-proyecto</p>","</body></html>")
D (Join-Path $systemDir "dashboard")
Copy-Item -LiteralPath $html -Destination (Join-Path $systemDir "dashboard\index.html") -Force

Start-Process powershell.exe -ArgumentList @("-NoProfile","-ExecutionPolicy","Bypass","-File",(Join-Path $projectHome "ABRIR_BOVEDA_MAESTRA.ps1"))
& powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $Root "tools\desktop-terminal-operator\eng-module-vault-builder.ps1") $moduleVault "MODULE_inicio" $id $title $masterVault
Start-Process $html

L "OK project_id=$id template_source=$template master_vault=$masterVault module_vault=$moduleVault master_open_cmd=$masterOpenCmd module_open_cmd=$moduleOpenCmd report=$reportPath next=revisar-proyecto" Green



