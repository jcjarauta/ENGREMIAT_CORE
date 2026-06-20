$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001'
$report='C:\ENGREMIAT_CORE\reports\improvement-to-execution-pipeline-001'
$required=@("$root\module.json","$root\contracts\improvement-to-execution-contract.json","$root\contracts\pipeline-source-binding.json","$root\contracts\execution-safety-policy.json","$report\improvement-analysis.json","$report\technical-proposal.json","$report\development-plan.tsv","$report\execution-package-dry-run.json","$report\execution-gate-request.json")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$pkg=Get-Content -Raw "$report\execution-package-dry-run.json"|ConvertFrom-Json
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $pkg.real_execution -eq $false){'PASS'}else{'ERR'}
$out=[ordered]@{package_id='ENGREMIAT_IMPROVEMENT_TO_EXECUTION_PIPELINE_001';stage='VALIDATION';status=$status;missing=$missing;parse_errors=$parse;dry_run_package=$true;real_execution=$false;source_code_write=$false;git=$false;readiness=88;next='E08_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\improvement-pipeline-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
