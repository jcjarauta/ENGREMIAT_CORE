param([string]$ProjectPath="")
$ErrorActionPreference="Stop"

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }
function SafeName($s){ return (($s.Trim()) -replace "[^\w\.-]","_") }

function ActiveProject([string]$p){
  if($p -and (Test-Path $p)){ return $p }
  $j="C:\ENGREMIAT_CORE\data\desktop-terminal-operator\active-project.json"
  $t="C:\ENGREMIAT_CORE\data\desktop-terminal-operator\active-project.txt"
  if(Test-Path $j){
    $x=Get-Content $j -Raw | ConvertFrom-Json
    if($x.active_project -and (Test-Path ([string]$x.active_project))){ return [string]$x.active_project }
  }
  if(Test-Path $t){
    $y=(Get-Content $t -Raw).Trim()
    if(Test-Path $y){ return $y }
  }
  throw "active_project_missing"
}

function ReadMod($dir){
  $mj=Join-Path $dir "module.json"
  if(Test-Path $mj){
    try { return Get-Content $mj -Raw | ConvertFrom-Json }
    catch { return [pscustomobject]@{ id=(Split-Path $dir -Leaf); name=(Split-Path $dir -Leaf); status="INVALID_JSON"; type="module"; relations=@() } }
  }
  return [pscustomobject]@{ id=(Split-Path $dir -Leaf); name=(Split-Path $dir -Leaf); status="ACTIVO"; type="module"; relations=@() }
}

function SaveMod($dir,$j){
  if(-not(Test-Path $dir)){ New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  if(-not $j.id){ $j | Add-Member -NotePropertyName id -NotePropertyValue (Split-Path $dir -Leaf) -Force }
  if(-not $j.name){ $j | Add-Member -NotePropertyName name -NotePropertyValue (Split-Path $dir -Leaf) -Force }
  $j | Add-Member -NotePropertyName updated_at -NotePropertyValue (Get-Date).ToString("s") -Force
  $j | ConvertTo-Json -Depth 40 | Set-Content (Join-Path $dir "module.json") -Encoding UTF8
}

function ModStatus($dir){
  $j=ReadMod $dir
  if($j.status){ return ([string]$j.status).ToUpper() }
  return "ACTIVO"
}

function RefreshGraph($p){
  $r=Join-Path $PSScriptRoot "eng-refresh-project-module-graph.ps1"
  if(Test-Path $r){ & powershell -NoProfile -ExecutionPolicy Bypass -File $r -ProjectPath $p | Out-Null }
}

function ProjectModuleRows($p){
  $modsDir=Join-Path $p "MODULOS"
  New-Item -ItemType Directory -Force -Path $modsDir | Out-Null
  $rows=@()
  foreach($m in (Get-ChildItem $modsDir -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
    $rows += [pscustomobject]@{ dir=$m; status=(ModStatus $m.FullName) }
  }
  return $rows
}

function LibraryRows($view,$query){
  $active="C:\ENGREMIAT_CORE\library\modules"
  $historic="C:\ENGREMIAT_CORE\library\modules_historico"
  New-Item -ItemType Directory -Force -Path $active,$historic | Out-Null

  if($view -eq "HISTORICOS"){ $roots=@($historic) }
  elseif($view -eq "TODOS"){ $roots=@($active,$historic) }
  else{ $roots=@($active) }

  $rows=@()
  foreach($root in $roots){
    foreach($m in (Get-ChildItem $root -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
      if($query -and $m.Name -notlike "*$query*"){ continue }

      $s=if($root -eq $historic){"HISTORICO"}else{ModStatus $m.FullName}

      if($view -eq "ACTIVOS" -and ($s -eq "INACTIVO" -or $s -match "HIST")){ continue }
      if($view -eq "DESACTIVADOS" -and $s -ne "INACTIVO"){ continue }

      $rows += [pscustomobject]@{ dir=$m; status=$s; root=$root }
    }
  }

  return $rows
}



function LibraryUsageMap($p){
  $map=@{}
  foreach($m in (ProjectModuleRows $p)){ $map[$m.dir.Name]=$true }
  return $map
}

function LibraryRowsEnriched($p,$view,$query,$filter){
  $usage=LibraryUsageMap $p
  $baseRows=LibraryRows $view $query
  $groups=$baseRows | Group-Object { $_.dir.Name.ToLowerInvariant() }
  $dups=@{}
  foreach($g in $groups){ if($g.Count -gt 1){ $dups[$g.Name]=$true } }

  $rows=@()
  foreach($r in $baseRows){
    $name=$r.dir.Name
    $key=$name.ToLowerInvariant()
    $used=$usage.ContainsKey($name)
    $dup=$dups.ContainsKey($key)

    if($r.status -eq "INACTIVO"){ $decision="DESACTIVADO" }
    elseif($used){ $decision="EN_PROYECTO" }
    elseif($dup){ $decision="DUPLICADO" }
    elseif($r.status -match "HIST"){ $decision="HISTORICO" }
    else{ $decision="SIN_USO" }

    if($filter -eq "USADOS" -and -not $used){ continue }
    if($filter -eq "SIN_USO" -and ($used -or $r.status -match "HIST" -or $r.status -eq "INACTIVO")){ continue }
    if($filter -eq "DUPLICADOS" -and -not $dup){ continue }
    if($filter -eq "DESACTIVADOS" -and $r.status -ne "INACTIVO"){ continue }

    $rows += [pscustomobject]@{
      dir=$r.dir
      status=$r.status
      root=$r.root
      used=$used
      duplicate=$dup
      decision=$decision
    }
  }

  return $rows | Sort-Object @{Expression={if($_.used){0}elseif($_.duplicate){1}elseif($_.status -eq "INACTIVO"){2}elseif($_.status -match "HIST"){4}else{3}}}, @{Expression={$_.dir.Name}}
}



function LibraryModuleSummary($row,$p){
  $name=$row.dir.Name
  $projectModulePath=Join-Path (Join-Path $p "MODULOS") $name
  $inProject=Test-Path $projectModulePath
  $files=@(Get-ChildItem $row.dir.FullName -File -Recurse -ErrorAction SilentlyContinue)
  $dirs=@(Get-ChildItem $row.dir.FullName -Directory -Recurse -ErrorAction SilentlyContinue)

  $summary="-"
  $readme=Join-Path $row.dir.FullName "README.md"
  if(Test-Path $readme){
    $line=Get-Content $readme -ErrorAction SilentlyContinue | Where-Object { -not [string]::IsNullOrWhiteSpace($_) } | Select-Object -First 1
    if($line){ $summary=[string]$line }
  }

  $j=ReadMod $row.dir.FullName
  $origin="-"
  if($j.source_project){ $origin=[string]$j.source_project }
  elseif($j.source_external){ $origin=[string]$j.source_external }
  elseif($j.source){ $origin=[string]$j.source }

  if($row.status -eq "INACTIVO"){ $decision="DESACTIVADO" }
  elseif($inProject){ $decision="YA_ACOPLADO" }
  elseif($row.status -match "HIST"){ $decision="HISTORICO" }
  else{ $decision="DISPONIBLE" }

  return [pscustomobject]@{
    name=$name
    in_project=$inProject
    files=$files.Count
    dirs=$dirs.Count
    summary=$summary
    origin=$origin
    decision=$decision
  }
}



function ImportLibraryItem($p,$row){
  $modsDir=Join-Path $p "MODULOS"
  New-Item -ItemType Directory -Force -Path $modsDir | Out-Null
  $dst=Join-Path $modsDir $row.dir.Name
  if(Test-Path $dst){ W "WARN modulo_ya_existe_en_proyecto=$dst" Yellow; P; return }
  Copy-Item $row.dir.FullName $dst -Recurse -Force
  $j=ReadMod $dst
  $j | Add-Member -NotePropertyName status -NotePropertyValue "ACTIVO" -Force
  SaveMod $dst $j
  RefreshGraph $p
  W "OK modulo_importado_al_proyecto=$($row.dir.Name)" Green
  P
}

function ArchiveLibraryItem($row){
  if($row.status -match "HIST"){ W "WARN ya_es_historico" Yellow; P; return }
  $hist="C:\ENGREMIAT_CORE\library\modules_historico"
  New-Item -ItemType Directory -Force -Path $hist | Out-Null
  $dst=Join-Path $hist $row.dir.Name
  if(Test-Path $dst){ $dst=$dst+"_"+(Get-Date -Format "yyyyMMddHHmmss") }
  Move-Item $row.dir.FullName $dst -Force
  $j=ReadMod $dst
  $j | Add-Member -NotePropertyName status -NotePropertyValue "HISTORICO" -Force
  SaveMod $dst $j
  W "OK enviado_a_historico=$dst" Green
  P
}

function ReactivateLibraryItem($row){
  if($row.status -notmatch "HIST"){ W "WARN ya_esta_activo" Yellow; P; return }
  $active="C:\ENGREMIAT_CORE\library\modules"
  New-Item -ItemType Directory -Force -Path $active | Out-Null
  $dst=Join-Path $active $row.dir.Name
  if(Test-Path $dst){ $dst=$dst+"_"+(Get-Date -Format "yyyyMMddHHmmss") }
  Move-Item $row.dir.FullName $dst -Force
  $j=ReadMod $dst
  $j | Add-Member -NotePropertyName status -NotePropertyValue "ACTIVO" -Force
  SaveMod $dst $j
  W "OK reactivado=$dst" Green
  P
}

function DeleteLibraryItem($row){
  Clear-Host
  W "==== BORRAR MODULO DE BIBLIOTECA ====" Red
  W $row.dir.FullName Yellow
  W "s = confirmar borrado | b = cancelar | BORRAR = compatibilidad" Cyan
  $c=Read-Host "CONFIRMAR"
  if($c -ne "s" -and $c -ne "S" -and $c -ne "BORRAR"){
    W "CANCELADO" Yellow
    P
    return
  }
  Remove-Item $row.dir.FullName -Recurse -Force
  W "OK modulo_borrado_de_biblioteca" Green
  P
}

function NewLibraryModule(){
  Clear-Host
  W "==== NUEVO MODULO DE BIBLIOTECA ====" Cyan
  $name=Read-Host "nombre_modulo_biblioteca"
  if([string]::IsNullOrWhiteSpace($name)){ return }
  $safe=SafeName $name
  $dst=Join-Path "C:\ENGREMIAT_CORE\library\modules" $safe
  if(Test-Path $dst){ W "WARN modulo_ya_existe=$dst" Yellow; P; return }
  New-Item -ItemType Directory -Force -Path $dst | Out-Null
  [pscustomobject]@{
    id=$safe
    name=$name
    type="library_module"
    status="ACTIVO"
    created_at=(Get-Date).ToString("s")
    source="library"
  } | ConvertTo-Json -Depth 20 | Set-Content (Join-Path $dst "module.json") -Encoding UTF8
  Set-Content (Join-Path $dst "README.md") -Encoding UTF8 -Value @("# $name","","Modulo acoplable creado en biblioteca.")
  W "OK creado=$dst" Green
  P
}

function CopyProjectModulesToLibrary($p){
  Clear-Host
  W "==== COPIAR MODULOS DEL PROYECTO A BIBLIOTECA ====" Cyan
  $mods=ProjectModuleRows $p
  if(-not $mods){ W "sin_modulos_en_proyecto" Yellow; P; return }
  for($i=0;$i -lt $mods.Count;$i++){ W (" [{0}] {1}  {2}" -f ($i+1),$mods[$i].dir.Name,$mods[$i].status) Yellow }
  W ""
  W "numero = copiar uno | t = copiar todos | b = atras" Cyan
  $cmd=Read-Host "COPIAR"
  if($cmd -eq "b"){ return }

  $sel=@()
  if($cmd -eq "t"){ $sel=$mods }
  elseif($cmd -as [int]){
    $ix=[int]$cmd-1
    if($ix -ge 0 -and $ix -lt $mods.Count){ $sel=@($mods[$ix]) }
  }

  foreach($m in $sel){
    $dst=Join-Path "C:\ENGREMIAT_CORE\library\modules" $m.dir.Name
    if(Test-Path $dst){ $dst=$dst+"_"+(Get-Date -Format "yyyyMMddHHmmss") }
    Copy-Item $m.dir.FullName $dst -Recurse -Force
    $j=ReadMod $dst
    $j | Add-Member -NotePropertyName status -NotePropertyValue "ACTIVO" -Force
    $j | Add-Member -NotePropertyName source_project -NotePropertyValue $p -Force
    SaveMod $dst $j
    W "OK copiado=$($m.dir.Name)" Green
  }
  P
}

function ScanExternalModulesToLibrary(){
  Clear-Host
  W "==== ESCANEAR CANDIDATOS EXTERNOS ====" Cyan
  $roots=@("C:\ENGREMIAT_CORE\templates","C:\ENGREMIAT_CORE\staging","C:\ENGREMIAT_CORE\backups","C:\Users\pc\Desktop") | Where-Object { Test-Path $_ }
  $c=Get-ChildItem $roots -Recurse -Directory -ErrorAction SilentlyContinue | Where-Object {
    (($_.Name -like "MODULE_*") -or (Test-Path (Join-Path $_.FullName "module.json"))) -and
    ($_.FullName -notlike "C:\ENGREMIAT_CORE\library\modules*") -and
    ($_.FullName -notlike "C:\ENGREMIAT_CORE\library\modules_historico*")
  } | Sort-Object LastWriteTime -Descending | Select-Object -First 60

  if(-not $c){ W "sin_candidatos" Yellow; P; return }

  for($i=0;$i -lt $c.Count;$i++){
    W (" [{0}] {1}" -f ($i+1),$c[$i].Name) Yellow
    W ("     {0}" -f $c[$i].FullName) DarkGray
  }

  W ""
  W "numero = copiar a biblioteca | b = atras" Cyan
  $cmd=Read-Host "SCAN"
  if($cmd -eq "b"){ return }

  if($cmd -as [int]){
    $ix=[int]$cmd-1
    if($ix -ge 0 -and $ix -lt $c.Count){
      $dst=Join-Path "C:\ENGREMIAT_CORE\library\modules" $c[$ix].Name
      if(Test-Path $dst){ $dst=$dst+"_"+(Get-Date -Format "yyyyMMddHHmmss") }
      Copy-Item $c[$ix].FullName $dst -Recurse -Force
      $j=ReadMod $dst
      $j | Add-Member -NotePropertyName status -NotePropertyValue "ACTIVO" -Force
      $j | Add-Member -NotePropertyName source_external -NotePropertyValue $c[$ix].FullName -Force
      SaveMod $dst $j
      W "OK candidato_copiado=$dst" Green
      P
    }
  }
}

function DeactivateLibraryItem($row){
  if($row.status -match "HIST"){ W "WARN no_desactivar_historico_reactivalo_primero" Yellow; P; return }
  if($row.status -eq "INACTIVO"){ W "WARN ya_esta_inactivo" Yellow; P; return }
  $j=ReadMod $row.dir.FullName
  $j | Add-Member -NotePropertyName status -NotePropertyValue "INACTIVO" -Force
  $j | Add-Member -NotePropertyName deactivated_at -NotePropertyValue (Get-Date).ToString("s") -Force
  SaveMod $row.dir.FullName $j
  W "OK modulo_desactivado=$($row.dir.Name)" Green
  P
}

function ActivateLibraryItem($row){
  if($row.status -match "HIST"){ ReactivateLibraryItem $row; return }
  $j=ReadMod $row.dir.FullName
  $j | Add-Member -NotePropertyName status -NotePropertyValue "ACTIVO" -Force
  $j | Add-Member -NotePropertyName activated_at -NotePropertyValue (Get-Date).ToString("s") -Force
  SaveMod $row.dir.FullName $j
  W "OK modulo_activado=$($row.dir.Name)" Green
  P
}
function LibraryItemMenu($p,$row){
  while($true){
    $row.status=ModStatus $row.dir.FullName
    if($row.root -like "*modules_historico*"){ $row.status="HISTORICO" }
    $info=LibraryModuleSummary $row $p

    Clear-Host
    W "==== FICHA MODULO DE BIBLIOTECA ====" Cyan
    W ("Modulo: {0}" -f $info.name) White

    $decisionColor="Cyan"
    if($info.decision -eq "YA_ACOPLADO"){ $decisionColor="Green" }
    elseif($info.decision -eq "DESACTIVADO"){ $decisionColor="Yellow" }
    elseif($info.decision -eq "HISTORICO"){ $decisionColor="DarkYellow" }

    W ("Estado: {0} | Decision: {1}" -f $row.status,$info.decision) $decisionColor
    W ("Proyecto activo: {0}" -f (Split-Path $p -Leaf)) DarkCyan

    if($info.in_project){ W "Acoplado al proyecto: SI" Green }
    else{ W "Acoplado al proyecto: NO" Yellow }

    W ("Contenido: {0} archivos | {1} carpetas" -f $info.files,$info.dirs) DarkCyan
    W ("Resumen: {0}" -f $info.summary) DarkGray
    W ("Origen: {0}" -f $info.origin) DarkGray
    W ("Ruta: {0}" -f $row.dir.FullName) DarkGray
    W ""

    W "ACCIONES PRINCIPALES" Yellow
    if($info.in_project){ W "i = importar/acoplar al proyecto  BLOQUEADO: ya existe en el proyecto" DarkGray }
    elseif($row.status -eq "INACTIVO"){ W "i = importar/acoplar al proyecto  BLOQUEADO: modulo inactivo" DarkGray }
    else{ W "i = importar/acoplar al proyecto" White }

    if($row.status -match "HIST"){
      W "r = reactivar en biblioteca activa" White
    } elseif($row.status -eq "INACTIVO"){
      W "r = activar modulo" White
      W "h = enviar a historico" White
    } else {
      W "d = desactivar modulo" White
      W "h = enviar a historico" White
    }

    W ""
    W "INSPECCION" Yellow
    W "w = espacio de trabajo | o = abrir carpeta | j = ver module.json | f = listar archivos | b = atras" White
    W ""
    W "PELIGRO" Yellow
    W "x = borrar de biblioteca con confirmacion" Red
    W ""

    $cmd=Read-Host "BIB_MOD"

    if($cmd -eq "b"){ return }

    if($cmd -eq "i"){
      if($info.in_project){ W "WARN modulo_ya_existe_en_proyecto" Yellow; P; continue }
      if($row.status -eq "INACTIVO"){ W "WARN modulo_inactivo_reactivalo_antes" Yellow; P; continue }
      ImportLibraryItem $p $row
      return
    }

    if($cmd -eq "d" -and $row.status -eq "ACTIVO"){
      DeactivateLibraryItem $row
      return
    }

    if($cmd -eq "h" -and $row.status -notmatch "HIST"){
      ArchiveLibraryItem $row
      return
    }

    if($cmd -eq "r"){
      ActivateLibraryItem $row
      return
    }

    if($cmd -eq "w"){ & powershell -NoProfile -ExecutionPolicy Bypass -File (Join-Path $PSScriptRoot "eng-module-workspace-screen.ps1") -ProjectPath $p -ModulePath $row.dir.FullName; continue }

    if($cmd -eq "o"){
      Start-Process explorer.exe $row.dir.FullName
      continue
    }

    if($cmd -eq "j"){
      Clear-Host
      $mj=Join-Path $row.dir.FullName "module.json"
      if(Test-Path $mj){ Get-Content $mj -Raw | Write-Host }
      else{ W "sin module.json" Yellow }
      P
      continue
    }

    if($cmd -eq "f"){
      Clear-Host
      W "==== ARCHIVOS DEL MODULO ====" Cyan
      Get-ChildItem $row.dir.FullName -Recurse -Force -ErrorAction SilentlyContinue |
        Select-Object FullName,Length,LastWriteTime |
        Format-Table -AutoSize
      P
      continue
    }

    if($cmd -eq "x"){
      DeleteLibraryItem $row
      return
    }
  }
}



function SetLibraryItemInactiveSilent($row){
  if($row.status -match "HIST"){ return [pscustomobject]@{name=$row.dir.Name;status="SKIP";reason="historico"} }
  if($row.status -eq "INACTIVO"){ return [pscustomobject]@{name=$row.dir.Name;status="SKIP";reason="ya_inactivo"} }
  $j=ReadMod $row.dir.FullName
  $j | Add-Member -NotePropertyName status -NotePropertyValue "INACTIVO" -Force
  $j | Add-Member -NotePropertyName deactivated_at -NotePropertyValue (Get-Date).ToString("s") -Force
  $j | Add-Member -NotePropertyName deactivated_reason -NotePropertyValue "manual_from_library_management" -Force
  SaveMod $row.dir.FullName $j
  return [pscustomobject]@{name=$row.dir.Name;status="OK";reason="desactivado"}
}

function DeactivateVisibleLibrarySelection($rows){
  Clear-Host
  W "==== DESACTIVAR MODULOS DE BIBLIOTECA ====" Yellow
  W "La desactivacion no borra ni historiza. Solo oculta el modulo de la vista activa/acoplable." DarkCyan
  W ""
  if(-not $rows){
    W "No hay modulos visibles para desactivar." Yellow
    P
    return
  }

  for($i=0;$i -lt $rows.Count;$i++){
    $risk=if($rows[$i].used){"EN_PROYECTO"}elseif($rows[$i].status -match "HIST"){"HISTORICO"}elseif($rows[$i].status -eq "INACTIVO"){"YA_INACTIVO"}else{"OK"}
    $color=if($risk -eq "EN_PROYECTO"){"Yellow"}elseif($risk -eq "HISTORICO"){"DarkGray"}else{"White"}
    W ("[{0,-2}] {1,-44} {2,-12} {3}" -f ($i+1),$rows[$i].dir.Name,$rows[$i].status,$risk) $color
  }

  W ""
  W "Seleccion: numero | 1,2 | t = todos visibles | b = cancelar" Cyan
  $cmd=Read-Host "DESACTIVAR"
  if($cmd -eq "b"){ return }

  $targets=@()
  if($cmd -eq "t"){
    $targets=@($rows)
  } elseif($cmd -match '^\d+(,\d+)*$'){
    foreach($part in ($cmd -split ',')){
      $ix=[int]$part-1
      if($ix -ge 0 -and $ix -lt $rows.Count){ $targets += $rows[$ix] }
    }
  }

  if(-not $targets){
    W "sin_seleccion_valida" Yellow
    P
    return
  }

  Clear-Host
  W "==== CONFIRMAR DESACTIVACION ====" Yellow
  W ("Seleccionados: {0}" -f $targets.Count) White
  W ""
  foreach($t in $targets){
    $note=if($t.used){"EN_PROYECTO"}else{$t.status}
    W (" - {0}  {1}" -f $t.dir.Name,$note) DarkGray
  }
  W ""
  W "s = confirmar | b = cancelar" Cyan
  $confirm=Read-Host "CONFIRMAR"
  if($confirm -ne "s" -and $confirm -ne "S"){
    W "CANCELADO" Yellow
    P
    return
  }

  $results=@()
  foreach($t in $targets){ $results += SetLibraryItemInactiveSilent $t }

  Clear-Host
  W "==== RESULTADO DESACTIVACION ====" Cyan
  foreach($r in $results){
    $color=if($r.status -eq "OK"){"Green"}else{"Yellow"}
    W ("{0,-6} {1,-44} {2}" -f $r.status,$r.name,$r.reason) $color
  }
  W ""
  W "next=volver_a_gestion_biblioteca_y_revisar_d_desactivados" Magenta
  P
}

function ManageLibraryModules($p,[string]$initialFilter="TODOS",[string]$initialView="ACTIVOS"){
  $view=$initialView
  $query=""
  $filter=$initialFilter

  while($true){
    $projectRows=ProjectModuleRows $p
    $activeCount=(LibraryRows "ACTIVOS" "").Count
    $inactiveCount=(LibraryRows "DESACTIVADOS" "").Count
    $historicCount=(LibraryRows "HISTORICOS" "").Count
    $rows=LibraryRowsEnriched $p $view $query $filter

    Clear-Host
    W "==== GESTIONAR BIBLIOTECA ====" Cyan
    W ("Proyecto activo: {0}" -f (Split-Path $p -Leaf)) White
    W ("Proyecto: {0} modulos | Biblioteca: {1} activos / {2} inactivos / {3} historicos" -f $projectRows.Count,$activeCount,$inactiveCount,$historicCount) DarkCyan
    W ("VISTA: {0} | FILTRO: {1} | BUSQUEDA: {2}" -f $view,$filter,$(if($query){$query}else{"-"})) Magenta
    W "numero = abrir | D desactivar seleccion | a activos | d desactivados | h historicos | t todos | u usados | z sin uso | q buscar | limpiar | b atras | Enter refrescar" Cyan
    W ""

    if(-not $rows){
      W "No hay modulos para esta vista/filtro/busqueda." DarkYellow
    } else {
      W ("{0,-4} {1,-44} {2,-12} {3,-12} {4}" -f "N","MODULO","ESTADO","USO","DECISION") DarkGray
      W ("{0,-4} {1,-44} {2,-12} {3,-12} {4}" -f "--","------","------","---","--------") DarkGray
      for($i=0;$i -lt $rows.Count;$i++){
        $use=if($rows[$i].used){"PROYECTO"}else{"-"}
        if($rows[$i].decision -eq "EN_PROYECTO"){ $color="Green" }
        elseif($rows[$i].decision -eq "DUPLICADO"){ $color="Yellow" }
        elseif($rows[$i].decision -eq "DESACTIVADO"){ $color="Yellow" }
        elseif($rows[$i].decision -eq "SIN_USO"){ $color="DarkYellow" }
        else{ $color="DarkGray" }
        W ("[{0,-2}] {1,-44} {2,-12} {3,-12} {4}" -f ($i+1),$rows[$i].dir.Name,$rows[$i].status,$use,$rows[$i].decision) $color
      }
    }

    W ""
    $cmd=Read-Host "GESTION_BIBLIOTECA"

    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "b"){ return }
    if($cmd -eq "D"){ DeactivateVisibleLibrarySelection $rows; continue }
    if($cmd -eq "a"){ $view="ACTIVOS"; $filter="TODOS"; continue }
    if($cmd -eq "d"){ $view="DESACTIVADOS"; $filter="TODOS"; continue }
    if($cmd -eq "h"){ $view="HISTORICOS"; $filter="TODOS"; continue }
    if($cmd -eq "t"){ $view="TODOS"; $filter="TODOS"; continue }
    if($cmd -eq "u"){ $filter="USADOS"; continue }
    if($cmd -eq "z"){ $filter="SIN_USO"; continue }
    if($cmd -eq "limpiar"){ $query=""; $filter="TODOS"; continue }
    if($cmd -eq "q"){ $query=Read-Host "buscar_nombre"; continue }

    if($cmd -as [int]){
      $ix=[int]$cmd-1
      if($ix -ge 0 -and $ix -lt $rows.Count){ LibraryItemMenu $p $rows[$ix] }
      else{ W "WARN modulo_no_existe_en_lista_actual" Yellow; P }
    }
  }
}





function LibraryEditScreen($p){
  while($true){
    $projectRows=ProjectModuleRows $p
    $activeRows=LibraryRows "ACTIVOS" ""
    $inactiveRows=LibraryRows "DESACTIVADOS" ""
    $historicRows=LibraryRows "HISTORICOS" ""

    Clear-Host
    W "==== EDITAR BIBLIOTECA DE MODULOS ====" Cyan
    W ("Proyecto activo: {0}" -f (Split-Path $p -Leaf)) White
    W ("Proyecto/modulos: {0} | Biblioteca activos: {1} | inactivos: {2} | historicos: {3}" -f $projectRows.Count,$activeRows.Count,$inactiveRows.Count,$historicRows.Count) DarkCyan
    W ""
    W "GESTION / DECISION" Yellow
    W "m  = gestionar todos los modulos de biblioteca" White
    W "u  = ver usados en proyecto" White
    W "z  = ver sin uso" White
    W "d  = ver desactivados" White
    W ""
    W "CREAR / ALIMENTAR BIBLIOTECA" Yellow
    W "n  = nuevo modulo biblioteca" White
    W "p  = copiar modulos del proyecto activo a biblioteca" White
    W "s  = escanear candidatos externos y copiar a biblioteca" White
    W ""
    W "CARPETAS" Yellow
    W "oa = abrir biblioteca activa" White
    W "oh = abrir biblioteca historica" White
    W "b  = atras" White
    W ""
    W "Referencia proyecto activo:" DarkCyan

    $limit=[Math]::Min(8,$projectRows.Count)
    for($i=0;$i -lt $limit;$i++){ W (" - {0}  {1}" -f $projectRows[$i].dir.Name,$projectRows[$i].status) DarkGray }
    if($projectRows.Count -gt $limit){ W (" - ... {0} mas" -f ($projectRows.Count-$limit)) DarkGray }

    W ""
    $cmd=Read-Host "EDITAR_BIBLIOTECA"

    if($cmd -eq "b"){ return }
    if($cmd -eq "m"){ ManageLibraryModules $p "TODOS" "ACTIVOS"; continue }
    if($cmd -eq "u"){ ManageLibraryModules $p "USADOS" "TODOS"; continue }
    if($cmd -eq "z"){ ManageLibraryModules $p "SIN_USO" "ACTIVOS"; continue }
    if($cmd -eq "d"){ ManageLibraryModules $p "TODOS" "DESACTIVADOS"; continue }
    if($cmd -eq "n"){ NewLibraryModule; continue }
    if($cmd -eq "p"){ CopyProjectModulesToLibrary $p; continue }
    if($cmd -eq "s"){ ScanExternalModulesToLibrary; continue }
    if($cmd -eq "oa"){ Start-Process explorer.exe "C:\ENGREMIAT_CORE\library\modules"; continue }
    if($cmd -eq "oh"){ Start-Process explorer.exe "C:\ENGREMIAT_CORE\library\modules_historico"; continue }
  }
}



function LibraryScreen($p){
  $view="ACTIVOS"
  $query=""

  while($true){
    $projectRows=ProjectModuleRows $p
    $activeCount=(LibraryRows "ACTIVOS" "").Count
    $inactiveCount=(LibraryRows "DESACTIVADOS" "").Count
    $historicCount=(LibraryRows "HISTORICOS" "").Count
    $rows=LibraryRows $view $query

    Clear-Host
    W "==== BIBLIOTECA DE MODULOS ====" Cyan
    W ("Proyecto activo: {0} | modulos proyecto: {1}" -f (Split-Path $p -Leaf),$projectRows.Count) White
    W ("Biblioteca: {0} activos / {1} inactivos / {2} historicos" -f $activeCount,$inactiveCount,$historicCount) DarkCyan
    W ("VISTA: {0} | BUSQUEDA: {1}" -f $view,$(if($query){$query}else{"-"})) Magenta
    W "numero = abrir modulo | a = activos | d = desactivados | h = historicos | t = todos | q = buscar | limpiar | e = editar biblioteca | b = atras | Enter = refrescar" Cyan
    W ""

    if(-not $rows){ W "No hay modulos en esta vista. Usa e para editar biblioteca." DarkYellow }

    for($i=0;$i -lt $rows.Count;$i++){
      $color=if($rows[$i].status -eq "INACTIVO"){"Yellow"}elseif($rows[$i].status -match "HIST"){"DarkYellow"}else{"Green"}
      W (" [{0}] {1}  {2}" -f ($i+1),$rows[$i].dir.Name,$rows[$i].status) $color
    }

    W ""
    $cmd=Read-Host "BIBLIOTECA"

    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "b"){ return }
    if($cmd -eq "a"){ $view="ACTIVOS"; continue }
    if($cmd -eq "d"){ $view="DESACTIVADOS"; continue }
    if($cmd -eq "h"){ $view="HISTORICOS"; continue }
    if($cmd -eq "t"){ $view="TODOS"; continue }
    if($cmd -eq "q"){ $query=Read-Host "buscar_nombre"; continue }
    if($cmd -eq "limpiar"){ $query=""; continue }
    if($cmd -eq "e"){ LibraryEditScreen $p; continue }

    if($cmd -as [int]){
      $ix=[int]$cmd-1
      if($ix -ge 0 -and $ix -lt $rows.Count){ LibraryItemMenu $p $rows[$ix] }
      else{ W "WARN modulo_no_existe_en_lista_actual" Yellow; P }
    }
  }
}



$ProjectPath=ActiveProject $ProjectPath
LibraryScreen $ProjectPath



