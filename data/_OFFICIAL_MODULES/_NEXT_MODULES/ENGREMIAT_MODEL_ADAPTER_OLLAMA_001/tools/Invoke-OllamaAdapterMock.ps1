$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\ollama-adapter-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$out=[ordered]@{package_id='ENGREMIAT_MODEL_ADAPTER_OLLAMA_001';tool='Invoke-OllamaAdapterMock';status='PASS';mode='MOCK';local_only=$true;real_inference=$false;endpoint_called=$false;network=$false;normalized_response=[ordered]@{output_type='MODEL_RESPONSE_NORMALIZED';content='Mock Ollama adapter response. No endpoint call executed.'};evidence=[ordered]@{model_name='qwen3:14b';real_inference_executed=$false;ollama_call_executed=$false;safety='MOCK_ONLY'}}
$out|ConvertTo-Json -Depth 50|Set-Content -Encoding UTF8 "$report\ollama-adapter-mock-report.json"
$out|ConvertTo-Json -Depth 50
