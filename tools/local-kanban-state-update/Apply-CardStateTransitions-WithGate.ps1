param([string]$AuthorizationPhrase="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir($p){if(Test-Path -LiteralPath $p){if(-not(Test-Path -LiteralPath $p -PathType Container)){throw "PATH_EXISTS_BUT_IS_NOT_DIRECTORY_$p"}}else{New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function SetFrontMatterValue($txt,$key,$value){$pattern="(?m)^"+[regex]::Escape($key)+":\s*.*$";if($txt -match $pattern){return [regex]::Replace($txt,$pattern,($key+": "+$value))};if($txt -match "(?s)^---\s*\r?\n"){return [regex]::Replace($txt,"(?s)^---\s*\r?\n","---`n"+$key+": "+$value+"`n",1)};return "---`n"+$key+": "+$value+"`n---`n"+$txt}
$expected="AUTORIZO_APLICAR_TRANSICIONES_KANBAN_LOCAL_CON_BACKUP"
if($AuthorizationPhrase -ne $expected){throw "AUTHORIZATION_PHRASE_REQUIRED"}
$root=(Get-Location).Path
$base=Join-Path $root "data/local-kanban-state-update-001"
$proposalJson=Join-Path $base "transition-proposals/transition-proposals.dry-run.json"
$backupDir=Join-Path $base "backups"
$appliedDir=Join-Path $base "applied"
foreach($d in @($backupDir,$appliedDir)){EnsureDir $d}
$proposals=@(Get-Content -LiteralPath $proposalJson -Raw -Encoding UTF8|ConvertFrom-Json)
$ready=@($proposals|Where-Object{$_.requires_human_gate -eq $true -and $_.from_column -ne $_.to_column})
if($ready.Count -lt 1){throw "NO_READY_TRANSITIONS"}
$applied=@()
foreach($p in $ready){
  $cardPath=[string]$p.card_path
  if(-not(Test-Path -LiteralPath $cardPath -PathType Leaf)){throw "CARD_NOT_FOUND_$cardPath"}
  $backupPath=Join-Path $backupDir ((Split-Path $cardPath -Leaf)+"."+(Get-Date -Format "yyyyMMdd-HHmmss")+".bak.md")
  Copy-Item -LiteralPath $cardPath -Destination $backupPath -Force
  $txt=Get-Content -LiteralPath $cardPath -Raw -Encoding UTF8
  $txt=SetFrontMatterValue $txt "status" ([string]$p.to_column)
  $txt=SetFrontMatterValue $txt "recommended_column" ([string]$p.to_column)
  $txt=SetFrontMatterValue $txt "last_transition_id" ([string]$p.proposal_id)
  $txt=SetFrontMatterValue $txt "last_transition_at" ((Get-Date).ToString("s"))
  $txt=SetFrontMatterValue $txt "last_transition_reason" ("`""+(([string]$p.reason) -replace "`"","'")+"`"")
  Set-Content -Path $cardPath -Encoding UTF8 -Value $txt
  $applied+=[ordered]@{card_id=$p.card_id;from=$p.from_column;to=$p.to_column;card_path=$cardPath;backup=$backupPath;proposal_id=$p.proposal_id;applied_at=(Get-Date).ToString("s")}
}
$appliedPath=Join-Path $appliedDir ("applied-transitions-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
$applied|ConvertTo-Json -Depth 20|Set-Content -Path $appliedPath -Encoding UTF8
Write-Host ("OK applied_transitions="+$applied.Count+" applied_log="+$appliedPath) -ForegroundColor Green
