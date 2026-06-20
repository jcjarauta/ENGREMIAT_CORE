$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001'
$report='C:\ENGREMIAT_CORE\reports\ollama-real-gated-probe-001'
$required=@("$root\module.json","$root\contracts\real-gated-probe-contract.json","$report\authorization-receipt.json","$root\tools\Test-OllamaProbePreflight.ps1","$root\tools\Invoke-OllamaRealGatedProbe.ps1","$report\real-inference-result.json","$report\normalized-real-response.json","$report\real-probe-evidence-report.json","$report\safety-assessment-report.json","$report\real-probe-learning-note.md")
$missing=@($required|?{!(Test-Path $_)})
$parse=@()
Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$result=if(Test-Path "$report\real-inference-result.json"){Get-Content -Raw "$report\real-inference-result.json"|ConvertFrom-Json}else{$null}
$safety=if(Test-Path "$report\safety-assessment-report.json"){Get-Content -Raw "$report\safety-assessment-report.json"|ConvertFrom-Json}else{$null}
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $result.status -eq 'PASS' -and $safety.status -eq 'PASS'){'PASS'}else{'WARN'}
$out=[ordered]@{package_id=$package;stage='E06';status=$status;missing=$missing;parse_errors=$parse;real_inference_confirmed=$result.real_inference_executed;endpoint_generate_confirmed=$result.endpoint_generate_called;safety_status=$safety.status;no_new_inference_executed=$true;readiness=86;next='E07_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 80|Set-Content -Encoding UTF8 "$report\real-gated-probe-validation-report.json"
if($missing.Count -gt 0 -or $parse.Count -gt 0){throw ($out|ConvertTo-Json -Depth 80)}
$out|ConvertTo-Json -Depth 80
