param([switch]$Json)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function W([string]$m,[string]$c='Gray'){if(-not $Json){Write-Host $m -ForegroundColor $c}}
function ReadJson([string]$p){if(!(Test-Path $p)){throw 'missing_file: '+$p};return Get-Content -LiteralPath $p -Raw | ConvertFrom-Json}
$Root=(Get-Location).Path
$LatestPath=Join-Path $Root 'data/operator-v2-self-state-sync/v2-state.latest.json'
$RegistryPath=Join-Path $Root 'data/operator-v2-self-state-sync/v2-state.registry.json'
$EventsPath=Join-Path $Root 'data/operator-v2-self-state-sync/v2-state.events.jsonl'
$IndexPath=Join-Path $Root 'documents/operator-v2-self-state-sync/V2_STATE_INDEX.md'
$Latest=ReadJson $LatestPath
$Registry=ReadJson $RegistryPath
$EventsCount=0;if(Test-Path $EventsPath){$EventsCount=(Get-Content -LiteralPath $EventsPath -ErrorAction SilentlyContinue | Measure-Object).Count}
$View=[ordered]@{screen='OPERATOR_V2_STATE';updated_at=$Latest.updated_at;active_objective=$Latest.active_objective.id;active_stage=$Latest.last_stage;last_step=$Latest.last_step;last_status=$Latest.last_status;readiness=$Latest.readiness;next_action=$Latest.next_action;summary=$Latest.human_summary;git_state=$Latest.git_state;events_count=$EventsCount;registry_path=$RegistryPath;latest_path=$LatestPath;index_path=$IndexPath}
if($Json){$View | ConvertTo-Json -Depth 8;return}
W '==== OPERADOR V2 / ESTADO VIVO ====' Cyan
W ('Actualizado: '+$View.updated_at) Gray
W ('Objetivo:    '+$View.active_objective) Green
W ('Stage:       '+$View.active_stage) Green
W ('Paso:        '+$View.last_step) Green
W ('Estado:      '+$View.last_status) Green
W ('Readiness:   '+$View.readiness+'%') Yellow
W '' Gray
W 'GIT' Cyan
W ('Head:        '+$View.git_state.head) Gray
W ('Rev sync:    '+$View.git_state.rev_sync) Gray
W ('Tree clean:  '+$View.git_state.tree_clean) Gray
W '' Gray
W 'RESUMEN' Cyan
W ($View.summary) Gray
W '' Gray
W 'NEXT' Magenta
W ($View.next_action) Magenta
W '' Gray
W ('Events:      '+$View.events_count) Gray
