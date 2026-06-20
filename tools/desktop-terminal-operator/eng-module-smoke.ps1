$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Root=(Resolve-Path (Join-Path $PSScriptRoot "..\..")).Path
$StatePath=Join-Path $Root "data\operator-state\active-context.json"
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
if(!(Test-Path -LiteralPath $StatePath)){throw "no_active_context"}
$s=Get-Content -LiteralPath $StatePath -Raw -Encoding UTF8|ConvertFrom-Json
if([string]::IsNullOrWhiteSpace([string]$s.active_project)){throw "no_active_project"}
if([string]::IsNullOrWhiteSpace([string]$s.active_module)){throw "no_active_module"}
$vault=[string]$s.active_module_vault
$modulePath=Split-Path $vault -Parent
$checks=@()
function Check($name,$ok,$detail){$script:checks+=[pscustomobject]@{check=$name;ok=[bool]$ok;detail=$detail}}
Check "project_exists" (Test-Path -LiteralPath $s.active_project) $s.active_project
Check "module_path_exists" (Test-Path -LiteralPath $modulePath) $modulePath
Check "vault_exists" (Test-Path -LiteralPath $vault) $vault
foreach($f in @("module.json","CONTRATO.md","TAREAS.md","EVIDENCIAS.md","GATES.md")){Check ("artifact_"+$f) (Test-Path -LiteralPath (Join-Path $vault $f)) (Join-Path $vault $f)}
$moduleJson=Join-Path $vault "module.json"
if(Test-Path -LiteralPath $moduleJson){try{$mj=Get-Content -LiteralPath $moduleJson -Raw -Encoding UTF8|ConvertFrom-Json;Check "module_json_project_binding" ([string]$mj.project_path -eq [string]$s.active_project) ([string]$mj.project_path);Check "module_json_lifecycle" ([string]$mj.lifecycle -eq "ACTIVE_IN_PROJECT") ([string]$mj.lifecycle)}catch{Check "module_json_parse" $false $_.Exception.Message}}else{Check "module_json_parse" $false "missing"}
$ok=@($checks|Where-Object{!$_.ok}).Count -eq 0
$smokeDir=Join-Path $Root "reports\module-smoke"
New-Item -ItemType Directory -Force -Path $smokeDir|Out-Null
$report=Join-Path $smokeDir ("module-smoke-"+$s.active_module+"-"+(Get-Date -Format yyyyMMddHHmmss)+".json")
[pscustomobject]@{status=if($ok){"PASS"}else{"FAIL"};project=$s.active_project;module=$s.active_module;module_path=$modulePath;vault=$vault;checks=$checks;created_at=(Get-Date).ToString("s")}|ConvertTo-Json -Depth 10|Set-Content -LiteralPath $report -Encoding UTF8
$ev=Join-Path $vault "EVIDENCIAS.md"
Add-Content -LiteralPath $ev -Encoding UTF8 -Value ("`r`n## Smoke "+(Get-Date).ToString("s")+"`r`n- status: "+$(if($ok){"PASS"}else{"FAIL"})+"`r`n- report: "+$report+"`r`n")
L "SMOKE MODULO" Cyan
L ("status="+$(if($ok){"PASS"}else{"FAIL"})) $(if($ok){"Green"}else{"Red"})
$checks|ForEach-Object{L (($(if($_.ok){"OK "}else{"ERR "}))+$_.check+" -> "+$_.detail) $(if($_.ok){"Green"}else{"Red"})}
L ("report="+$report) Cyan
if(!$ok){exit 1}
