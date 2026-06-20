$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_KANBAN_RECURRENT_OPERATION_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-recurrent-operation-001'
$required=@("$report\recurrent-operation-snapshot.json","$report\recurrent-operation-proposal.json","$report\recurrent-operation-gate-request.json","$report\recurrent-operation-result.json","$report\recurrent-operation-evidence.json")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$result=Get-Content -Raw "$report\recurrent-operation-result.json"|ConvertFrom-Json
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $result.status -eq 'SAFE_BLOCKED'){'PASS'}else{'ERR'}
$out=[ordered]@{package_id='ENGREMIAT_KANBAN_RECURRENT_OPERATION_001';stage='VALIDATION';status=$status;missing=$missing;parse_errors=$parse;safe_blocked=($result.status -eq 'SAFE_BLOCKED');real_scheduler_created=$false;executed=$false;api_called=$false;external_write=$false;git=$false;readiness=88;next='E08_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\recurrent-operation-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
