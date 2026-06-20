$ErrorActionPreference="Stop"
$root=(Get-Location).Path
$gv=Join-Path $root "obsidian\ENGREMIAT_GLOBAL_VAULT"
$files=@("PROJECT_CONTRACT.md","CARD_CONTRACT.md","VAULT_CONTRACT.md","SKILL_CONTRACT.md","BUNDLE_CONTRACT.md","ADAPTER_CONTRACT.md","NODE_CONTRACT.md","GATE_CONTRACT.md","EVIDENCE_CONTRACT.md")
$missing=@()
foreach($f in $files){if(-not(Test-Path (Join-Path $gv "04_CONTRACTS\$f"))){$missing+=$f}}
if($missing.Count -eq 0){Write-Host "VALIDATE_CONTRACTS PASS missing=0"}else{Write-Host ("VALIDATE_CONTRACTS WARN missing="+($missing -join ","))}
