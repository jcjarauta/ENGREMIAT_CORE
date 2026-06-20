param(
  [string]$Name = "Demo Relation Router",
  [ValidateSet("MASTER_VAULT","PROJECT_SPACE","MODULE_SPACE","RELATION_SPACE","WORK_SURFACE")]
  [string]$SpaceType = "MODULE_SPACE",
  [string]$Intent = "Validar router de grupos y relaciones",
  [string]$Parent = "02_PROYECTOS/PROJECT_demo-builder-project-space",
  [string]$RelatedTo = "G04_MEMORY_VISUAL",
  [string]$PreferredSurface = "GROUPED_CANVAS",
  [string]$Root = ""
)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function SafeSlug($s){
  $x=([string]$s).ToLowerInvariant() -replace '[áàäâ]','a' -replace '[éèëê]','e' -replace '[íìïî]','i' -replace '[óòöô]','o' -replace '[úùüû]','u' -replace 'ñ','n' -replace '[^a-z0-9]+','-'
  $x=$x.Trim('-')
  if([string]::IsNullOrWhiteSpace($x)){return 'unnamed'}
  return $x
}
function SaveJson($p,$o){$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$repo=if([string]::IsNullOrWhiteSpace($Root)){(Get-Location).Path}else{$Root}
$vault=Join-Path $repo 'obsidian-vault-preview\ENGREMIAT_OBSIDIAN_VAULT'
$slug=SafeSlug $Name
$groupMap=@{
  MASTER_VAULT='G01_CORE'
  PROJECT_SPACE='G03_PROJECTS_MODULES'
  MODULE_SPACE='G03_PROJECTS_MODULES'
  RELATION_SPACE='G04_MEMORY_VISUAL'
  WORK_SURFACE='G02_HUMAN_CONTROL'
}
$group=$groupMap[$SpaceType]
if([string]::IsNullOrWhiteSpace($group)){throw 'unknown_group_for_space_type'}
$targetRoot=$null
switch($SpaceType){
  'MASTER_VAULT' { $targetRoot=$vault }
  'PROJECT_SPACE' { $targetRoot=Join-Path $vault ('02_PROYECTOS\PROJECT_'+$slug) }
  'MODULE_SPACE' { $targetRoot=Join-Path $vault ((($Parent -replace '/','\').Trim('\'))+'\08_RELACIONES\MODULE_'+$slug) }
  'RELATION_SPACE' { $targetRoot=Join-Path $vault ((($Parent -replace '/','\').Trim('\'))+'\08_RELACIONES\REL_'+$slug) }
  'WORK_SURFACE' { $targetRoot=Join-Path $vault ('00_CONTROL_OPERATIVO\SURFACE_'+$slug) }
}
$route=[ordered]@{
  name=$Name
  slug=$slug
  space_type=$SpaceType
  intent=$Intent
  group=$group
  parent=$Parent
  related_to=$RelatedTo
  preferred_surface=$PreferredSurface
  target_root=$targetRoot
  planned_outputs=@('relation_note','group_assignment','index_update_preview','canvas_edge_preview','dashboard_pointer')
  safety=[ordered]@{local_only=$true;preview_only=$true;worker_execution=$false;kanban_write=$false;clien_write=$false;git_write=$false;external_network=$false}
}
$previewDir=Join-Path $repo 'data\vault-module-builder\relation-router-preview'
New-Item -ItemType Directory -Force -Path $previewDir|Out-Null
$routePath=Join-Path $previewDir ('route-'+$slug+'.json')
SaveJson $routePath $route
$vaultRelDir=Join-Path $vault '07_OBSIDIAN_GRAPH\RELATION_ROUTER_PREVIEW'
New-Item -ItemType Directory -Force -Path $vaultRelDir|Out-Null
$notePath=Join-Path $vaultRelDir ('ROUTE_'+$slug+'.md')
@('---','type: relation_route_preview','status: preview','space_type: "'+$SpaceType+'"','group: "'+$group+'"','preferred_surface: "'+$PreferredSurface+'"','tags:','  - engremiat/router','  - engremiat/preview','---','# Route preview · '+$Name,'','## Intent',$Intent,'','## Group','`'+$group+'`','','## Parent','`'+$Parent+'`','','## Related to','`'+$RelatedTo+'`','','## Target root','`'+$targetRoot+'`','','## Safety','worker_execution=false · kanban_write=false · clien_write=false · git_write=false')|Set-Content -LiteralPath $notePath -Encoding UTF8
$canvasPath=Join-Path $vaultRelDir ('ROUTE_'+$slug+'.canvas')
$nodes=@(
  [ordered]@{id='human';x=0;y=0;width=240;height=90;type='text';text="Decisión humana`n$SpaceType";color='2'},
  [ordered]@{id='group';x=340;y=0;width=240;height=90;type='text';text="Grupo oficial`n$group";color='3'},
  [ordered]@{id='target';x=680;y=0;width=300;height=90;type='text';text="Target root`n$targetRoot";color='4'},
  [ordered]@{id='surface';x=1040;y=0;width=260;height=90;type='text';text="Superficie`n$PreferredSurface";color='5'}
)
$edges=@(
  [ordered]@{id='e1';fromNode='human';fromSide='right';toNode='group';toSide='left';label='agrupa'},
  [ordered]@{id='e2';fromNode='group';fromSide='right';toNode='target';toSide='left';label='ubica'},
  [ordered]@{id='e3';fromNode='target';fromSide='right';toNode='surface';toSide='left';label='muestra'}
)
SaveJson $canvasPath ([ordered]@{nodes=$nodes;edges=$edges})
$reportDir=Join-Path $repo 'reports\vault-module-builder'
New-Item -ItemType Directory -Force -Path $reportDir|Out-Null
$report=Join-Path $reportDir ('relation-router-preview-'+$slug+'.json')
$result=[ordered]@{status='PASS';route=$routePath;note=$notePath;canvas=$canvasPath;space_type=$SpaceType;group=$group;target_root=$targetRoot;preferred_surface=$PreferredSurface;safety=$route.safety}
SaveJson $report $result
Write-Host "OK relation_router_preview status=PASS space_type=$SpaceType group=$group target_root=$targetRoot report=$report" -ForegroundColor Green
