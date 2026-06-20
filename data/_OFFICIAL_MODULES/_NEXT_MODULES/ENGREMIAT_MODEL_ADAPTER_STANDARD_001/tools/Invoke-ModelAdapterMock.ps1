$ErrorActionPreference='Stop'
$report='C:\ENGREMIAT_CORE\reports\model-adapter-standard-001'
$out=[ordered]@{response_id='MODEL-RESP-MOCK-001';request_id='MODEL-REQ-MOCK-001';mode='MOCK';status='MOCK_PASS';normalized_output=[ordered]@{output_type='MODEL_RESPONSE_NORMALIZED';summary='Mock normalized response';next='VALIDATE_STANDARD'};evidence=[ordered]@{real_inference_executed=$false;model_name='NONE';network=$false;ollama=$false}}
$out|ConvertTo-Json -Depth 30|Set-Content -Encoding UTF8 "$report\mock-model-response-output.json"
$out|ConvertTo-Json -Depth 30
