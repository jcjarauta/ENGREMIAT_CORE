param(
  [ValidateSet("PROJECT_SPACE","MODULE_SPACE")]
  [string]$SpaceType = "PROJECT_SPACE",
  [string]$Name = "Modulo demo ENGREMIAT",
  [string]$Intent = "Validar generador preview de espacios agrupados",
  [string]$Parent = "",
  [string]$RelatedTo = "",
  [string]$Root = ""
)
$ErrorActionPreference = "Stop"
[Console]::OutputEncoding = [System.Text.UTF8Encoding]::new()
function SafeSlug($s){
  $x=([string]$s).ToLowerInvariant() -replace '[áàäâ]','a' -replace '[éèëê]','e' -replace '[íìïî]','i' -replace '[óòöô]','o' -replace '[úùüû]','u' -replace 'ñ','n' -replace '[^a-z0-9]+','-'
  $x=$x.Trim('-')
  if([string]::IsNullOrWhiteSpace($x)){ return 'unnamed' }
  return $x
}
function SaveJson($p,$o){$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$repo = if([string]::IsNullOrWhiteSpace($Root)){ (Get-Location).Path } else { $Root }
$vault = Join-Path $repo 'obsidian-vault-preview\ENGREMIAT_OBSIDIAN_VAULT'
$slug = SafeSlug $Name
$timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
if($SpaceType -eq 'PROJECT_SPACE'){
  $spaceRoot = Join-Path $vault ('02_PROYECTOS\PROJECT_' + $slug)
  $folders = @('00_INDEX','01_INTAKE','02_ROADMAP','03_TAREAS','04_GATES_DECISIONES','05_EVIDENCIAS','06_WORKERS','07_RESULTADOS','08_RELACIONES')
  $group = 'G03_PROJECTS_MODULES'
  $spaceId = 'PROJECT_' + $slug
}else{
  if([string]::IsNullOrWhiteSpace($Parent)){ $Parent = '02_PROYECTOS\PROJECT_demo-parent' }
  $parentRoot = Join-Path $vault $Parent
  $spaceRoot = Join-Path $parentRoot ('08_RELACIONES\MODULE_' + $slug)
  $folders = @('00_INDEX','01_CONTRATO','02_ROADMAP','03_TAREAS','04_GATES','05_EVIDENCIAS','06_RELACIONES')
  $group = 'G03_PROJECTS_MODULES'
  $spaceId = 'MODULE_' + $slug
}
foreach($f in $folders){ New-Item -ItemType Directory -Force -Path (Join-Path $spaceRoot $f) | Out-Null }
$index = Join-Path $spaceRoot '00_INDEX\INDEX.md'
@('---','type: '+$SpaceType.ToLowerInvariant(),'status: preview','space_id: "'+$spaceId+'"','group: "'+$group+'"','created_at: "'+$timestamp+'"','tags:','  - engremiat/space','  - engremiat/preview','---','# '+$Name,'','## Intención',$Intent,'','## Grupo oficial','`'+$group+'`','','## Relaciones','- Parent: `'+$Parent+'`','- Related to: `'+$RelatedTo+'`','','## Entradas','- [[../01_INTAKE/INTAKE]]','- [[../02_ROADMAP/ROADMAP]]','- [[../03_TAREAS/TASKS]]','- [[../04_GATES_DECISIONES/GATES]]','- [[../05_EVIDENCIAS/EVIDENCE]]','- [[../06_WORKERS/WORKERS]]','- [[PROJECT_CANVAS.canvas]]') | Set-Content -LiteralPath $index -Encoding UTF8
$intakeDir = if($SpaceType -eq 'PROJECT_SPACE'){'01_INTAKE'}else{'01_CONTRATO'}
$intake = Join-Path $spaceRoot ($intakeDir + '\INTAKE.md')
@('---','type: intake','status: preview','space_id: "'+$spaceId+'"','tags:','  - engremiat/intake','---','# Intake / contexto','','## Nombre',$Name,'','## Intención',$Intent,'','## Parent',$Parent,'','## Related to',$RelatedTo) | Set-Content -LiteralPath $intake -Encoding UTF8
$roadmap = Join-Path $spaceRoot '02_ROADMAP\ROADMAP.md'
@('---','type: roadmap','status: preview','space_id: "'+$spaceId+'"','tags:','  - engremiat/roadmap','---','# Roadmap preview','','- E01 · Definir contexto','- E02 · Generar estructura','- E03 · Validar relaciones','- E04 · Preparar gates','- E05 · Cerrar preview') | Set-Content -LiteralPath $roadmap -Encoding UTF8
$tasks = Join-Path $spaceRoot '03_TAREAS\TASKS.md'
@('---','type: task_index','status: preview','space_id: "'+$spaceId+'"','tags:','  - engremiat/tasks','---','# Tareas preview','','- [ ] Revisar contexto','- [ ] Validar grupo','- [ ] Validar relaciones','- [ ] Revisar gates','- [ ] Decidir siguiente paso') | Set-Content -LiteralPath $tasks -Encoding UTF8
$gateDir = if($SpaceType -eq 'PROJECT_SPACE'){'04_GATES_DECISIONES'}else{'04_GATES'}
$gates = Join-Path $spaceRoot ($gateDir + '\GATES.md')
@('---','type: gate_index','status: preview','space_id: "'+$spaceId+'"','tags:','  - engremiat/gates','---','# Gates','','- worker_execution=false','- kanban_write=false','- clien_write=false','- git_write=false','- external_network=false') | Set-Content -LiteralPath $gates -Encoding UTF8
$evidence = Join-Path $spaceRoot '05_EVIDENCIAS\EVIDENCE.md'
@('---','type: evidence_index','status: preview','space_id: "'+$spaceId+'"','tags:','  - engremiat/evidence','---','# Evidencias','','- Builder preview generado.','- Pendiente validación humana.') | Set-Content -LiteralPath $evidence -Encoding UTF8
$workersDir = if($SpaceType -eq 'PROJECT_SPACE'){'06_WORKERS'}else{'06_RELACIONES'}
$workers = Join-Path $spaceRoot ($workersDir + '\WORKERS.md')
@('---','type: worker_preview','status: blocked','space_id: "'+$spaceId+'"','tags:','  - engremiat/workers','---','# Workers preview','','Ejecución real bloqueada por gate humano.') | Set-Content -LiteralPath $workers -Encoding UTF8
$nodes=@(
  [ordered]@{id='index';x=0;y=0;width=250;height=90;type='file';file=$index},
  [ordered]@{id='intake';x=340;y=-140;width=250;height=90;type='file';file=$intake},
  [ordered]@{id='roadmap';x=340;y=0;width=250;height=90;type='file';file=$roadmap},
  [ordered]@{id='tasks';x=340;y=140;width=250;height=90;type='file';file=$tasks},
  [ordered]@{id='gates';x=680;y=-70;width=250;height=90;type='file';file=$gates},
  [ordered]@{id='evidence';x=680;y=70;width=250;height=90;type='file';file=$evidence}
)
$edges=@(
  [ordered]@{id='e1';fromNode='index';fromSide='right';toNode='intake';toSide='left';label='contexto'},
  [ordered]@{id='e2';fromNode='index';fromSide='right';toNode='roadmap';toSide='left';label='plan'},
  [ordered]@{id='e3';fromNode='roadmap';fromSide='right';toNode='tasks';toSide='left';label='tareas'},
  [ordered]@{id='e4';fromNode='tasks';fromSide='right';toNode='gates';toSide='left';label='gate'},
  [ordered]@{id='e5';fromNode='gates';fromSide='right';toNode='evidence';toSide='left';label='evidencia'}
)
$canvas = Join-Path $spaceRoot '00_INDEX\PROJECT_CANVAS.canvas'
SaveJson $canvas ([ordered]@{nodes=$nodes;edges=$edges})
$reportDir = Join-Path $repo 'reports\vault-module-builder'
New-Item -ItemType Directory -Force -Path $reportDir | Out-Null
$result = [ordered]@{status='PASS';space_type=$SpaceType;space_id=$spaceId;space_root=$spaceRoot;group=$group;folders=$folders.Count;canvas=$canvas;safety=[ordered]@{local_only=$true;preview_only=$true;worker_execution=$false;kanban_write=$false;clien_write=$false;git_write=$false;external_network=$false}}
$report = Join-Path $reportDir ('space-generator-preview-' + $slug + '.json')
SaveJson $report $result
Write-Host "OK space_generator_preview status=PASS space_type=$SpaceType space_id=$spaceId space_root=$spaceRoot report=$report" -ForegroundColor Green
