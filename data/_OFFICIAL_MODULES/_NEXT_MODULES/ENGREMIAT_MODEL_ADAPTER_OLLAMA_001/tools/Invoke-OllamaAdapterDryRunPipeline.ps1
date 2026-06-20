$ErrorActionPreference='Stop'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001'
$report='C:\ENGREMIAT_CORE\reports\ollama-adapter-001'
$mock=Get-Content -Raw "$report\ollama-adapter-mock-report.json"|ConvertFrom-Json
$avail=Get-Content -Raw "$report\ollama-local-availability-report.json"|ConvertFrom-Json
$gate=& powershell -NoProfile -ExecutionPolicy Bypass -File "$root\tools\Invoke-OllamaRealInferenceGated.ps1"
$gateObj=$gate|ConvertFrom-Json
$out=[ordered]@{
 package_id='ENGREMIAT_MODEL_ADAPTER_OLLAMA_001'
 pipeline='MOCK_AVAILABILITY_GATE_BLOCKED'
 status='PASS'
 mock_status=$mock.status
 availability_status=$avail.status
 gate_status=$gateObj.status
 real_inference_executed=$false
 endpoint_called=$false
 network='LOCALHOST_READONLY_ONLY'
}
$out|ConvertTo-Json -Depth 50|Set-Content -Encoding UTF8 "$report\ollama-adapter-dry-run-report.json"
$out|ConvertTo-Json -Depth 50
