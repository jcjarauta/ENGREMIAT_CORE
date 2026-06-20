param()

$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()

$Core = "C:\ENGREMIAT_CORE"
$DocDir = Join-Path $Core "documents"
$IntakeDir = Join-Path $DocDir "intake"
$ReportDir = Join-Path $Core "reports\launcher"
$GrantDir = Join-Path $DocDir "grants"

foreach($d in @($DocDir,$IntakeDir,$ReportDir,$GrantDir)){
  New-Item -ItemType Directory -Force -Path $d | Out-Null
}
foreach($d in @("inbox","profiles","normalized","reports","archive","samples","contracts")){
  New-Item -ItemType Directory -Force -Path (Join-Path $IntakeDir $d) | Out-Null
}

function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
function P(){ [void](Read-Host "Enter") }

function Get-ActiveGrantProfilePath { return (Join-Path $GrantDir "grant-call-profile-latest.json") }
function Get-IntakeProfilePath { return (Join-Path $IntakeDir "normalized\grant-call-profile-from-intake-latest.json") }
function Get-IntakeSourcePath { return (Join-Path $IntakeDir "profiles\intake-source-latest.json") }

function Write-Contracts {
  $sourceContract = [ordered]@{
    contract = "ENGREMIAT_INTAKE_SOURCE_V1"
    purpose = "Representar cualquier entrada de datos al sistema antes de normalizarla."
    fields = [ordered]@{
      source_id = "Identificador estable de fuente"
      source_type = "demo | manual | txt | md | json | folder | pdf_future | sheets_future | drive_future | web_future"
      origin = "Ruta local, URL futura o descripcion humana"
      title = "Titulo legible"
      raw_text_path = "Texto extraido o pegado"
      imported_at = "Fecha de importacion"
      status = "RAW | NORMALIZED | NEEDS_REVIEW | ARCHIVED"
      notes = "Notas humanas"
    }
  }
  $profileContract = [ordered]@{
    contract = "ENGREMIAT_NORMALIZED_PROFILE_V1"
    purpose = "Ficha estructurada utilizable por documentos, tareas, modulos y workers futuros."
    fields = @(
      "nombre_convocatoria",
      "entidad_convocante",
      "territorio",
      "fecha_limite",
      "objetivo_convocatoria",
      "lineas_prioritarias",
      "importe_solicitado",
      "cofinanciacion",
      "beneficiarios",
      "indicadores_requeridos",
      "documentacion_requerida",
      "criterios_valoracion",
      "tono",
      "notas_humanas",
      "source_type",
      "source_path",
      "confidence",
      "human_review_required"
    )
  }
  $sourceContract | ConvertTo-Json -Depth 40 | Set-Content (Join-Path $IntakeDir "contracts\intake-source-contract.json") -Encoding UTF8
  $profileContract | ConvertTo-Json -Depth 40 | Set-Content (Join-Path $IntakeDir "contracts\normalized-profile-contract.json") -Encoding UTF8
}

function New-DemoProfile {
  return [ordered]@{
    nombre_convocatoria = "Convocatoria piloto innovacion social 2026"
    entidad_convocante = "Ayuntamiento piloto"
    territorio = "Cataluna"
    fecha_limite = "2026-09-30"
    objetivo_convocatoria = "Financiar proyectos de innovacion social, transformacion digital comunitaria y economia circular con impacto local medible."
    lineas_prioritarias = @("innovacion social","transformacion digital","economia circular","gestion del conocimiento","fortalecimiento comunitario")
    importe_solicitado = "25000 EUR"
    cofinanciacion = "pendiente de definir / aportacion en horas y recursos propios"
    beneficiarios = @("asociaciones locales","cooperativas","proyectos comunitarios","equipos pequenos con baja capacidad administrativa")
    indicadores_requeridos = @("documentos generados","evidencias registradas","tareas vinculadas a modulos","tiempo ahorrado","entidades piloto acompanadas")
    documentacion_requerida = @("memoria tecnica","memoria economica","cronograma","presupuesto","anexos","evidencias")
    criterios_valoracion = @("impacto","innovacion","viabilidad","sostenibilidad","replicabilidad","capacidad de justificacion")
    tono = "institucional claro"
    notas_humanas = "Ficha demo generada desde Data Intake Center."
    source_type = "demo"
    source_path = "documents/intake/samples/demo"
    confidence = "demo"
    human_review_required = $false
  }
}

function New-BlankProfile {
  return [ordered]@{
    nombre_convocatoria = "PENDIENTE_DEFINIR"
    entidad_convocante = "PENDIENTE_DEFINIR"
    territorio = "PENDIENTE_DEFINIR"
    fecha_limite = "PENDIENTE_DEFINIR"
    objetivo_convocatoria = "PENDIENTE_DEFINIR"
    lineas_prioritarias = @("PENDIENTE_DEFINIR")
    importe_solicitado = "PENDIENTE_DEFINIR"
    cofinanciacion = "PENDIENTE_DEFINIR"
    beneficiarios = @("PENDIENTE_DEFINIR")
    indicadores_requeridos = @("PENDIENTE_DEFINIR")
    documentacion_requerida = @("PENDIENTE_DEFINIR")
    criterios_valoracion = @("PENDIENTE_DEFINIR")
    tono = "institucional claro"
    notas_humanas = "Ficha manual creada desde Data Intake Center."
    source_type = "manual"
    source_path = "manual"
    confidence = "human_pending"
    human_review_required = $true
  }
}

function Save-Profile($profile,$sourceType,$sourcePath){
  $latest = Get-IntakeProfilePath
  $stamp = Get-Date -Format "yyyyMMdd-HHmmss"
  $versioned = Join-Path $IntakeDir ("normalized\grant-call-profile-from-intake-" + $stamp + ".json")
  $profile | ConvertTo-Json -Depth 50 | Set-Content $latest -Encoding UTF8
  $profile | ConvertTo-Json -Depth 50 | Set-Content $versioned -Encoding UTF8
  $source = [ordered]@{
    source_id = "INTAKE-" + $stamp
    source_type = $sourceType
    origin = $sourcePath
    title = $profile.nombre_convocatoria
    normalized_profile = $latest
    imported_at = (Get-Date).ToString("s")
    status = "NORMALIZED"
    notes = "Entrada normalizada local-first."
  }
  $source | ConvertTo-Json -Depth 50 | Set-Content (Get-IntakeSourcePath) -Encoding UTF8
  return [pscustomobject]@{ latest=$latest; versioned=$versioned; source=(Get-IntakeSourcePath) }
}

function Use-ProfileAsActiveGrant($profilePath){
  if(-not(Test-Path $profilePath)){ throw "NO_GO no_existe_profile=$profilePath" }
  Copy-Item $profilePath (Get-ActiveGrantProfilePath) -Force
  return Get-ActiveGrantProfilePath
}

function Import-Demo {
  Write-Contracts
  $p = New-DemoProfile
  $saved = Save-Profile $p "demo" "demo"
  $active = Use-ProfileAsActiveGrant $saved.latest
  $report = Join-Path $ReportDir ("data-intake-demo-e10-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".json")
  [pscustomobject]@{ package="ENGREMIAT_DATA_INTAKE_E10_DEMO"; status="PASS"; normalized=$saved.latest; active_grant_profile=$active; next="DOCUMENTATION_CENTER_15_GENERATE_ADAPTED_DOSSIER" } | ConvertTo-Json -Depth 40 | Set-Content $report -Encoding UTF8
  Clear-Host
  W "==== DEMO NORMALIZADA Y ACTIVADA ====" Cyan
  W ""
  W ("[OK] normalized: {0}" -f $saved.latest) Green
  W ("[OK] active:     {0}" -f $active) Green
  W ("[OK] report:     {0}" -f $report) Green
  W ""
  W "Siguiente: vuelve al Centro Documental y pulsa [15] generar dossier adaptado." Magenta
  W ""
  P
}

function Create-ManualProfile {
  Write-Contracts
  $p = New-BlankProfile
  $saved = Save-Profile $p "manual" "manual"
  $active = Use-ProfileAsActiveGrant $saved.latest
  Start-Process notepad.exe $active
  Clear-Host
  W "==== FICHA MANUAL CREADA Y ACTIVADA ====" Cyan
  W ""
  W ("[OK] normalized: {0}" -f $saved.latest) Green
  W ("[OK] active:     {0}" -f $active) Green
  W ""
  W "Edita y guarda el JSON activo. Luego genera dossier adaptado desde Centro Documental." Yellow
  W ""
  P
}

function Import-TextFromInbox {
  Write-Contracts
  $files = @(Get-ChildItem (Join-Path $IntakeDir "inbox") -File -Include *.txt,*.md -ErrorAction SilentlyContinue)
  if($files.Count -eq 0){
    $sample = Join-Path $IntakeDir "inbox\pegar-convocatoria-aqui.txt"
    @(
      "Pega aqui el texto de una convocatoria.",
      "",
      "En E10 todavia no hay extraccion inteligente.",
      "El sistema creara una ficha pendiente con source_path apuntando a este texto."
    ) | Set-Content $sample -Encoding UTF8
    Clear-Host
    W "==== INBOX VACIO ====" Yellow
    W ""
    W ("[OK] creado ejemplo: {0}" -f $sample) Green
    W "Pega texto real en ese archivo y vuelve a ejecutar [3]." White
    W ""
    P
    return
  }
  $src = $files | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  $p = New-BlankProfile
  $p.source_type = "txt_md"
  $p.source_path = $src.FullName
  $p.notas_humanas = "Ficha pendiente generada desde texto local. Requiere revision humana y/o extractor futuro."
  $p.confidence = "low_manual_review"
  $p.human_review_required = $true
  $saved = Save-Profile $p "txt_md" $src.FullName
  $active = Use-ProfileAsActiveGrant $saved.latest
  $report = Join-Path $ReportDir ("data-intake-text-e10-" + (Get-Date -Format "yyyyMMdd-HHmmss") + ".json")
  [pscustomobject]@{ package="ENGREMIAT_DATA_INTAKE_E10_TEXT"; status="PASS"; source=$src.FullName; normalized=$saved.latest; active_grant_profile=$active; next="EDIT_ACTIVE_PROFILE" } | ConvertTo-Json -Depth 40 | Set-Content $report -Encoding UTF8
  Clear-Host
  W "==== TEXTO IMPORTADO COMO FUENTE ====" Cyan
  W ""
  W ("[OK] source:     {0}" -f $src.FullName) Green
  W ("[OK] normalized: {0}" -f $saved.latest) Green
  W ("[OK] active:     {0}" -f $active) Green
  W ("[OK] report:     {0}" -f $report) Green
  W ""
  W "E10 no extrae campos automaticamente: deja ficha pendiente para revision." Yellow
  W ""
  P
}

function Import-JsonProfile {
  Write-Contracts
  $files = @(Get-ChildItem (Join-Path $IntakeDir "inbox") -File -Filter *.json -ErrorAction SilentlyContinue)
  if($files.Count -eq 0){
    Clear-Host
    W "==== NO HAY JSON EN INBOX ====" Yellow
    W ""
    W ("Carpeta: {0}" -f (Join-Path $IntakeDir "inbox")) Green
    W "Copia un JSON de ficha en inbox y vuelve a ejecutar [4]." White
    W ""
    P
    return
  }
  $src = $files | Sort-Object LastWriteTime -Descending | Select-Object -First 1
  try{ $profile = Get-Content $src.FullName -Raw | ConvertFrom-Json }catch{ throw "json_invalido=$($src.FullName)" }
  $saved = Save-Profile $profile "json" $src.FullName
  $active = Use-ProfileAsActiveGrant $saved.latest
  Clear-Host
  W "==== JSON IMPORTADO Y ACTIVADO ====" Cyan
  W ""
  W ("[OK] source:     {0}" -f $src.FullName) Green
  W ("[OK] normalized: {0}" -f $saved.latest) Green
  W ("[OK] active:     {0}" -f $active) Green
  W ""
  P
}

function Show-IntakeStatus {
  Write-Contracts
  Clear-Host
  W "==== ESTADO DATA INTAKE ====" Cyan
  W ""
  W ("root:       {0}" -f $IntakeDir) Green
  W ("inbox:      {0}" -f (Join-Path $IntakeDir "inbox")) Green
  W ("normalized: {0}" -f (Join-Path $IntakeDir "normalized")) Green
  W ("active:     {0}" -f (Get-ActiveGrantProfilePath)) Green
  W ""
  if(Test-Path (Get-IntakeProfilePath)){ W "[OK] normalized profile latest existe" Green } else { W "[MISS] normalized profile latest no existe" Yellow }
  if(Test-Path (Get-ActiveGrantProfilePath)){ W "[OK] grant-call-profile activo existe" Green } else { W "[MISS] grant-call-profile activo no existe" Yellow }
  W ""
  P
}

function Open-Folder($p){ if(Test-Path $p){ Start-Process explorer.exe $p } }

while($true){
  Clear-Host
  W "==== DATA INTAKE CENTER ====" Cyan
  W ""
  W "Entrada estructurada de datos al sistema Engremiat." DarkCyan
  W "Produce fichas normalizadas que despues consume el Centro Documental." DarkCyan
  W ""
  W "[1] usar fuente demo y activar ficha" White
  W "[2] crear ficha manual editable" White
  W "[3] importar TXT/MD desde inbox" White
  W "[4] importar JSON desde inbox" White
  W "[5] abrir carpeta inbox" White
  W "[6] abrir carpeta normalized" White
  W "[7] ver estado intake" White
  W "[8] abrir contratos intake" White
  W "[b] volver" Cyan
  W ""
  $cmd = Read-Host "DATA_INTAKE"
  if([string]::IsNullOrWhiteSpace($cmd)){ continue }
  if($cmd -eq "b"){ return }
  if($cmd -eq "1"){ Import-Demo; continue }
  if($cmd -eq "2"){ Create-ManualProfile; continue }
  if($cmd -eq "3"){ Import-TextFromInbox; continue }
  if($cmd -eq "4"){ Import-JsonProfile; continue }
  if($cmd -eq "5"){ Open-Folder (Join-Path $IntakeDir "inbox"); continue }
  if($cmd -eq "6"){ Open-Folder (Join-Path $IntakeDir "normalized"); continue }
  if($cmd -eq "7"){ Show-IntakeStatus; continue }
  if($cmd -eq "8"){ Write-Contracts; Open-Folder (Join-Path $IntakeDir "contracts"); continue }
  W "WARN comando_no_reconocido" Yellow
  P
}
