param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$State=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
$ReportDir=Join-Path $Root "reports\operator-navigation-model"
$FreezeValidator=Join-Path $Root "data\operator-navigation-freeze\Validate-OperatorFreeze.ps1"
function Write-Line([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Box([string]$t,[object[]]$l,[string]$c="Cyan"){Write-Line "";Write-Line "==== $t ====" $c;foreach($x in $l){Write-Line ([string]$x) $c}}
function Count-Files([string]$p){if(!(Test-Path -LiteralPath $p)){return 0};return @(Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue).Count}
function Count-Dirs([string]$p){if(!(Test-Path -LiteralPath $p)){return 0};return @(Get-ChildItem -LiteralPath $p -Recurse -Directory -ErrorAction SilentlyContinue).Count}
try{
  New-Item -ItemType Directory -Force -Path $ReportDir|Out-Null
  Box "ENGREMIAT_PACKAGE_BEGIN" @("package=ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001","stage=EXT04_PROJECT_REVIEW_SAFE_V2","mode=READONLY","goal=review_active_project_health_refined") "Cyan"
  if(!(Test-Path -LiteralPath $State)){throw "missing_state=$State"}
  $s=Get-Content -LiteralPath $State -Raw -Encoding UTF8|ConvertFrom-Json
  $project=[string]$s.active_project
  if([string]::IsNullOrWhiteSpace($project)){throw "active_project_empty"}
  $vault=Join-Path $project "BOVEDA_PROYECTO"
  $official=Join-Path $vault "00_PLANTILLA_MAESTRA_OFICIAL"
  $projectJson=Join-Path $vault "00_CONTROL\project.json"
  $templateJson=Join-Path $vault "00_CONTROL\template-source.json"
  $mods=Join-Path $project "MODULOS"
  $moduleInicio=Join-Path $mods "MODULE_inicio"
  $moduleVault=Join-Path $moduleInicio "BOVEDA_MODULO"
  $moduleJson=Join-Path $moduleVault "00_CONTROL\module.json"
  $moduleReadme=Join-Path $moduleVault "README_MODULE_inicio.md"
  $moduleReference=Join-Path $moduleVault "00_PLANTILLA_MAESTRA_REFERENCIA"
  $manifest=Join-Path $project "ARCHIVOS\PLANTILLAS\CURRENT_TEMPLATE_SOURCE.json"
  $required=@($project,$vault,$official,$projectJson,$templateJson,$mods,$moduleInicio,$moduleVault,$moduleJson,$moduleReadme,$moduleReference,$manifest)
  $missing=@()
  foreach($r in $required){if(!(Test-Path -LiteralPath $r)){$missing+=$r}}
  $allDirs=@()
  if(Test-Path -LiteralPath $mods){$allDirs=@(Get-ChildItem -LiteralPath $mods -Directory -ErrorAction SilentlyContinue|Sort-Object Name)}
  $technicalDirs=@()
  $modules=@()
  foreach($d in $allDirs){if($d.Name.StartsWith(".")){$technicalDirs+=$d}else{$modules+=$d}}
  $moduleRows=@()
  $readyCount=0
  $warnCount=0
  foreach($m in $modules){
    $mv=Join-Path $m.FullName "BOVEDA_MODULO"
    $mj=Join-Path $mv "00_CONTROL\module.json"
    $files=Count-Files $m.FullName
    $dirs=Count-Dirs $m.FullName
    $isReady=((Test-Path -LiteralPath $mv) -and (Test-Path -LiteralPath $mj))
    if($isReady){$readyCount++}else{$warnCount++}
    $moduleRows+=[ordered]@{name=$m.Name;path=$m.FullName;status=if($isReady){"READY"}else{"WARN"};has_vault=(Test-Path -LiteralPath $mv);has_module_json=(Test-Path -LiteralPath $mj);files=$files;dirs=$dirs}
  }
  $officialFiles=Count-Files $official
  $moduleRefFiles=Count-Files $moduleReference
  $freezeStatus="UNKNOWN"
  if(Test-Path -LiteralPath $FreezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $FreezeValidator;$freezeStatus=if($LASTEXITCODE -eq 0){"PASS"}else{"WARN"}}
  $status=if($missing.Count -eq 0 -and $officialFiles -ge 10 -and $moduleRefFiles -ge 10 -and $freezeStatus -eq "PASS"){"PASS"}else{"WARN"}
  $report=[ordered]@{package="ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001";stage="EXT04_PROJECT_REVIEW_SAFE_V2";status=$status;readonly=$true;project=$project;missing=$missing;freeze_validation=$freezeStatus;official_master_template=$official;official_master_files=$officialFiles;module_inicio=$moduleInicio;module_reference_files=$moduleRefFiles;modules_ready=$readyCount;modules_warn=$warnCount;technical_dirs_excluded=@($technicalDirs|ForEach-Object{$_.FullName});modules=$moduleRows;manifest=$manifest;project_json=$projectJson;template_json=$templateJson;created_at=(Get-Date).ToString("s");next=if($status -eq "PASS"){"EXT01_CREATE_MODULE_SAFE"}else{"REPAIR_PROJECT_STRUCTURE_BEFORE_EXPANDING"}}
  $json=Join-Path $ReportDir "ext04-project-review-safe-v2-report.json"
  $report|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $json -Encoding UTF8
  if($status -eq "PASS"){Box "OK" @("status=PASS","project=$project","freeze_validation=$freezeStatus","official_master_files=$officialFiles","module_reference_files=$moduleRefFiles","modules_ready=$readyCount","modules_warn=$warnCount","technical_dirs_excluded=$($technicalDirs.Count)","report=$json","next=EXT01_CREATE_MODULE_SAFE") "Green"}else{Box "WARN" @("status=WARN","project=$project","freeze_validation=$freezeStatus","missing="+($missing -join ";"),"official_master_files=$officialFiles","module_reference_files=$moduleRefFiles","modules_ready=$readyCount","modules_warn=$warnCount","technical_dirs_excluded=$($technicalDirs.Count)","report=$json","next=REPAIR_BEFORE_EXPANDING") "Yellow"}
  Box "MODULOS_READY" (@($moduleRows|Where-Object{$_.status -eq "READY"}|ForEach-Object{("module="+$_.name+" | files="+$_.files+" | path="+$_.path)})) "Green"
  Box "MODULOS_WARN" (@($moduleRows|Where-Object{$_.status -eq "WARN"}|ForEach-Object{("module="+$_.name+" | has_vault="+$_.has_vault+" | has_json="+$_.has_module_json+" | files="+$_.files+" | path="+$_.path)})) "Yellow"
  Box "COPIAR" @("Revision readonly refinada completada.","Las carpetas tecnicas como .obsidian no cuentan como modulo.","Si status=PASS, siguiente ampliacion protegida: EXT01_CREATE_MODULE_SAFE.") "Magenta"
  Box "ENGREMIAT_PACKAGE_END" @("package=ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001","status=$status") "Cyan"
}catch{Box "ERR" @("status=FAIL",$_.Exception.Message) "Red";throw}
