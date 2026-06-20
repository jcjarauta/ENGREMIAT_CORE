$ErrorActionPreference="Stop"
$root=(Get-Location).Path
$required=@("obsidian\ENGREMIAT_GLOBAL_VAULT\02_DIRECTORIOS\REGISTRY_BOVEDAS.md","obsidian\ENGREMIAT_GLOBAL_VAULT\02_DIRECTORIOS\REGISTRY_PROYECTOS.md","obsidian\ENGREMIAT_GLOBAL_VAULT\03_APENDICES_BOVEDAS\APENDICE_OPENWEBUI_SKILLS.md","obsidian\ENGREMIAT_GLOBAL_VAULT\03_APENDICES_BOVEDAS\APENDICE_KANBAN_BACKLOG.md","obsidian\vaults\OPENWEBUI_SKILLS\02_PROJECT\PROJECT.md","obsidian\vaults\KANBAN_BACKLOG\02_PROJECT\PROJECT.md")
$missing=@()
foreach($r in $required){if(-not(Test-Path (Join-Path $root $r))){$missing+=$r}}
if($missing.Count -eq 0){Write-Host "VALIDATE_VAULTS_REGISTRIES PASS missing=0"}else{Write-Host ("VALIDATE_VAULTS_REGISTRIES WARN missing="+($missing -join ","))}
