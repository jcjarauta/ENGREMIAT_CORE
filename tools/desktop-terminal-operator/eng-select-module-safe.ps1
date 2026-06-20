param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$State=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
$ReportDir=Join-Path $Root "reports\operator-navigation-model"
$FreezeValidator=Join-Path $Root "data\operator-navigation-freeze\Validate-OperatorFreeze.ps1"
function Write-Line([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Box([string]$t,[object[]]$l,[string]$c="Cyan"){Write-Line "";Write-Line "==== $t ====" $c;foreach($x in $l){Write-Line ([string]$x) $c}}
function Count-Files([string]$p){if(!(Test-Path -LiteralPath $p)){return 0};return @(Get-ChildItem -LiteralPath $p -Recurse -File -ErrorAction SilentlyContinue).Count}
try{
  New-Item -ItemType Directory -Force -Path $ReportDir|Out-Null
  Box "ENGREMIAT_PACKAGE_BEGIN" @("package=ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001","stage=EXT02_MODULE_SELECTOR_SAFE","mode=STATE_WRITE_ONLY","goal=select_active_module_from_project") "Cyan"
  if(Test-Path -LiteralPath $FreezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $FreezeValidator;if($LASTEXITCODE -ne 0){throw "freeze_validator_failed_before_module_select"}}
  if(!(Test-Path -LiteralPath $State)){throw "missing_state=$State"}
  $s=Get-Content -LiteralPath $State -Raw -Encoding UTF8|ConvertFrom-Json
  $project=[string]$s.active_project
  if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "active_project_missing_or_not_exists=$project"}
  $vault=Join-Path $project "BOVEDA_PROYECTO"
  $mods=Join-Path $project "MODULOS"
  if(!(Test-Path -LiteralPath $mods)){throw "missing_modules_dir=$mods"}
  $allDirs=@(Get-ChildItem -LiteralPath $mods -Directory -ErrorAction SilentlyContinue|Sort-Object Name)
  $modules=@()
  foreach($d in $allDirs){if(!$d.Name.StartsWith(".")){$modules+=$d}}
  if($modules.Count -eq 0){throw "no_modules_found=$mods"}
  $rows=@()
  $i=1
  foreach($m in $modules){
    $mv=Join-Path $m.FullName "BOVEDA_MODULO"
    $mj=Join-Path $mv "00_CONTROL\module.json"
    $ready=((Test-Path -LiteralPath $mv) -and (Test-Path -LiteralPath $mj))
    $current=($s.active_module -and ([string]$s.active_module -eq [string]$m.FullName))
    $rows+=[pscustomobject]@{index=$i;name=$m.Name;path=$m.FullName;vault=$mv;json=$mj;ready=$ready;current=$current;files=(Count-Files $m.FullName)}
    $i++
  }
  while($true){
    Clear-Host
    Box "SELECTOR DE MODULOS" @("Proyecto: $project","Enter/refrescar/f5 = redibujar | a/atras/0 = volver proyecto | numero = entrar") "Cyan"
    Box "MODULOS" (@($rows|ForEach-Object{("["+[string]$_.index+"] "+$_.name+"  "+$(if($_.ready){"READY"}else{"WARN"})+"  files="+$_.files+"  "+$(if($_.current){"<== ACTUAL"}else{""}))})) "Yellow"
    $sel=(Read-Host "ENGREMIAT").Trim()
    $low=$sel.ToLowerInvariant()
    if([string]::IsNullOrWhiteSpace($sel) -or $low -in @("refrescar","f5","menu","comandos","?")){continue}
    if($low -in @("a","atras","atrás","volver","0","b")){
      $s.mode="project";$s.active_module="";$s.active_module_vault="";$s.last_command="select-module-safe-back";$s.next="proyecto";$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $State -Encoding UTF8
      Box "OK" @("status=PASS","action=back_to_project","project=$project") "Green"
      exit
    }
    $n=0
    if(![int]::TryParse($sel,[ref]$n)){Box "WARN" @("Comando no reconocido: $sel") "Yellow";Start-Sleep -Milliseconds 900;continue}
    $pick=$rows|Where-Object{$_.index -eq $n}|Select-Object -First 1
    if($null -eq $pick){Box "WARN" @("Indice fuera de rango: $n") "Yellow";Start-Sleep -Milliseconds 900;continue}
    if(!(Test-Path -LiteralPath $pick.vault)){New-Item -ItemType Directory -Force -Path $pick.vault,(Join-Path $pick.vault "00_CONTROL")|Out-Null}
    if(!(Test-Path -LiteralPath $pick.json)){
      [ordered]@{module=$pick.name;title=$pick.name;lifecycle="ACTIVE_IN_PROJECT";library_status="LEGACY_MODULE_IMPORTED_AS_WARN_REPAIRED_MINIMAL_JSON";objective="Modulo legado seleccionado; module.json minimo creado por selector seguro";project_path=$project;module_path=$pick.path;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $pick.json -Encoding UTF8
    }
    $s.mode="module";$s.active_project=$project;$s.active_master_vault=$vault;$s.active_module=[string]$pick.path;$s.active_module_vault=[string]$pick.vault;$s.last_command="select-module-safe";$s.next="modulo";$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $State -Encoding UTF8
    if(Test-Path -LiteralPath $FreezeValidator){& powershell -NoProfile -ExecutionPolicy Bypass -File $FreezeValidator;if($LASTEXITCODE -ne 0){throw "freeze_validator_failed_after_module_select"}}
    $report=Join-Path $ReportDir ("ext02-select-module-safe-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
    [ordered]@{package="ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001";stage="EXT02_MODULE_SELECTOR_SAFE";status="PASS";project=$project;selected_module=$pick.name;selected_module_path=$pick.path;selected_module_vault=$pick.vault;module_json=$pick.json;freeze_validation_after="PASS";created_at=(Get-Date).ToString("s");next="TEST_OPERATOR_MODULE_LEVEL"}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $report -Encoding UTF8
    Box "OK" @("status=PASS","selected_module=$($pick.name)","active_module=$($pick.path)","module_vault=$($pick.vault)","report=$report","next=TEST_OPERATOR_MODULE_LEVEL") "Green"
    Box "COPIAR" @("Modulo seleccionado y estado actualizado.","Si era WARN sin module.json, se ha creado module.json minimo para hacerlo navegable.","Ahora abre/reinicia operador y debe aparecer en nivel MODULO.") "Magenta"
    Start-Process explorer.exe $pick.path
    Box "ENGREMIAT_PACKAGE_END" @("package=ENGREMIAT_OPERATOR_NAVIGATION_MODEL_001","status=PASS") "Cyan"
    exit
  }
}catch{Box "ERR" @("status=FAIL",$_.Exception.Message) "Red";throw}
