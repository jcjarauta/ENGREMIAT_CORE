$ErrorActionPreference="Stop"
$root=(Get-Location).Path
$required=@("obsidian\ENGREMIAT_GLOBAL_VAULT\07_BUNDLES\GLOBAL_IMPORT_BUNDLE.md","obsidian\vaults\OPENWEBUI_SKILLS\05_BUNDLES\IMPORT_BUNDLE.md","obsidian\vaults\KANBAN_BACKLOG\05_BUNDLES\IMPORT_BUNDLE.md","obsidian\vaults\KANBAN_BACKLOG\03_CARDS\CARDS_INDEX.md")
$missing=@()
foreach($r in $required){if(-not(Test-Path (Join-Path $root $r))){$missing+=$r}}
if($missing.Count -eq 0){Write-Host "VALIDATE_BUNDLES_CARDS PASS missing=0"}else{Write-Host ("VALIDATE_BUNDLES_CARDS WARN missing="+($missing -join ","))}
