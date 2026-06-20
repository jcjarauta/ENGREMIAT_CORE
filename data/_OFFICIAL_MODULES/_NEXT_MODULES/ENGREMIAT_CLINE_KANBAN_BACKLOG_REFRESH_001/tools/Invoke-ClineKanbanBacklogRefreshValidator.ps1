$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_CLINE_KANBAN_BACKLOG_REFRESH_001'
$report='C:\ENGREMIAT_CORE\reports\cline-kanban-backlog-refresh-001'
$required=@("$root\module.json","$root\contracts\cline-kanban-backlog-refresh-contract.json","$root\contracts\backlog-source-binding.json","$root\schemas\cline-kanban-card.schema.json","$root\rules\backlog-refresh-rules.json","$root\contracts\backlog-refresh-safety-policy.json","$root\tools\Invoke-ClineKanbanBacklogRefresh.ps1","$report\backlog-refresh-output.json","$report\cline-kanban-import.tsv","$report\cline-kanban-prompt.md","$report\dashboard\index.html")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$refresh=Get-Content -Raw "$report\backlog-refresh-output.json"|ConvertFrom-Json
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $refresh.cards_count -gt 0 -and $refresh.clien_write -eq $false){'PASS'}else{'ERR'}
$out=[ordered]@{package_id='ENGREMIAT_CLINE_KANBAN_BACKLOG_REFRESH_001';stage='VALIDATION';status=$status;missing=$missing;parse_errors=$parse;cards=$refresh.cards_count;manual_export_only=$true;clien_write=$false;browser=$false;api_called=$false;git=$false;readiness=90;next='MANUAL_OPEN_CLINE_KANBAN_AND_IMPORT'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\backlog-refresh-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
