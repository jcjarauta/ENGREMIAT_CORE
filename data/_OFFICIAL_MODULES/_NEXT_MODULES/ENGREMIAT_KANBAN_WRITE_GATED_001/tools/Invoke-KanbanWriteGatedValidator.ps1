$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_KANBAN_WRITE_GATED_001'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_WRITE_GATED_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-write-gated-001'
$required=@("$root\module.json","$root\contracts\kanban-write-gated-contract.json","$root\contracts\kanban-write-gate-contract.json","$report\kanban-write-plan.json","$report\kanban-write-dry-run-report.json","$root\tools\Invoke-KanbanLocalWriteGated.ps1","$report\kanban-written-board.json","$report\kanban-write-evidence.json")
$missing=@($required|?{!(Test-Path $_)})
$parse=@()
Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$evidence=if(Test-Path "$report\kanban-write-evidence.json"){Get-Content -Raw "$report\kanban-write-evidence.json"|ConvertFrom-Json}else{$null}
$board=if(Test-Path "$report\kanban-written-board.json"){Get-Content -Raw "$report\kanban-written-board.json"|ConvertFrom-Json}else{$null}
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $evidence.status -eq 'PASS' -and $board.external_write_executed -eq $false){'PASS'}else{'ERR'}
$out=[ordered]@{package_id=$package;stage='E07';status=$status;missing=$missing;parse_errors=$parse;local_artifact_written=$evidence.local_artifact_written;cards_written=$evidence.cards_written;external_write_executed=$false;validation='LOCAL_WRITE_ONLY_CONFIRMED';readiness=88;next='E08_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\kanban-write-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
$out|ConvertTo-Json -Depth 100
