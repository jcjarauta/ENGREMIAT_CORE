$ErrorActionPreference='Stop'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001'
$report='C:\ENGREMIAT_CORE\reports\ollama-adapter-001'
$required=@(
 "$root\contracts\ollama-real-inference-gate.json",
 "$root\samples\real-inference-request-sample.json",
 "$root\tools\Invoke-OllamaRealInferenceGated.ps1",
 "$root\tools\Invoke-OllamaAdapterDryRunPipeline.ps1",
 "$report\ollama-adapter-mock-report.json",
 "$report\ollama-local-availability-report.json",
 "$report\ollama-adapter-dry-run-report.json"
)
$missing=@($required|?{!(Test-Path $_)})
$parse=@()
Get-ChildItem "$root\tools\*.ps1"|%{
 $e=$null
 [System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null
 if($e.Count -gt 0){$parse+=$_.Name}
}
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0){'PASS'}else{'ERR'}
$out=[ordered]@{
 package_id='ENGREMIAT_MODEL_ADAPTER_OLLAMA_001'
 status=$status
 missing=$missing
 parse_errors=$parse
 real_inference_executed=$false
 endpoint_called=$false
 readiness=88
 next='E08_MANUAL_AND_CLOSE'
}
$out|ConvertTo-Json -Depth 50|Set-Content -Encoding UTF8 "$report\ollama-adapter-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 50)}
$out|ConvertTo-Json -Depth 50
