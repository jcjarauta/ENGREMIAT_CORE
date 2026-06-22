param(
  [string]$ProjectPath="",
  [string]$ModulePath=""
)

$ErrorActionPreference="Stop"

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }
function Now(){ return (Get-Date).ToString("s") }
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

function SelectModulePath($project){
  $candidates=@()
  $projectMods=Join-Path $project "MODULOS"
  if(Test-Path $projectMods){
    foreach($m in (Get-ChildItem $projectMods -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
      $candidates += [pscustomobject]@{ source="PROYECTO"; dir=$m }
    }
  }
  $lib="C:\ENGREMIAT_CORE\library\modules"
  if(Test-Path $lib){
    foreach($m in (Get-ChildItem $lib -Directory -ErrorAction SilentlyContinue | Sort-Object Name)){
      $candidates += [pscustomobject]@{ source="BIBLIOTECA"; dir=$m }
    }
  }

  while($true){
    Clear-Host
    W "==== SELECCIONAR MODULO PARA TARJETAS ====" Cyan
    W ("Proyecto activo: {0}" -f (Split-Path $project -Leaf)) White
Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
    W ""
    if(-not $candidates){ W "No hay modulos disponibles." Yellow; P; return "" }

    W ("{0,-4} {1,-12} {2}" -f "N","ORIGEN","MODULO") DarkGray
    W ("{0,-4} {1,-12} {2}" -f "--","------","------") DarkGray
    for($i=0;$i -lt $candidates.Count;$i++){
      $color=if($candidates[$i].source -eq "PROYECTO"){"Green"}else{"Cyan"}
      W ("[{0,-2}] {1,-12} {2}" -f ($i+1),$candidates[$i].source,$candidates[$i].dir.Name) $color
    }

    W ""
    $cmd=Read-Host "MODULO_TARJETAS_SELECTOR"
    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "b"){ return "" }
    if($cmd -as [int]){
      $ix=[int]$cmd-1
      if($ix -ge 0 -and $ix -lt $candidates.Count){ return $candidates[$ix].dir.FullName }
    }
  }
}

function ReadJsonOrDefault($path,$default){
  if(Test-Path $path){
    try { return Get-Content $path -Raw | ConvertFrom-Json }
    catch { return $default }
  }
  return $default
}

function SaveJson($path,$obj){
  $dir=Split-Path $path
  New-Item -ItemType Directory -Force -Path $dir | Out-Null
  $obj | ConvertTo-Json -Depth 60 | Set-Content $path -Encoding UTF8
}

function EnsureWorkspace($project,$module){
  $ws=Join-Path $module "_workspace"
  $dirs=@(
    $ws,
    (Join-Path $ws "tarjetas"),
    (Join-Path $ws "tareas"),
    (Join-Path $ws "tipos"),
    (Join-Path $ws "enlaces"),
    (Join-Path $ws "periodicidad"),
    (Join-Path $ws "estado")
  )
  foreach($d in $dirs){ New-Item -ItemType Directory -Force -Path $d | Out-Null }

  $defs=@(
    @{name="tarjetas"; file="tarjetas\tarjetas.json"; kind="card"},
    @{name="tareas"; file="tareas\tareas.json"; kind="task"},
    @{name="tipos"; file="tipos\tipos.json"; kind="type"},
    @{name="enlaces"; file="enlaces\enlaces.json"; kind="link"}
  )

  foreach($d in $defs){
    $path=Join-Path $ws $d.file
    if(-not(Test-Path $path)){
      SaveJson $path ([pscustomobject]@{
        collection=$d.name
        kind=$d.kind
        module=(Split-Path $module -Leaf)
        project=$project
        created_at=Now
        items=@()
      })
    }
  }

  return $ws
}

function LoadCollection($path,$name,$kind,$module,$project){
  $default=[pscustomobject]@{
    collection=$name
    kind=$kind
    module=(Split-Path $module -Leaf)
    project=$project
    created_at=Now
    items=@()
  }
  $obj=ReadJsonOrDefault $path $default
  if(-not $obj.items){ $obj | Add-Member -NotePropertyName items -NotePropertyValue @() -Force }
  return $obj
}

function SaveCollection($path,$obj){ SaveJson $path $obj }

function CountByStatus($items,$status){
  return @($items | Where-Object { $_.status -eq $status }).Count
}

function CardDecision($card){
  if($card.status -eq "HISTORICO"){ return "HISTORICO" }
  if($card.status -eq "INACTIVO"){ return "DESACTIVADA" }
  if($card.links -and @($card.links).Count -gt 0){ return "VINCULADA" }
  return "SIN_VINCULOS"
}

function NewCard($module){
  Clear-Host
  W "==== NUEVA TARJETA ====" Cyan
  $title=Read-Host "titulo"
  if([string]::IsNullOrWhiteSpace($title)){ return $null }
  $desc=Read-Host "descripcion"
  $priority=Read-Host "prioridad BAJA/MEDIA/ALTA"
  if([string]::IsNullOrWhiteSpace($priority)){ $priority="MEDIA" }

  return [pscustomobject]@{
    id=("card_"+(SafeName $title)+"_"+(Get-Date -Format yyyyMMddHHmmss))
    title=$title
    description=$desc
    kind="card"
    status="ACTIVO"
    priority=$priority.ToUpper()
    module=(Split-Path $module -Leaf)
    links=@()
    created_at=Now
    updated_at=Now
  }
}

function SelectTargetFromCollection($path,$name,$kind,$module,$project){
  $obj=LoadCollection $path $name $kind $module $project
  $items=@($obj.items | Where-Object { $_.status -ne "HISTORICO" })

  while($true){
    Clear-Host
    W "==== SELECCIONAR $($name.ToUpper()) PARA VINCULAR ====" Cyan
    W "numero = seleccionar | n = crear nuevo | b = cancelar" Cyan
    W ""

    if(-not $items){ W "No hay elementos activos." Yellow }
    for($i=0;$i -lt $items.Count;$i++){
      W ("[{0,-2}] {1,-40} {2}" -f ($i+1),$items[$i].title,$items[$i].status) White
    }

    W ""
    $cmd=Read-Host "VINCULAR_$($name.ToUpper())"
    if($cmd -eq "b"){ return $null }

    if($cmd -eq "n"){
      Clear-Host
      W "==== NUEVO ELEMENTO VINCULABLE: $name ====" Cyan
      $title=Read-Host "titulo"
      if([string]::IsNullOrWhiteSpace($title)){ continue }
      $desc=Read-Host "descripcion"
      $new=[pscustomobject]@{
        id=($kind+"_"+(SafeName $title)+"_"+(Get-Date -Format yyyyMMddHHmmss))
        title=$title
        description=$desc
        kind=$kind
        status="ACTIVO"
        priority="MEDIA"
        created_at=Now
        updated_at=Now
      }
      $arr=@($obj.items)
      $arr += $new
      $obj.items=$arr
      SaveCollection $path $obj
      return $new
    }

    if($cmd -as [int]){
      $ix=[int]$cmd-1
      if($ix -ge 0 -and $ix -lt $items.Count){ return $items[$ix] }
    }
  }
}

function AddCardLink($card,$target,$targetType){
  $links=@()
  if($card.links){ $links=@($card.links) }

  $exists=$false
  foreach($l in $links){
    if($l.target_id -eq $target.id -and $l.target_type -eq $targetType){ $exists=$true }
  }

  if(-not $exists){
    $links += [pscustomobject]@{
      target_type=$targetType
      target_id=$target.id
      target_title=$target.title
      linked_at=Now
    }
  }

  $card.links=$links
  $card.updated_at=Now
  return $card
}

function CardLinksScreen($card){
  Clear-Host
  W "==== VINCULOS DE TARJETA ====" Cyan
  W ("Tarjeta: {0}" -f $card.title) White
  W ""
  if(-not $card.links -or @($card.links).Count -eq 0){
    W "Sin vinculos." Yellow
  } else {
    foreach($l in $card.links){
      W (" - {0}: {1} ({2})" -f $l.target_type,$l.target_title,$l.target_id) Green
    }
  }
  P
}

function CardMenu($project,$module,$ws,$cardsPath,$index){
  while($true){
    $cardsObj=LoadCollection $cardsPath "tarjetas" "card" $module $project
    $card=$cardsObj.items[$index]
    $decision=CardDecision $card

    Clear-Host
    W "==== FICHA TARJETA DEL MODULO ====" Cyan
    W ("Tarjeta: {0}" -f $card.title) White
    W ("Estado: {0} | Decision: {1} | Prioridad: {2}" -f $card.status,$decision,$card.priority) $(if($card.status -eq "ACTIVO"){"Green"}elseif($card.status -eq "INACTIVO"){"Yellow"}else{"DarkYellow"})
    W ("Modulo: {0}" -f (Split-Path $module -Leaf)) DarkCyan
    W ("Descripcion: {0}" -f $card.description) DarkGray
    W ("Vinculos: {0}" -f $(if($card.links){@($card.links).Count}else{0})) DarkCyan
    W ("ID: {0}" -f $card.id) DarkGray
    W ""

    W "GESTION" Yellow
    W "e = editar descripcion | p = prioridad | d = desactivar | r = reactivar | h = historico" White
    W ""
    W "VINCULAR" Yellow
    W "vt = vincular tarea | vy = vincular tipo | ve = vincular enlace | vl = ver vinculos" White
    W ""
    W "INSPECCION / PELIGRO" Yellow
    W "j = ver json tarjeta | x = borrar | b = atras" White
    W ""

    $cmd=Read-Host "TARJETA"

    if($cmd -eq "b"){ return }

    if($cmd -eq "e"){
      $card.description=Read-Host "nueva_descripcion"
      $card.updated_at=Now
      $cardsObj.items[$index]=$card
      SaveCollection $cardsPath $cardsObj
      continue
    }

    if($cmd -eq "p"){
      $card.priority=(Read-Host "prioridad BAJA/MEDIA/ALTA").ToUpper()
      $card.updated_at=Now
      $cardsObj.items[$index]=$card
      SaveCollection $cardsPath $cardsObj
      continue
    }

    if($cmd -eq "d"){
      $card.status="INACTIVO"
      $card.updated_at=Now
      $cardsObj.items[$index]=$card
      SaveCollection $cardsPath $cardsObj
      return
    }

    if($cmd -eq "r"){
      $card.status="ACTIVO"
      $card.updated_at=Now
      $cardsObj.items[$index]=$card
      SaveCollection $cardsPath $cardsObj
      return
    }

    if($cmd -eq "h"){
      $card.status="HISTORICO"
      $card.updated_at=Now
      $cardsObj.items[$index]=$card
      SaveCollection $cardsPath $cardsObj
      return
    }

    if($cmd -eq "vt"){
      $target=SelectTargetFromCollection (Join-Path $ws "tareas\tareas.json") "tareas" "task" $module $project
      if($target){
        $card=AddCardLink $card $target "task"
        $cardsObj.items[$index]=$card
        SaveCollection $cardsPath $cardsObj
      }
      continue
    }

    if($cmd -eq "vy"){
      $target=SelectTargetFromCollection (Join-Path $ws "tipos\tipos.json") "tipos" "type" $module $project
      if($target){
        $card=AddCardLink $card $target "type"
        $cardsObj.items[$index]=$card
        SaveCollection $cardsPath $cardsObj
      }
      continue
    }

    if($cmd -eq "ve"){
      $target=SelectTargetFromCollection (Join-Path $ws "enlaces\enlaces.json") "enlaces" "link" $module $project
      if($target){
        $card=AddCardLink $card $target "link"
        $cardsObj.items[$index]=$card
        SaveCollection $cardsPath $cardsObj
      }
      continue
    }

    if($cmd -eq "vl"){
      CardLinksScreen $card
      continue
    }

    if($cmd -eq "j"){
      Clear-Host
      $card | ConvertTo-Json -Depth 30 | Write-Host
      P
      continue
    }

    if($cmd -eq "x"){
      W "s = confirmar borrado | b = cancelar" Yellow
      $c=Read-Host "CONFIRMAR"
      if($c -eq "s" -or $c -eq "S"){
        $arr=@()
        for($i=0;$i -lt $cardsObj.items.Count;$i++){
          if($i -ne $index){ $arr += $cardsObj.items[$i] }
        }
        $cardsObj.items=$arr
        SaveCollection $cardsPath $cardsObj
        return
      }
    }
  }
}

function Main($project,$module){
  if(-not(Test-Path $module)){ throw "module_path_missing=$module" }
  $ws=EnsureWorkspace $project $module
  $cardsPath=Join-Path $ws "tarjetas\tarjetas.json"
  $view="ACTIVOS"
  $query=""

  while($true){
    $cardsObj=LoadCollection $cardsPath "tarjetas" "card" $module $project
    $all=@($cardsObj.items)

    $active=CountByStatus $all "ACTIVO"
    $inactive=CountByStatus $all "INACTIVO"
    $historic=CountByStatus $all "HISTORICO"
    $linked=@($all | Where-Object { $_.links -and @($_.links).Count -gt 0 }).Count
    $unlinked=@($all | Where-Object { $_.status -ne "HISTORICO" -and (-not $_.links -or @($_.links).Count -eq 0) }).Count

    $rows=$all
    if($view -eq "ACTIVOS"){ $rows=@($rows | Where-Object { $_.status -eq "ACTIVO" }) }
    elseif($view -eq "INACTIVOS"){ $rows=@($rows | Where-Object { $_.status -eq "INACTIVO" }) }
    elseif($view -eq "HISTORICOS"){ $rows=@($rows | Where-Object { $_.status -eq "HISTORICO" }) }
    elseif($view -eq "SIN_VINCULOS"){ $rows=@($rows | Where-Object { $_.status -ne "HISTORICO" -and (-not $_.links -or @($_.links).Count -eq 0) }) }

    if($query){
      $rows=@($rows | Where-Object { $_.title -like "*$query*" -or $_.description -like "*$query*" })
    }

    Clear-Host
    W "==== TARJETAS DEL MODULO ====" Cyan
    W ("Modulo: {0} | Proyecto: {1}" -f (Split-Path $module -Leaf),(Split-Path $project -Leaf)) White
    W ("Tarjetas: {0} activas / {1} inactivas / {2} historicas | vinculadas: {3} | sin vinculos: {4}" -f $active,$inactive,$historic,$linked,$unlinked) DarkCyan
    W ("VISTA: {0} | BUSQUEDA: {1}" -f $view,$(if($query){$query}else{"-"})) Magenta
    W "numero = abrir | n nueva | a activas | d inactivas | h historicas | t todas | sv sin vinculos | q buscar | limpiar | o abrir carpeta | b atras | Enter refrescar" Cyan
    W ""

    if(-not $rows){ W "No hay tarjetas en esta vista." Yellow }
    else{
      W ("{0,-4} {1,-38} {2,-10} {3,-8} {4,-12} {5}" -f "N","TARJETA","ESTADO","PRIO","DECISION","DESCRIPCION") DarkGray
      W ("{0,-4} {1,-38} {2,-10} {3,-8} {4,-12} {5}" -f "--","-------","------","----","--------","-----------") DarkGray
      for($i=0;$i -lt $rows.Count;$i++){
        $decision=CardDecision $rows[$i]
        $color=if($rows[$i].status -eq "INACTIVO"){"Yellow"}elseif($rows[$i].status -eq "HISTORICO"){"DarkYellow"}elseif($decision -eq "SIN_VINCULOS"){"DarkYellow"}else{"Green"}
        W ("[{0,-2}] {1,-38} {2,-10} {3,-8} {4,-12} {5}" -f ($i+1),$rows[$i].title,$rows[$i].status,$rows[$i].priority,$decision,$rows[$i].description) $color
      }
    }

    W ""
    $cmd=Read-Host "TARJETAS_MODULO"

    if([string]::IsNullOrWhiteSpace($cmd)){ continue }
    if($cmd -eq "b"){ return }
    if($cmd -eq "o"){ Start-Process explorer.exe (Split-Path $cardsPath); continue }
    if($cmd -eq "a"){ $view="ACTIVOS"; continue }
    if($cmd -eq "d"){ $view="INACTIVOS"; continue }
    if($cmd -eq "h"){ $view="HISTORICOS"; continue }
    if($cmd -eq "t"){ $view="TODAS"; continue }
    if($cmd -eq "sv"){ $view="SIN_VINCULOS"; continue }
    if($cmd -eq "q"){ $query=Read-Host "buscar"; continue }
    if($cmd -eq "limpiar"){ $query=""; $view="ACTIVOS"; continue }

    if($cmd -eq "n"){
      $new=NewCard $module
      if($new){
        $arr=@($cardsObj.items)
        $arr += $new
        $cardsObj.items=$arr
        SaveCollection $cardsPath $cardsObj
      }
      continue
    }

    if($cmd -as [int]){
      $ix=[int]$cmd-1
      if($ix -ge 0 -and $ix -lt $rows.Count){
        $cardsObj=LoadCollection $cardsPath "tarjetas" "card" $module $project
        $realIndex=-1
        for($j=0;$j -lt $cardsObj.items.Count;$j++){
          if($cardsObj.items[$j].id -eq $rows[$ix].id){ $realIndex=$j; break }
        }
        if($realIndex -ge 0){ CardMenu $project $module $ws $cardsPath $realIndex }
      }
    }
  }
}

$ProjectPath=ActiveProject $ProjectPath
if([string]::IsNullOrWhiteSpace($ModulePath)){ $ModulePath=SelectModulePath $ProjectPath; if([string]::IsNullOrWhiteSpace($ModulePath)){ return } }
Main $ProjectPath $ModulePath
