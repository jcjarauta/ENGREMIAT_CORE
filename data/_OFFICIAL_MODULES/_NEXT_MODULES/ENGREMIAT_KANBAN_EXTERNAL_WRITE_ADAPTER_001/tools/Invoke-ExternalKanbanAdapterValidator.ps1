$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_KANBAN_EXTERNAL_WRITE_ADAPTER_001'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_EXTERNAL_WRITE_ADAPTER_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-external-write-adapter-001'
$required=@("$root\module.json","$root\contracts\external-write-adapter-contract.json","$root\contracts\priority-ranking-binding.json","$root\contracts\external-target-registry.json","$root\schemas\external-target.schema.json","$root\schemas\external-card-payload.schema.json","$root\contracts\external-write-gate-contract.json","$report\external-kanban-payload.json","$report\external-write-plan.json","$report\external-write-dry-run-report.json","$report\sheets-priority-kanban-export.tsv","$report\cline-kanban-manual-prompt.md","$report\manual-external-export-package.json")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0){'PASS'}else{'ERR'}
$out=[ordered]@{package_id=$package;stage='E07';status=$status;missing=$missing;parse_errors=$parse;external_api_write=$false;sheets_write=$false;cline_write=$false;manual_exports=$true;readiness=88;next='E08_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\external-kanban-adapter-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
