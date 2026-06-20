$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_OPERATION_LOOP_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-operation-loop-001'
$required=@("$report\operation-snapshot-report.json","$report\operation-proposal.json","$report\operation-human-decision-request.json","$report\operation-human-decision-receipt.json","$report\operation-loop-result.json","$report\operation-loop-evidence.json")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$result=Get-Content -Raw "$report\operation-loop-result.json"|ConvertFrom-Json
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $result.status -eq 'SAFE_BLOCKED'){'PASS'}else{'ERR'}
$out=[ordered]@{package_id='ENGREMIAT_KANBAN_OPERATION_LOOP_001';stage='E07';status=$status;missing=$missing;parse_errors=$parse;safe_blocked=($result.status -eq 'SAFE_BLOCKED');executed=$false;api_called=$false;git=$false;readiness=88;next='E08_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\operation-loop-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
