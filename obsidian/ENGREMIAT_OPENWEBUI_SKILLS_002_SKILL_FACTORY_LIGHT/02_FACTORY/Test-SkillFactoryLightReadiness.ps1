$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Cyan"){Write-Host $m -ForegroundColor $c}
$root=(Get-Location).Path
$base=Join-Path $root "obsidian\ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT"
$prev=Join-Path $root "obsidian\ENGREMIAT_OPENWEBUI_SKILLS_001\03_SKILLS\OFFICIAL_SKILL_ESTADO_ENGREMIAT.md"
$required=@("00_HOME\HOME.md","01_ESTADO\ESTADO_ACTUAL.md","01_ESTADO\NEXT.md","02_FACTORY\FACTORY_CONTRACT.md","02_FACTORY\PASS_WARN_FAIL_CRITERIA.md","02_FACTORY\CANDIDATE_SCHEMA.md","02_FACTORY\READONLY_VALIDATOR_CONTRACT.md","03_CANDIDATES\CANDIDATE_REGISTRY.md","03_CANDIDATES\CANDIDATE_TEMPLATE.md","05_OFFICIAL\OFFICIAL_REGISTRY.md","90_INDEXES\MASTER_INDEX.md")
$missing=@()
foreach($r in $required){if(!(Test-Path -LiteralPath (Join-Path $base $r))){$missing+=$r}}
$prevOk=Test-Path -LiteralPath $prev
$decision="PASS"
if($missing.Count -gt 0 -or -not $prevOk){$decision="FAIL"}
W "READONLY_VALIDATOR package=ENGREMIAT_OPENWEBUI_SKILLS_002_B02 validator=True write_files=False git=False network=False" Cyan
W "CHECK base=$base" Cyan
W "CHECK required=$($required.Count) missing=$($missing.Count) previous_official_skill=$prevOk" $(if($missing.Count -eq 0 -and $prevOk){"Green"}else{"Red"})
if($missing.Count -gt 0){W "MISSING $($missing -join ',')" Red}
W "DECISION $decision" $(if($decision -eq "PASS"){"Green"}else{"Red"})
if($decision -ne "PASS"){exit 1}
