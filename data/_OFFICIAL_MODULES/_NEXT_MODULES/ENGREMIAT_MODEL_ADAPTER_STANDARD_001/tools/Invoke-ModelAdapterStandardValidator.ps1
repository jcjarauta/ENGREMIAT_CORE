$ErrorActionPreference='Stop'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_STANDARD_001'
$report='C:\ENGREMIAT_CORE\reports\model-adapter-standard-001'
$required=@("$root\module.json","$root\contracts\model-adapter-standard-contract.json","$root\contracts\model-adapter-safety-policy.json","$root\schemas\model-request.schema.json","$root\schemas\model-response.schema.json","$root\schemas\model-evidence.schema.json","$root\contracts\model-capability-gates.json","$root\rules\model-execution-modes.json","$root\rules\model-adapter-rules.json","$root\tools\Invoke-ModelAdapterMock.ps1","$root\tools\Invoke-ModelAdapterDryRunPipeline.ps1","$report\mock-model-response-output.json","$report\model-adapter-dry-run-report.json")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0){'PASS'}else{'ERR'}
$out=[ordered]@{package_id='ENGREMIAT_MODEL_ADAPTER_STANDARD_001';status=$status;missing=$missing;parse_errors=$parse;real_inference=$false;ollama=$false;network=$false;git=$false;readiness=86;next='E07_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 40|Set-Content -Encoding UTF8 "$report\model-adapter-standard-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 40)}
$out|ConvertTo-Json -Depth 40
