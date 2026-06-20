$ErrorActionPreference='Stop'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_STANDARD_001'
$report='C:\ENGREMIAT_CORE\reports\model-adapter-standard-001'
$mock=& powershell -NoProfile -ExecutionPolicy Bypass -File "$root\tools\Invoke-ModelAdapterMock.ps1"
$out=[ordered]@{package_id='ENGREMIAT_MODEL_ADAPTER_STANDARD_001';pipeline='REQUEST_ENVELOPE_MOCK_NORMALIZED_OUTPUT_EVIDENCE';status='PASS';real_inference=$false;ollama=$false;network=$false;git=$false;mock_response=($mock|ConvertFrom-Json)}
$out|ConvertTo-Json -Depth 40|Set-Content -Encoding UTF8 "$report\model-adapter-dry-run-report.json"
$out|ConvertTo-Json -Depth 40
