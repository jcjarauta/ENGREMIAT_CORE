Write-Host "[b/q] salir/volver  |  m = asistente tarjetas humanas  |  ? = ayuda  |  Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$ScriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path
$Root=(Resolve-Path (Join-Path $ScriptDir "..\..")).Path
Set-Location -LiteralPath $Root
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function D($p){if(!(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
function W($p,[string[]]$a,$enc="UTF8"){$d=Split-Path $p -Parent;D $d;$a|Set-Content -LiteralPath $p -Encoding $enc}
function J($p,$o){$d=Split-Path $p -Parent;D $d;$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$desktop=[Environment]::GetFolderPath("Desktop")
$project=Get-ChildItem -LiteralPath $desktop -Directory -Filter "ENGREMIAT_PROJECT_*" -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 1
if(!$project){throw "no_engremiat_project_found_on_desktop"}
$projectHome=$project.FullName
$projectId=Split-Path $projectHome -Leaf
$masterVault=Join-Path $projectHome "BOVEDA_MAESTRA"
$moduleVault=Join-Path $projectHome "MODULOS\MODULE_inicio\BOVEDA_MODULO"
$systemDir=Join-Path $projectHome "_system"
$reviewDir=Join-Path $systemDir "review"
$globalReports=Join-Path $Root "reports\project-review-flow"
$globalDash=Join-Path $Root "dashboard\project-review-flow"
foreach($p in @($reviewDir,$globalReports,$globalDash)){D $p}
$checks=@(
  [ordered]@{id="project_home_exists";ok=(Test-Path -LiteralPath $projectHome);path=$projectHome},
  [ordered]@{id="master_vault_exists";ok=(Test-Path -LiteralPath $masterVault);path=$masterVault},
  [ordered]@{id="module_vault_exists";ok=(Test-Path -LiteralPath $moduleVault);path=$moduleVault},
  [ordered]@{id="master_home";ok=(Test-Path -LiteralPath (Join-Path $masterVault "HOME.md"));path=(Join-Path $masterVault "HOME.md")},
  [ordered]@{id="master_hub";ok=(Test-Path -LiteralPath (Join-Path $masterVault "00_HOME\MASTER_HUB.md"));path=(Join-Path $masterVault "00_HOME\MASTER_HUB.md")},
  [ordered]@{id="master_modules_index";ok=(Test-Path -LiteralPath (Join-Path $masterVault "03_MODULOS\MODULES_INDEX.md"));path=(Join-Path $masterVault "03_MODULOS\MODULES_INDEX.md")},
  [ordered]@{id="module_home";ok=(Test-Path -LiteralPath (Join-Path $moduleVault "HOME.md"));path=(Join-Path $moduleVault "HOME.md")},
  [ordered]@{id="module_control_operativo";ok=(Test-Path -LiteralPath (Join-Path $moduleVault "00_CONTROL\OPERATIVE_CONTROL\CONTROL_OPERATIVO.md"));path=(Join-Path $moduleVault "00_CONTROL\OPERATIVE_CONTROL\CONTROL_OPERATIVO.md")},
  [ordered]@{id="module_gates";ok=(Test-Path -LiteralPath (Join-Path $moduleVault "00_CONTROL\GATES\GATE_INDEX.md"));path=(Join-Path $moduleVault "00_CONTROL\GATES\GATE_INDEX.md")},
  [ordered]@{id="module_work_surface";ok=(Test-Path -LiteralPath (Join-Path $moduleVault "11_SUPERFICIES_TRABAJO\WORK_SURFACE_INDEX.md"));path=(Join-Path $moduleVault "11_SUPERFICIES_TRABAJO\WORK_SURFACE_INDEX.md")}
)
$failed=@($checks|Where-Object{!$_.ok})
$readiness=if(@($failed).Count -eq 0){100}else{[math]::Max(0,100-(@($failed).Count*10))}
$recommendation=if($readiness -eq 100){"APPROVE"}elseif($readiness -ge 70){"ADJUST"}else{"BLOCK"}
$gatePath=Join-Path $masterVault "04_GATES\GATE_REVIEW_PROJECT_START.md"
W $gatePath @(
  "# Gate humano - revisar proyecto",
  "",
  "## Proyecto",
  $projectId,
  "",
  "## Estado tecnico",
  "- Readiness: $readiness",
  "- Recomendacion: $recommendation",
  "",
  "## Comprobaciones",
  ($checks|ForEach-Object{"- "+$_.id+": "+$(if($_.ok){"OK"}else{"FAIL"})+" -> "+$_.path}),
  "",
  "## Decision humana pendiente",
  "Opciones:",
  "- APPROVE: aceptar estructura y pasar a definir contrato operativo del modulo.",
  "- ADJUST: ajustar vision, enlaces o modulo antes de avanzar.",
  "- BLOCK: detener porque la estructura base no sirve.",
  "",
  "## Seguridad",
  "- worker_real=False",
  "- git=False",
  "- network=False"
)
$reviewMd=Join-Path $reviewDir "PROJECT_REVIEW.md"
W $reviewMd @(
  "# Revision de proyecto ENGREMIAT",
  "",
  "## Proyecto",
  $projectHome,
  "",
  "## Boveda maestra",
  $masterVault,
  "",
  "## Boveda modulo inicio",
  $moduleVault,
  "",
  "## Readiness",
  "$readiness",
  "",
  "## Recomendacion",
  "$recommendation",
  "",
  "## Siguiente paso",
  $(if($recommendation -eq "APPROVE"){"E03_DEFINE_MODULE_OPERATIVE_CONTRACT"}elseif($recommendation -eq "ADJUST"){"E02B_ADJUST_PROJECT_STRUCTURE"}else{"E02C_BLOCK_AND_REPORT"})
)
$report=[ordered]@{
  package_id="ENGREMIAT_PROJECT_REVIEW_FLOW_001"
  stage="E02_COMMAND_REVISAR_PROYECTO_RUNTIME"
  status="PASS"
  readiness=$readiness
  recommendation=$recommendation
  project_home=$projectHome
  master_vault=$masterVault
  module_vault=$moduleVault
  gate=$gatePath
  review=$reviewMd
  checks=$checks
  failed_checks=$failed
  safety=[ordered]@{local_only=$true;read_review_only=$true;writes_gate_and_report=$true;worker_real=$false;git=$false;network=$false}
  next=if($recommendation -eq "APPROVE"){"E03_DEFINE_MODULE_OPERATIVE_CONTRACT"}elseif($recommendation -eq "ADJUST"){"E02B_ADJUST_PROJECT_STRUCTURE"}else{"E02C_BLOCK_AND_REPORT"}
}
$reportPath=Join-Path $globalReports ("e02-project-review-"+$projectId+".json")
J $reportPath $report
J (Join-Path $reviewDir "project-review-report.json") $report
$html=Join-Path $globalDash ("e02-project-review-"+$projectId+".html")
W $html @(
  "<!doctype html><html lang='es'><head><meta charset='utf-8'><title>ENGREMIAT Review</title></head><body>",
  "<h1>Revision de proyecto</h1>",
  "<p>Proyecto: $projectHome</p>",
  "<p>Readiness: $readiness</p>",
  "<p>Recomendacion: $recommendation</p>",
  "<p>Gate: $gatePath</p>",
  "<p>Next: $($report.next)</p>",
  "</body></html>"
)
Start-Process $html
L "OK project_review=True readiness=$readiness recommendation=$recommendation project=$projectHome gate=$gatePath report=$reportPath next=$($report.next)" Green

