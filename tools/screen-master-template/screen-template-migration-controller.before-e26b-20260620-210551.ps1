param(
  [string]$Root = "C:\ENGREMIAT_CORE",
  [string]$Mode = "audit"
)

$ErrorActionPreference = "Stop"

function W($m,$c="Gray"){ Write-Host $m -ForegroundColor $c }
function D($p){ if(!(Test-Path $p)){ New-Item -ItemType Directory -Force -Path $p | Out-Null } }
function ParseOk($p){
  if(!(Test-Path $p)){ return $false }
  $errs=$null;$tok=$null
  [System.Management.Automation.Language.Parser]::ParseFile($p,[ref]$tok,[ref]$errs)|Out-Null
  return ($errs.Count -eq 0)
}

function Classify-ScreenFile {
  param([string]$Path)

  $txt = Get-Content $Path -Raw -Encoding UTF8
  $parse = $null
  if($Path -match "\.ps1$|\.psm1$"){ $parse = ParseOk $Path }

  $hasReadHost = $txt -match "Read-Host"
  $hasScreenText = $txt -match "====|Ruta:|\[[0-9]\]|Comando no reconocido|Enter = refrescar|PROYECTOS|INICIO|TARJETAS|MODULOS"
  $hasActionName = $Path -match "add|safe|create|apply|repair|patch|worker|run|git|commit|backup"
  $hasWrites = $txt -match "Set-Content|Copy-Item|New-Item|Remove-Item|Move-Item|Out-File|Add-Content"
  $hasLoop = $txt -match "while\s*\(\$true\)|switch\s*\(|do\s*\{|for\s*\("
  $compressed = $txt -match "while\s*\(\$true\)\{.*Read-Host.*\}|switch\s*\(.*Read-Host.*\)"

  $hasEnter = $txt -match "IsNullOrWhiteSpace\([^\)]*\).*continue|Enter = refrescar"
  $hasB = $txt -match '"b"\s*\{|''b''\s*\{|\bb\s*=\s*volver|\[b/q\]'
  $hasQ = $txt -match '"q"\s*\{|''q''\s*\{|\bq\s*=\s*salir|\[b/q\]|b/q\s*='
  $hasM = $txt -match '"m"\s*\{|''m''\s*\{|\bm\s*=\s*mantenimiento|mantenimiento'
  $hasHelp = $txt -match '"\?"\s*\{|''\?''\s*\{|\? = ayuda|\[\?\]\s*Ayuda'

  $templateScore = 0
  if($parse -ne $false){ $templateScore++ }
  if($hasEnter){ $templateScore++ }
  if($hasB){ $templateScore++ }
  if($hasQ){ $templateScore++ }
  if($hasM){ $templateScore++ }
  if($hasHelp){ $templateScore++ }

  $screenScore = 0
  if($hasReadHost){ $screenScore++ }
  if($hasScreenText){ $screenScore++ }
  if($hasLoop){ $screenScore++ }

  $actionScore = 0
  if($hasActionName){ $actionScore++ }
  if($hasWrites){ $actionScore++ }
  if($hasReadHost -and -not $hasScreenText){ $actionScore++ }

  $kind = "UNCLEAR"
  if($screenScore -ge 2 -and $screenScore -ge $actionScore){ $kind = "SCREEN_CANDIDATE" }
  elseif($actionScore -ge 2){ $kind = "ACTION_SCRIPT_WITH_PROMPTS" }

  $status = "NEEDS_TEMPLATE"
  if($kind -eq "ACTION_SCRIPT_WITH_PROMPTS"){ $status = "EXCLUDE_ACTION" }
  elseif($templateScore -ge 6 -and -not $compressed){ $status = "READY" }
  elseif($templateScore -ge 4){ $status = "PARTIAL" }

  $strategy = "MANUAL_REVIEW"
  if($status -eq "READY"){ $strategy = "VALIDATE_ONLY" }
  elseif($status -eq "EXCLUDE_ACTION"){ $strategy = "ACTION_PROMPT_CONTRACT" }
  elseif($compressed){ $strategy = "EXPAND_AND_REWRITE_BOUNDARY" }
  elseif($kind -eq "SCREEN_CANDIDATE"){ $strategy = "PREPARE_ROUTER_PATCH_NO_APPLY" }

  [pscustomobject]@{
    path = $Path
    parse = $parse
    kind = $kind
    status = $status
    strategy = $strategy
    template_score = $templateScore
    screen_score = $screenScore
    action_score = $actionScore
    compressed = $compressed
    enter = $hasEnter
    b = $hasB
    q = $hasQ
    m = $hasM
    help = $hasHelp
  }
}

$base = Join-Path $Root "documents\screen-master-template"
$planned = Join-Path $base "planned"
$reports = Join-Path $Root "reports\screen-master-template"
D $planned
D $reports

$ts = Get-Date -Format "yyyyMMdd-HHmmss"
$outJson = Join-Path $planned "screen-template-migration-queue.latest.json"
$outMd = Join-Path $planned "screen-template-migration-queue.latest.md"
$outReport = Join-Path $reports ("screen-template-migration-controller-" + $Mode + "-" + $ts + ".json")

$scanRoots = @(
  (Join-Path $Root "tools"),
  (Join-Path $Root "scripts"),
  (Join-Path $Root "src")
) | Where-Object { Test-Path $_ }

$files = @()
foreach($sr in $scanRoots){
  $files += Get-ChildItem $sr -Recurse -File -Include "*.ps1","*.psm1" -ErrorAction SilentlyContinue |
    Where-Object { $_.FullName -notmatch "\\node_modules\\|\\.git\\|\\reports\\|\\backups\\" }
}

$rows = @()
foreach($f in ($files | Sort-Object FullName -Unique)){
  try { $rows += Classify-ScreenFile -Path $f.FullName } catch {}
}

$ready = @($rows | Where-Object { $_.status -eq "READY" })
$partial = @($rows | Where-Object { $_.status -eq "PARTIAL" })
$needs = @($rows | Where-Object { $_.status -eq "NEEDS_TEMPLATE" })
$actions = @($rows | Where-Object { $_.status -eq "EXCLUDE_ACTION" })
$nextTarget = $rows |
  Where-Object { $_.kind -eq "SCREEN_CANDIDATE" -and $_.status -ne "READY" } |
  Sort-Object @{Expression={ if($_.strategy -eq "PREPARE_ROUTER_PATCH_NO_APPLY"){0}elseif($_.strategy -eq "EXPAND_AND_REWRITE_BOUNDARY"){1}else{2} }}, template_score, path |
  Select-Object -First 1

$queueObj = [ordered]@{
  generated_at = (Get-Date).ToString("s")
  mode = $Mode
  total = $rows.Count
  ready = $ready.Count
  partial = $partial.Count
  needs_template = $needs.Count
  excluded_actions = $actions.Count
  next_target = $nextTarget
  rows = $rows
}

$queueObj | ConvertTo-Json -Depth 12 | Set-Content -Encoding UTF8 $outJson

$md = @(
  "# Screen Template Migration Queue",
  "",
  "## Resumen",
  "- total: " + $rows.Count,
  "- READY: " + $ready.Count,
  "- PARTIAL: " + $partial.Count,
  "- NEEDS_TEMPLATE: " + $needs.Count,
  "- EXCLUDE_ACTION: " + $actions.Count,
  "",
  "## Next target",
  $(if($nextTarget){ "- path: " + $nextTarget.path } else { "- NONE" }),
  $(if($nextTarget){ "- status: " + $nextTarget.status } else { "" }),
  $(if($nextTarget){ "- strategy: " + $nextTarget.strategy } else { "" }),
  "",
  "## Tabla",
  "| status | strategy | score | kind | compressed | path |",
  "|---|---|---:|---|---|---|"
)

foreach($r in ($rows | Sort-Object status, strategy, template_score, path)){
  $md += "| " + $r.status + " | " + $r.strategy + " | " + $r.template_score + " | " + $r.kind + " | " + $r.compressed + " | " + $r.path + " |"
}

$md | Set-Content -Encoding UTF8 $outMd
$queueObj | ConvertTo-Json -Depth 12 | Set-Content -Encoding UTF8 $outReport

W "SCREEN_TEMPLATE_MIGRATION_CONTROLLER mode=$Mode total=$($rows.Count) ready=$($ready.Count) partial=$($partial.Count) needs=$($needs.Count) actions=$($actions.Count)" Cyan
if($nextTarget){
  W "NEXT_TARGET=$($nextTarget.path)" Yellow
  W "NEXT_STRATEGY=$($nextTarget.strategy)" Yellow
} else {
  W "NEXT_TARGET=NONE" Yellow
}
W "QUEUE=$outJson" Green
W "SUMMARY=$outMd" Green
W "REPORT=$outReport" Green
