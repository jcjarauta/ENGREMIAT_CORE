$ErrorActionPreference='Stop'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_RESOURCE_COMPOSER_CORE_001'
$report='C:\ENGREMIAT_CORE\reports\resource-composer-core-001'
$required=@("$root\schemas\composer-build-package.schema.json","$root\rules\build-package-rules.json","$root\tools\Invoke-ComposerBuildPackageBuilder.ps1","$root\samples\sample-composer-input.json","$root\samples\sample-resource-selection.json","$root\samples\sample-composition-blueprint.json","$root\tools\Invoke-ComposerDryRunPipeline.ps1","$report\build-package-output.json","$report\composer-dry-run-report.json")
$missing=@($required|?{!(Test-Path $_)})
$parse_errors=@()
Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse_errors+=$_.Name}}
$status=if($missing.Count -eq 0 -and $parse_errors.Count -eq 0){'PASS'}else{'ERR'}
$out=[ordered]@{package_id='ENGREMIAT_RESOURCE_COMPOSER_CORE_001';status=$status;missing=$missing;parse_errors=$parse_errors;ai=$false;ollama=$false;network=$false;git=$false;real_execution=$false;readiness=86;next='E07_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 20|Set-Content -Encoding UTF8 "$report\composer-core-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 20)}
$out|ConvertTo-Json -Depth 20
