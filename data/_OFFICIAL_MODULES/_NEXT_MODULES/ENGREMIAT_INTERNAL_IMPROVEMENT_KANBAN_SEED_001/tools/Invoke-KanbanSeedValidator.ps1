$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001'
$report='C:\ENGREMIAT_CORE\reports\internal-improvement-kanban-seed-001'
$required=@("$report\kanban-source-signals.json","$report\kanban-seed-output.json","$report\kanban-board.tsv","$report\kanban-board.md","$report\dashboard\index.html")
$missing=@($required|?{!(Test-Path $_)})
$seed=if(Test-Path "$report\kanban-seed-output.json"){Get-Content -Raw "$report\kanban-seed-output.json"|ConvertFrom-Json}else{$null}
$cards=@($seed.cards)
$bad=@($cards|?{![string]$_.card_id -or ![string]$_.column -or ![string]$_.type -or ![string]$_.source_path})
$validCols=@('BACKLOG','READY','IN_PROGRESS','GATED','VALIDATION','DONE','BLOCKED')
$badCols=@($cards|?{$validCols -notcontains $_.column})
$parse=@()
Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$status=if($missing.Count -eq 0 -and $bad.Count -eq 0 -and $badCols.Count -eq 0 -and $parse.Count -eq 0 -and $cards.Count -gt 0){'PASS'}else{'WARN'}
$out=[ordered]@{package_id=$package;stage='E06';status=$status;missing=$missing;bad_cards=$bad.Count;bad_columns=$badCols.Count;parse_errors=$parse;cards_count=$cards.Count;readonly=$true;real_kanban_write=$false;readiness=86;next='E07_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\kanban-seed-validation-report.json"
if($missing.Count -gt 0 -or $parse.Count -gt 0){throw ($out|ConvertTo-Json -Depth 100)}
$out|ConvertTo-Json -Depth 100
