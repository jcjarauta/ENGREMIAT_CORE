$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function ReadJson($p){if(!(Test-Path -LiteralPath $p)){throw "missing_json=$p"};return Get-Content -LiteralPath $p -Raw -Encoding UTF8|ConvertFrom-Json}
$resolver="C:\ENGREMIAT_CORE\tools\context-guardian\Resolve-EngremiatActiveContext.ps1"
if(!(Test-Path -LiteralPath $resolver)){throw "missing_context_guardian_resolver"}
& powershell -NoProfile -ExecutionPolicy Bypass -File $resolver|Out-Null
$ctx=ReadJson "C:\ENGREMIAT_CORE\reports\context-guardian\active-context.latest.json"
$root=[string]$ctx.active_root;$registry=[string]$ctx.active_registry;$engine=[string]$ctx.active_engine
$errors=@();$warn=@();$ok=@()
if($ctx.decision -ne "GO_ACTIVE_CONTEXT_RESOLVED"){$errors+="context_not_resolved"}else{$ok+="context_resolved"}
if($root -ne "C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2"){$errors+="active_root_mismatch:"+$root}else{$ok+="active_root_ok"}
if(!(Test-Path -LiteralPath $registry)){$errors+="missing_registry"}else{$ok+="registry_exists"}
if(!(Test-Path -LiteralPath $engine)){$errors+="missing_engine"}else{$ok+="engine_exists"}
try{$null=[scriptblock]::Create((Get-Content -LiteralPath $engine -Raw -Encoding UTF8));$ok+="engine_parse_ok"}catch{$errors+="engine_parse_fail:"+$_.Exception.Message}
$reg=ReadJson $registry;$screens=@($reg.screens);if($screens.Count -lt 1){$errors+="no_screens"}else{$ok+="screens_count="+$screens.Count}
$ids=@{};$duplicates=@();$missingFields=@();foreach($s in $screens){$id=[string]$s.id;if([string]::IsNullOrWhiteSpace($id)){$missingFields+="missing_id"}else{if($ids.ContainsKey($id)){$duplicates+=$id}else{$ids[$id]=$true}};foreach($f in @("title","level","status","progress","purpose")){if($null -eq $s.PSObject.Properties[$f] -or [string]::IsNullOrWhiteSpace([string]$s.$f)){$missingFields+=($id+":"+$f)}}}
if($duplicates.Count -gt 0){$errors+="duplicate_ids:"+($duplicates -join ",")}else{$ok+="no_duplicate_ids"}
if($missingFields.Count -gt 0){$warn+="missing_fields:"+($missingFields|Select-Object -First 12 -join ",")}else{$ok+="required_fields_ok"}
$badChildren=@();$plannedChildren=@();$criticalRendered=@("inicio","pantallas_ux");$customRuntime=@("ux_registry","screen_states","layout_rules","pending_ux_repairs","progreso_pendientes");foreach($s in $screens){foreach($cid in @($s.children)){if(!$ids.ContainsKey([string]$cid)){if($criticalRendered -contains [string]$s.id){$badChildren+=([string]$s.id+"->"+[string]$cid)}else{$plannedChildren+=([string]$s.id+"->"+[string]$cid)}}}}
if($badChildren.Count -gt 0){$errors+="bad_rendered_children:"+($badChildren -join ",")}else{$ok+="rendered_children_links_ok"}
if($plannedChildren.Count -gt 0){$warn+="planned_or_custom_child_stubs="+$plannedChildren.Count}else{$ok+="no_planned_child_stubs"}
$actionContract="C:\ENGREMIAT_CORE\documents\operator-v2-actions\SCREEN_ACTIONS.candidate.json";$actionsReady=0;$actionsPlanned=0;$badActions=@();if(Test-Path -LiteralPath $actionContract){$ac=ReadJson $actionContract;foreach($a in @($ac.actions)){$mode=[string]$a.mode;if([string]$a.status -eq "READY"){$actionsReady++};if([string]$a.status -eq "PLANNED"){$actionsPlanned++};if(!$ids.ContainsKey([string]$a.screen_id)){$badActions+="missing_screen:"+[string]$a.screen_id};if($mode -eq "navigate_internal" -and !$ids.ContainsKey([string]$a.target)){$badActions+="missing_target:"+[string]$a.target}};if($badActions.Count -gt 0){$errors+="bad_actions:"+($badActions -join ",")}else{$ok+="actions_contract_ok"}}else{$warn+="missing_actions_candidate"}
$guard="C:\ENGREMIAT_CORE\tools\context-guardian\Start-EngremiatGuardedWrite.ps1";if(Test-Path -LiteralPath $guard){$ok+="guarded_write_exists"}else{$errors+="missing_guarded_write"}
$menuHeavy=@();foreach($s in $screens){if(@($s.children).Count -gt 5){$menuHeavy+=([string]$s.id+":"+@($s.children).Count)}};if($menuHeavy.Count -gt 0){$warn+="heavy_menus:"+($menuHeavy -join ",")}else{$ok+="menus_short_ok"}
$readiness=100;if($errors.Count -gt 0){$readiness-=60};if($warn.Count -gt 0){$readiness-=10};if($plannedChildren.Count -gt 0){$readiness-=5};if($menuHeavy.Count -gt 0){$readiness-=5};if($readiness -lt 0){$readiness=0}
$decision=if($errors.Count -eq 0){"GO_OPERATOR_V2_HEALTHY_WITH_WARNINGS"}else{"NO_GO_OPERATOR_V2_HEALTHCHECK_FAILED"}
$report=[ordered]@{created_at=(Get-Date).ToString("s");package_id="ENGREMIAT_OPERATOR_V2_HEALTHCHECK_004";stage="E01C_REPAIR_CUSTOM_SCREEN_CHILDREN_AS_WARN";decision=$decision;readiness=$readiness;active_root=$root;registry=$registry;engine=$engine;screens=$screens.Count;actions_ready=$actionsReady;actions_planned=$actionsPlanned;planned_or_custom_child_stubs_count=$plannedChildren.Count;planned_or_custom_child_stubs_sample=@($plannedChildren|Select-Object -First 20);errors=$errors;warnings=$warn;ok=$ok;next=if($errors.Count -eq 0){"E02_CLOSE_HEALTHCHECK_AND_RETURN_TO_ACTIONS_003"}else{"REPAIR_HEALTHCHECK_ERRORS_FIRST"}}
$outDir="C:\ENGREMIAT_CORE\reports\operator-v2-healthcheck";New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$reportPath=Join-Path $outDir ("operator-v2-healthcheck-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
$latest=Join-Path $outDir "operator-v2-healthcheck.latest.json"
$report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $reportPath -Encoding UTF8
$report|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $latest -Encoding UTF8
W "ENGREMIAT_OPERATOR_V2_HEALTHCHECK" Cyan
W ("decision="+$decision) $(if($errors.Count -eq 0){"Green"}else{"Red"})
W ("readiness="+$readiness) Cyan
W ("screens="+$screens.Count+" actions_ready="+$actionsReady+" actions_planned="+$actionsPlanned+" planned_or_custom_child_stubs="+$plannedChildren.Count) Gray
if($errors.Count -gt 0){foreach($e in $errors){W ("ERR "+$e) Red}}
if($warn.Count -gt 0){foreach($x in $warn){W ("WARN "+$x) Yellow}}
W ("report="+$reportPath) DarkGray
W ("next="+$report.next) Cyan
if($errors.Count -gt 0){exit 12}else{exit 0}
