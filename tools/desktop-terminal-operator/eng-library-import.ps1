param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$StateFile=Join-Path $Root "data\desktop-terminal-operator\operator-state.v1.json"
function L([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function Get-State{if(!(Test-Path -LiteralPath $StateFile)){throw "missing_state=$StateFile"};return (Get-Content -LiteralPath $StateFile -Raw -Encoding UTF8|ConvertFrom-Json)}
function Save-State($s){$s|Add-Member -Force -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s");$s|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $StateFile -Encoding UTF8}
function Read-ModuleMeta([string]$ModulePath){
  $candidates=@((Join-Path $ModulePath "BOVEDA_MODULO\module.json"),(Join-Path $ModulePath "00_CONTROL\module.json"),(Join-Path $ModulePath "module.json"))
  foreach($p in $candidates){
    if(Test-Path -LiteralPath $p){
      try{return (Get-Content -LiteralPath $p -Raw -Encoding UTF8|ConvertFrom-Json)}catch{}
    }
  }
  return $null
}
function Get-LibraryCandidates([string]$RootPath,[string]$ActiveProject){
  $exclude=@("\\.git\\","\\node_modules\\","\\reports\\","\\data\\desktop-terminal-operator\\operator-state")
  $dirs=@(Get-ChildItem -LiteralPath $RootPath -Recurse -Directory -Filter "MODULE_*" -ErrorAction SilentlyContinue)
  $out=@()
  foreach($d in $dirs){
    $path=[string]$d.FullName
    if($ActiveProject -and $path.StartsWith($ActiveProject,[System.StringComparison]::OrdinalIgnoreCase)){continue}
    $skip=$false
    foreach($x in $exclude){if($path -match $x){$skip=$true}}
    if($skip){continue}
    $meta=Read-ModuleMeta $path
    $title=$d.Name
    $desc=""
    if($meta){
      foreach($k in @("title","name","module_name","purpose","objective")){if($meta.PSObject.Properties.Name -contains $k -and [string]$meta.$k){$title=[string]$meta.$k;break}}
      foreach($k in @("description","summary","objective","purpose")){if($meta.PSObject.Properties.Name -contains $k -and [string]$meta.$k){$desc=[string]$meta.$k;break}}
    }
    $out += [pscustomobject]@{id=$d.Name;title=$title;description=$desc;path=$path;vault=$(if(Test-Path (Join-Path $path "BOVEDA_MODULO")){Join-Path $path "BOVEDA_MODULO"}else{$path})}
  }
  return @($out|Sort-Object id -Unique)
}
function Copy-ModuleToProject($Candidate,[string]$Project){
  $modsDir=Join-Path $Project "MODULOS"
  New-Item -ItemType Directory -Force -Path $modsDir|Out-Null
  $dest=Join-Path $modsDir $Candidate.id
  if(!(Test-Path -LiteralPath $dest)){
    Copy-Item -LiteralPath $Candidate.path -Destination $dest -Recurse -Force
  }
  $vault=Join-Path $dest "BOVEDA_MODULO"
  if(!(Test-Path -LiteralPath $vault)){New-Item -ItemType Directory -Force -Path $vault|Out-Null}
  $mj=Join-Path $vault "module.json"
  if(Test-Path -LiteralPath $mj){
    try{$meta=Get-Content -LiteralPath $mj -Raw -Encoding UTF8|ConvertFrom-Json}catch{$meta=$null}
    if($meta){
      $meta|Add-Member -Force -NotePropertyName lifecycle -NotePropertyValue "ACTIVE_IN_PROJECT"
      $meta|Add-Member -Force -NotePropertyName library_status -NotePropertyValue "REUSED_IN_PROJECT"
      $meta|Add-Member -Force -NotePropertyName project_path -NotePropertyValue $Project
      $meta|ConvertTo-Json -Depth 50|Set-Content -LiteralPath $mj -Encoding UTF8
    }
  } else {
    [ordered]@{module=$Candidate.id;lifecycle="ACTIVE_IN_PROJECT";library_status="REUSED_IN_PROJECT";project_path=$Project;source_path=$Candidate.path;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $mj -Encoding UTF8
  }
  return [pscustomobject]@{id=$Candidate.id;dest=$dest;vault=$vault}
}
function Parse-Selection([string]$Choice,[int]$Count){
  $x=$Choice.Trim().ToLowerInvariant()
  if($x -eq "all"){return @(0..($Count-1))}
  $parts=@($x -split ","|ForEach-Object{$_.Trim()}|Where-Object{$_})
  $idxs=@()
  foreach($p in $parts){
    if(!($p -match "^\d+$")){return @()}
    $n=[int]$p
    if($n -lt 1 -or $n -gt $Count){return @()}
    $idxs+=($n-1)
  }
  return @($idxs|Sort-Object -Unique)
}
$s=Get-State
$project=[string]$s.active_project
if([string]::IsNullOrWhiteSpace($project) -or !(Test-Path -LiteralPath $project)){throw "no_active_project"}
while($true){
  Clear-Host
  L "BIBLIOTECA MODULOS REUTILIZABLES" Cyan
  $candidates=@(Get-LibraryCandidates -RootPath $Root -ActiveProject $project)
  if($candidates.Count -eq 0){
    L "WARN no hay modulos reutilizables detectados fuera del proyecto activo" Yellow
  } else {
    $i=1
    foreach($c in $candidates){
      L (" ["+$i+"] "+$c.id+" :: "+$c.title) Green
      if($c.description){L ("     "+$c.description) Gray}
      $i++
    }
  }
  L " [all] importar todos" Green
  L " [0] cancelar" Yellow
  L ""
  L "refrescar/f5/Enter = redibujar pantalla | 0/b = cancelar | ejemplo: 1,3 o all" DarkGray
  L ""
  $choice=(Read-Host "Elige modulo(s): 1,3 o all").Trim().ToLowerInvariant()
Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
  if($choice -in @("0","b","a","atras","atrás","back","volver")){exit}
  if($candidates.Count -eq 0){continue}
  $idxs=@(Parse-Selection -Choice $choice -Count $candidates.Count)
  if($idxs.Count -eq 0){
    L "Seleccion no valida. Usa 1, 1,3, all o 0." Yellow
    Start-Sleep -Milliseconds 900
    continue
  }
  $imported=@()
  foreach($idx in $idxs){
    $imported += Copy-ModuleToProject -Candidate $candidates[$idx] -Project $project
  }
  $s=Get-State
  if($imported.Count -eq 1){
    $one=$imported[0]
    $s.mode="module"
    $s.active_module=[string]$one.id
    $s.active_module_vault=[string]$one.vault
    $s.last_command="biblioteca-import-one"
    $s.next="modulo"
  } else {
    $s.mode="project"
    $s.active_module=""
    $s.active_module_vault=""
    $s.last_command="biblioteca-import-many"
    $s.next="proyecto"
  }
  Save-State $s
  $reportDir=Join-Path $Root "reports\operator-navigation-model"
  New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
  $report=Join-Path $reportDir ("library-import-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
  [ordered]@{status="PASS";project=$project;choice=$choice;imported_count=$imported.Count;imported=$imported;mode=$s.mode;active_module=$s.active_module;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 20|Set-Content -LiteralPath $report -Encoding UTF8
  L ("OK imported_count="+$imported.Count+" report="+$report) Green
  Start-Sleep -Milliseconds 900
  exit
}

