$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function Test-File([string]$p){return (![string]::IsNullOrWhiteSpace($p) -and (Test-Path -LiteralPath $p))}
function Read-JsonSafe([string]$p){try{if(Test-File $p){return Get-Content -LiteralPath $p -Raw -Encoding UTF8|ConvertFrom-Json}}catch{};return $null}
function Has-Marker([string]$p,[string]$m){try{return (Test-File $p -and (Select-String -LiteralPath $p -Pattern $m -SimpleMatch -Quiet -ErrorAction SilentlyContinue))}catch{return $false}}
$core="C:\ENGREMIAT_CORE"
$knownRoots=@("C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2",$core)
$candidates=@()
foreach($root in $knownRoots){
  if(!(Test-Path -LiteralPath $root)){continue}
  $registry=Join-Path $root "contracts\SCREEN_REGISTRY.json"
  $engine=Join-Path $root "operator\lib\OperatorV2.ScreenEngine.ps1"
  $ui=Join-Path $root "operator\lib\OperatorV2.UI.ps1"
  $launcher=Join-Path $root "operator\ENGREMIAT_OPERADOR_V2.ps1"
  $score=0
  if(Test-File $registry){$score+=40}
  if(Test-File $engine){$score+=30}
  if(Has-Marker $engine "ENGREMIAT_V2"){$score+=20}
  if(Has-Marker $engine "SCREEN_REGISTRY.json"){$score+=20}
  if(Test-File $launcher){$score+=10}
  $reg=Read-JsonSafe $registry
  $screenCount=if($reg -and $reg.screens){@($reg.screens).Count}else{0}
  $pantallasUx=if($reg -and $reg.screens){@($reg.screens|Where-Object{[string]$_.id -eq "pantallas_ux" -or [string]$_.title -eq "Pantallas y UX"}).Count}else{0}
  $candidates+=[pscustomobject]@{root=$root;score=$score;registry=$registry;registry_exists=(Test-File $registry);engine=$engine;engine_exists=(Test-File $engine);ui=$ui;ui_exists=(Test-File $ui);launcher=$launcher;launcher_exists=(Test-File $launcher);screen_count=$screenCount;pantallas_ux_nodes=$pantallasUx;engine_has_engremiat_v2=(Has-Marker $engine "ENGREMIAT_V2");engine_reads_registry=(Has-Marker $engine "SCREEN_REGISTRY.json");engine_has_header=(Has-Marker $engine "Show-EngHeader");engine_has_prompt=(Has-Marker $engine "Read-EngCmd")}
}
$active=$candidates|Sort-Object score -Descending|Select-Object -First 1
$decision=if($active -and $active.score -ge 70){"GO_ACTIVE_CONTEXT_RESOLVED"}else{"NO_GO_ACTIVE_CONTEXT_UNCLEAR"}
$protected=@("C:\ENGREMIAT_CORE\ENGREMIAT.ps1","C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1")
$result=[ordered]@{created_at=(Get-Date).ToString("s");package_id="ENGREMIAT_CONTEXT_GUARDIAN_001";stage="E01B_CREATE_ACTIVE_CONTEXT_RESOLVER_REPAIR";decision=$decision;active_root=if($active){$active.root}else{""};active_registry=if($active){$active.registry}else{""};active_engine=if($active){$active.engine}else{""};active_launcher=if($active){$active.launcher}else{""};protected_do_not_patch=$protected;candidates=$candidates;next=if($decision -eq "GO_ACTIVE_CONTEXT_RESOLVED"){"PATCH_ONLY_ACTIVE_ROOT_REGISTRY_OR_ENGINE"}else{"ASK_HUMAN_FOR_ACTIVE_ROOT"}}
$outDir="C:\ENGREMIAT_CORE\reports\context-guardian";New-Item -ItemType Directory -Force -Path $outDir|Out-Null
$out=Join-Path $outDir ("active-context-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
$latest=Join-Path $outDir "active-context.latest.json"
$result|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $out -Encoding UTF8
$result|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $latest -Encoding UTF8
Write-Host "ENGREMIAT_CONTEXT_GUARDIAN" -ForegroundColor Cyan
Write-Host ("decision="+$result.decision) -ForegroundColor Green
Write-Host ("active_root="+$result.active_root) -ForegroundColor Green
Write-Host ("active_registry="+$result.active_registry) -ForegroundColor DarkCyan
Write-Host ("active_engine="+$result.active_engine) -ForegroundColor DarkCyan
Write-Host "protected_do_not_patch:" -ForegroundColor Yellow
foreach($p in $protected){Write-Host (" - "+$p) -ForegroundColor Yellow}
Write-Host ("report="+$out) -ForegroundColor DarkGray
Write-Host ("latest="+$latest) -ForegroundColor DarkGray
Write-Host ("next="+$result.next) -ForegroundColor Cyan
