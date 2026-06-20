$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ScriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path
$Root=(Resolve-Path (Join-Path $ScriptDir "..\..")).Path
Set-Location -LiteralPath $Root
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function D($p){if(!(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
function W($p,[string[]]$a,$enc="UTF8"){$d=Split-Path $p -Parent;D $d;$a|Set-Content -LiteralPath $p -Encoding $enc}
function J($p,$o){$d=Split-Path $p -Parent;D $d;$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
function Slug($s){$x=([string]$s).ToLowerInvariant();$x=$x -replace "[^a-z0-9]+","-";$x=$x.Trim("-");if([string]::IsNullOrWhiteSpace($x)){$x="modulo"};return $x}
function MakeOpen($targetDir,$name,$vaultPath){$ps1=Join-Path $targetDir ($name+".ps1");$cmd=Join-Path $targetDir ($name+".cmd");W $ps1 @('$ErrorActionPreference="Stop"','[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()','$VaultPath="'+($vaultPath.Replace('"','""'))+'"','if(!(Test-Path -LiteralPath $VaultPath)){throw "vault_path_not_found"}','$url="obsidian://open?path="+[uri]::EscapeDataString($VaultPath)','try{Start-Process $url; Start-Sleep -Milliseconds 800}catch{}','Start-Process explorer.exe -ArgumentList @($VaultPath)') "UTF8";W $cmd @('@echo off','set "SCRIPT=%~dp0'+$name+'.ps1"','powershell -NoProfile -ExecutionPolicy Bypass -File "%SCRIPT%"') "ASCII";return $cmd}
$desktop=[Environment]::GetFolderPath("Desktop")
$projects=@(Get-ChildItem -LiteralPath $desktop -Directory -Filter "ENGREMIAT_PROJECT_*" -ErrorAction SilentlyContinue|Where-Object{Test-Path -LiteralPath (Join-Path $_.FullName "BOVEDA_MAESTRA")}|Sort-Object LastWriteTime -Descending)
if(@($projects).Count -eq 0){throw "no_engremiat_project_found"}
L "SELECCIONA PROYECTO DESTINO" Cyan
for($i=0;$i -lt @($projects).Count;$i++){L (" ["+($i+1)+"] "+$projects[$i].Name+"  "+$projects[$i].LastWriteTime.ToString("yyyy-MM-dd HH:mm")) Green}
$sel=Read-Host "Numero de proyecto"
[int]$n=0
if(![int]::TryParse($sel,[ref]$n)){throw "invalid_project_selection"}
if($n -lt 1 -or $n -gt @($projects).Count){throw "project_selection_out_of_range"}
$project=$projects[$n-1]
$projectHome=$project.FullName
$projectId=Split-Path $projectHome -Leaf
$masterVault=Join-Path $projectHome "BOVEDA_MAESTRA"
$modulesRoot=Join-Path $projectHome "MODULOS"
D $modulesRoot
L ("PROYECTO_ELEGIDO="+$projectHome) Cyan
L "NUEVO MODULO ENGREMIAT" Cyan
$name=Read-Host "Nombre del modulo"
$purpose=Read-Host "Proposito del modulo"
$acceptance=Read-Host "Criterio de aceptacion"
if([string]::IsNullOrWhiteSpace($name)){throw "module_name_required"}
if([string]::IsNullOrWhiteSpace($purpose)){$purpose="Modulo operativo ENGREMIAT"}
if([string]::IsNullOrWhiteSpace($acceptance)){$acceptance="Modulo creado, enlazado y preparado para contrato operativo."}
$slug=Slug $name
$moduleId="MODULE_"+$slug
$moduleHome=Join-Path $modulesRoot $moduleId
$moduleVault=Join-Path $moduleHome "BOVEDA_MODULO"
if(Test-Path -LiteralPath $moduleHome){throw "module_already_exists $moduleHome"}
foreach($p in @($moduleHome,$moduleVault,"$moduleVault\.obsidian","$moduleVault\00_CONTROL","$moduleVault\00_CONTROL\GATES","$moduleVault\00_CONTROL\DECISIONS","$moduleVault\00_CONTROL\RISKS","$moduleVault\00_CONTROL\OPERATIVE_CONTROL","$moduleVault\01_CONTRATO","$moduleVault\02_ROADMAP","$moduleVault\03_TAREAS","$moduleVault\04_EVIDENCIAS","$moduleVault\05_RESULTADOS","$moduleVault\06_APRENDIZAJE","$moduleVault\07_CANVAS","$moduleVault\08_PLANTILLAS","$moduleVault\09_ARCHIVO","$moduleVault\10_INDICE","$moduleVault\11_SUPERFICIES_TRABAJO")){D $p}
J (Join-Path $moduleVault ".obsidian\app.json") ([ordered]@{attachmentFolderPath="04_EVIDENCIAS";alwaysUpdateLinks=$true;newFileLocation="folder";newFileFolderPath="10_INDICE"})
J (Join-Path $moduleVault ".obsidian\core-plugins.json") ([ordered]@{"file-explorer"=$true;"global-search"=$true;switcher=$true;graph=$true;backlink=$true;canvas=$true;"outgoing-link"=$true;"tag-pane"=$true;"page-preview"=$true;"command-palette"=$true;"note-composer"=$true;"file-recovery"=$true})
$moduleUri="obsidian://open?path="+[uri]::EscapeDataString($moduleVault)
$masterUri="obsidian://open?path="+[uri]::EscapeDataString($masterVault)
$openCmd=MakeOpen $moduleHome "ABRIR_BOVEDA_MODULO" $moduleVault
W (Join-Path $moduleVault "HOME.md") @("# $moduleId","","## Proposito",$purpose,"","## Criterio de aceptacion",$acceptance,"","## Volver a boveda maestra","[Abrir boveda maestra]($masterUri)","","## Navegacion","- [[10_INDICE/INDICE_MODULO]]","- [[00_CONTROL/OPERATIVE_CONTROL/CONTROL_OPERATIVO]]","- [[01_CONTRATO/MODULE_OPERATIVE_CONTRACT]]","- [[03_TAREAS/TASK_INDEX]]","- [[04_EVIDENCIAS/EXPECTED_EVIDENCE]]")
W (Join-Path $moduleVault "10_INDICE\INDICE_MODULO.md") @("# Indice $moduleId","","- [[../HOME]]","- [[../00_CONTROL/OPERATIVE_CONTROL/CONTROL_OPERATIVO]]","- [[../01_CONTRATO/MODULE_OPERATIVE_CONTRACT]]","- [[../02_ROADMAP/MODULE_ROADMAP]]","- [[../03_TAREAS/TASK_INDEX]]","- [[../04_EVIDENCIAS/EXPECTED_EVIDENCE]]","- [[../05_RESULTADOS/RESULT_INDEX]]","- [[../06_APRENDIZAJE/LEARNING_INDEX]]")
W (Join-Path $moduleVault "00_CONTROL\OPERATIVE_CONTROL\CONTROL_OPERATIVO.md") @("# Control operativo $moduleId","","Estado: draft","","Regla: sin worker real hasta gate humano.")
W (Join-Path $moduleVault "01_CONTRATO\MODULE_OPERATIVE_CONTRACT.md") @("# Contrato operativo $moduleId","","## Proposito",$purpose,"","## Alcance","Pendiente de definir en detalle.","","## Criterio de aceptacion",$acceptance,"","## Seguridad","local_only=True","worker_real=False","git=False","network=False")
W (Join-Path $moduleVault "02_ROADMAP\MODULE_ROADMAP.md") @("# Roadmap $moduleId","","1. Aprobar contrato.","2. Generar tareas.","3. Definir evidencias.","4. Preparar smoke simulado.","5. Validar resultado.")
W (Join-Path $moduleVault "03_TAREAS\TASK_INDEX.md") @("# Tareas $moduleId","","- T01 Aprobar contrato.","- T02 Generar tareas desde contrato.","- T03 Definir evidencias esperadas.")
W (Join-Path $moduleVault "04_EVIDENCIAS\EXPECTED_EVIDENCE.md") @("# Evidencia esperada $moduleId","","Pendiente de concretar tras contrato.")
W (Join-Path $moduleVault "05_RESULTADOS\RESULT_INDEX.md") @("# Resultados $moduleId","","Sin resultados todavia.")
W (Join-Path $moduleVault "06_APRENDIZAJE\LEARNING_INDEX.md") @("# Aprendizaje $moduleId","","Sin aprendizaje registrado todavia.")
W (Join-Path $moduleVault "00_CONTROL\GATES\GATE_MODULE_REVIEW.md") @("# GATE_MODULE_REVIEW","","Estado: pending_human_review","","Opciones: APPROVE / ADJUST / BLOCK")
J (Join-Path $moduleVault "00_CONTROL\module.json") ([ordered]@{module_id=$moduleId;project_id=$projectId;purpose=$purpose;acceptance=$acceptance;status="draft";type="operative_module_vault";module_vault=$moduleVault;master_vault=$masterVault;open_cmd=$openCmd;safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false};next="revisar-modulo"})
$masterModules=Join-Path $masterVault "03_MODULOS";D $masterModules
$index=Join-Path $masterModules "MODULES_INDEX.md"
$line="- [[$moduleId"+"_"+"CARD]]"
if(Test-Path -LiteralPath $index){$idx=Get-Content -LiteralPath $index -Raw -Encoding UTF8;if(!$idx.Contains($moduleId)){($idx.TrimEnd()+"`r`n"+$line+"`r`n")|Set-Content -LiteralPath $index -Encoding UTF8}}else{W $index @("# Indice de modulos","",$line)}
W (Join-Path $masterModules ($moduleId+"_CARD.md")) @("# $moduleId","","## Proposito",$purpose,"","## Boveda del modulo",$moduleVault,"","## Abrir","[Abrir boveda $moduleId]($moduleUri)","","## Estado","draft")
$canvas=@{nodes=@(@{id="home";type="file";file="HOME.md";x=0;y=0;width=360;height=220},@{id="contract";type="file";file="01_CONTRATO/MODULE_OPERATIVE_CONTRACT.md";x=420;y=0;width=360;height=220},@{id="tasks";type="file";file="03_TAREAS/TASK_INDEX.md";x=840;y=0;width=360;height=220},@{id="gate";type="file";file="00_CONTROL/GATES/GATE_MODULE_REVIEW.md";x=420;y=280;width=360;height=220});edges=@(@{id="e1";fromNode="home";fromSide="right";toNode="contract";toSide="left"},@{id="e2";fromNode="contract";fromSide="right";toNode="tasks";toSide="left"},@{id="e3";fromNode="contract";fromSide="bottom";toNode="gate";toSide="top"})}
J (Join-Path $moduleVault "07_CANVAS\MODULE_CANVAS.canvas") $canvas
$reports=Join-Path $Root "reports\module-creation-flow";D $reports
$report=[ordered]@{package_id="ENGREMIAT_MODULE_CREATION_FLOW_001";stage="E02_SELECT_TARGET_PROJECT_RUNTIME";status="PASS";readiness=100;decision="GO_NEW_MODULE_CREATED_IN_SELECTED_PROJECT";selected_project=$projectHome;module_id=$moduleId;module_home=$moduleHome;module_vault=$moduleVault;open_cmd=$openCmd;safety=[ordered]@{local_only=$true;worker_real=$false;git=$false;network=$false};next="revisar-modulo"}
$reportPath=Join-Path $reports ("e02-new-module-selected-project-"+$moduleId+".json")
J $reportPath $report
L "OK module_created=True selected_project=$projectHome module_id=$moduleId module_vault=$moduleVault open_cmd=$openCmd report=$reportPath next=revisar-modulo" Green
