param([string]$Authorization='')
$ErrorActionPreference='Stop'
if($Authorization -ne 'AUTORIZO_OLLAMA_REAL_INFERENCE_GATED'){
 [ordered]@{
  package_id='ENGREMIAT_MODEL_ADAPTER_OLLAMA_001'
  status='BLOCKED'
  authorization_required=$true
  authorization_status='PENDING_EXPLICIT_HUMAN_AUTHORIZATION'
  real_inference_executed=$false
  endpoint_called=$false
 } | ConvertTo-Json -Depth 20
 return
}
throw 'REAL_INFERENCE_DISABLED_IN_THIS_STAGE'
