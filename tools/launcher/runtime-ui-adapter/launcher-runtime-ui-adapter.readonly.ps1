param([string]$Command='estado',[string]$ActionId='DEMO-CANONICAL-MODULE-ACTION-001')
$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$package='ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001'
$stage='LAUNCHER_RUNTIME_UI_ADAPTER_READONLY'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
function ReadJson($p){Get-Content -LiteralPath $p -Raw -Encoding UTF8 | ConvertFrom-Json}
function SafeId($v){return ($v -replace '[^A-Za-z0-9_\-]','_')}
try{
  W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage command=$Command action_id=$ActionId" Cyan
  $base=Join-Path $root 'documents\launcher-canonical-action-runtime'
  $safe=SafeId $ActionId
  $state=Join-Path $base "state\$safe\canonical-action-state.latest.json"
  $preview=Join-Path $base "previews\$safe\canonical-action-dry-run-preview.latest.json"
  $unlock=Join-Path $base "unlocks\$safe\canonical-action-unlock.latest.json"
  $plan=Join-Path $base "plans\$safe\approved-action-plan.latest.json"
  $execution=Join-Path $base "executions\$safe\action-execution.latest.json"
  $known=@($state,$preview,$unlock,$plan,$execution)
  $cmd=$Command.ToLowerInvariant().Trim()
  if($cmd -eq '' -or $cmd -eq 'refrescar' -or $cmd -eq 'f5'){$cmd='estado'}
  if($cmd -eq '?' -or $cmd -eq 'ayuda' -or $cmd -eq 'comandos'){
    W "COMANDOS RUNTIME UI" Cyan
    W "acciones  = listar acciones detectadas" Gray
    W "estado    = ver estado compacto" Gray
    W "preview   = ver dry-run preview" Gray
    W "aprobar   = NO_GO readonly: requiere comando real/autorizacion fuera del adapter" Yellow
    W "ejecutar  = NO_GO readonly: requiere comando real/autorizacion fuera del adapter" Yellow
    W "volver    = volver al menu anterior" Gray
    W "Enter/refrescar/f5 = redibujar pantalla | ? = ayuda | comandos = menu actual" DarkGray
    W "ENGREMIAT_PACKAGE_END package=$package status=PASS mode=READONLY_HELP" Cyan
    exit 0
  }
  if($cmd -eq 'volver' -or $cmd -eq 'b' -or $cmd -eq 'back'){
    W "OK volver_requested=True target=previous_launcher_menu real_execution=False ui_mutated=False" Green
    W "ENGREMIAT_PACKAGE_END package=$package status=PASS mode=READONLY_BACK" Cyan
    exit 0
  }
  if($cmd -eq 'aprobar' -or $cmd -eq 'ejecutar'){
    W "NO_GO adapter_readonly=True command=$cmd authorization_required=True use_runtime_pending_auth_scripts=True real_execution=False ui_mutated=False worker=False browser=False network=False git=False" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=ADAPTER_READONLY_DOES_NOT_EXECUTE_SENSITIVE_COMMANDS" Yellow
    exit 0
  }
  if($cmd -eq 'acciones' -or $cmd -eq 'runtime'){
    W "ACCIONES CANONICAS DETECTADAS" Cyan
    $actionsRoot=Join-Path $base 'actions'
    $items=Get-ChildItem -LiteralPath $actionsRoot -Directory -ErrorAction SilentlyContinue | Sort-Object Name
    foreach($it in $items){W (" - "+$it.Name) Gray}
    W "OK actions_list_readonly=True count=$($items.Count)" Green
    W "ENGREMIAT_PACKAGE_END package=$package status=PASS mode=READONLY_ACTIONS" Cyan
    exit 0
  }
  if($cmd -eq 'preview' -or $cmd -eq 'ver' -or $cmd -eq 'detalle'){
    if(-not(Test-Path -LiteralPath $preview)){throw "PREVIEW_NOT_FOUND path=$preview"}
    $p=ReadJson $preview
    W "PREVIEW DRY-RUN" Cyan
    W "action_id=$($p.action_id)" Gray
    W "mode=$($p.mode)" Gray
    W "gate=$($p.planned_state.gate_status_before) -> $($p.planned_state.gate_status_after)" Gray
    W "unlock=$($p.planned_state.unlock_status_before) -> $($p.planned_state.unlock_status_after)" Gray
    W "execution=$($p.planned_state.execution_status_before) -> $($p.planned_state.execution_status_after)" Gray
    W "real_execution=False gate_mutated=False action_executed=False" Yellow
    W "ENGREMIAT_PACKAGE_END package=$package status=PASS mode=READONLY_PREVIEW" Cyan
    exit 0
  }
  if($cmd -eq 'estado' -or $cmd -eq 'status' -or $cmd -eq 'e'){
    W "RUNTIME UI STATE" Cyan
    W "action_id=$ActionId" Gray
    foreach($p in $known){if(Test-Path -LiteralPath $p){$j=ReadJson $p;$st=if($j.status){"$($j.status)"}elseif($j.gate_status){"gate=$($j.gate_status) execution=$($j.execution_status)"}else{'OK'};W ("OK "+($p.Replace($root,'').TrimStart('\'))+" :: "+$st) Green}else{W ("MISS "+($p.Replace($root,'').TrimStart('\'))) Yellow}}
    W "Enter/refrescar/f5 = redibujar pantalla | ? = ayuda | comandos = menu actual" DarkGray
    W "ENGREMIAT_PACKAGE_END package=$package status=PASS mode=READONLY_STATE" Cyan
    exit 0
  }
  W "WARN unknown_command=$Command fallback=estado" Yellow
  W "ENGREMIAT_PACKAGE_END package=$package status=WARN reason=UNKNOWN_COMMAND" Yellow
}catch{W "ENGREMIAT_PACKAGE_END package=$package status=FAIL error=$($_.Exception.Message)" Red;throw}
