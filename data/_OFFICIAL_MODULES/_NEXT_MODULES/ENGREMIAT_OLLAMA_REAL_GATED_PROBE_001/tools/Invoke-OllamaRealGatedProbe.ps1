param([string]$Authorization='AUTORIZO_OLLAMA_REAL_INFERENCE_GATED')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001'
$report='C:\ENGREMIAT_CORE\reports\ollama-real-gated-probe-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$requiredAuth='AUTORIZO_OLLAMA_REAL_INFERENCE_GATED'
$payloadPath="$root\samples\ollama-real-payload.json"
$resultPath="$report\real-inference-result.json"
$normalizedPath="$report\normalized-real-response.json"
function WriteJson($p,$o){$o|ConvertTo-Json -Depth 80|Set-Content -Encoding UTF8 $p}
if($Authorization -ne $requiredAuth){
  $out=[ordered]@{package_id=$package;status='BLOCKED';reason='AUTHORIZATION_LITERAL_REQUIRED';authorization_required=$requiredAuth;real_inference_executed=$false;endpoint_generate_called=$false}
  WriteJson $resultPath $out
  WriteJson $normalizedPath ([ordered]@{output_type='MODEL_RESPONSE_NORMALIZED';status='BLOCKED';real_inference_executed=$false;source=$resultPath})
  $out|ConvertTo-Json -Depth 80
  return
}
if(!(Test-Path $payloadPath)){throw "MISSING_PAYLOAD $payloadPath"}
$payload=Get-Content -Raw $payloadPath|ConvertFrom-Json
$base='http://127.0.0.1:11434'
$uri="$base/api/generate"
$started=Get-Date
$status='ERR'
$statusCode=$null
$responseText=$null
$errorText=$null
$durationMs=0
try{
  $body=$payload|ConvertTo-Json -Depth 30
  $r=Invoke-WebRequest -Uri $uri -Method Post -Body $body -ContentType 'application/json' -TimeoutSec 90 -UseBasicParsing
  $statusCode=$r.StatusCode
  $responseText=$r.Content
  $status=if($statusCode -ge 200 -and $statusCode -lt 300){'PASS'}else{'WARN'}
}catch{
  $errorText=$_.Exception.Message
  $status='NO_GO'
}
$ended=Get-Date
$durationMs=[int](New-TimeSpan -Start $started -End $ended).TotalMilliseconds
$rawObj=$null
$normalizedContent=''
try{
  if($responseText){$rawObj=$responseText|ConvertFrom-Json;$normalizedContent=[string]$rawObj.response}
}catch{
  $normalizedContent=[string]$responseText
}
$result=[ordered]@{package_id=$package;stage='E04';status=$status;authorization_used=$requiredAuth;endpoint=$uri;model=$payload.model;status_code=$statusCode;duration_ms=$durationMs;real_inference_executed=($status -eq 'PASS');endpoint_generate_called=$true;calls_attempted=1;stream=$payload.stream;num_predict=$payload.options.num_predict;raw_response=$rawObj;raw_text=$responseText;error=$errorText;timestamp_utc=(Get-Date).ToUniversalTime().ToString('o')}
$norm=[ordered]@{output_type='MODEL_RESPONSE_NORMALIZED';package_id=$package;request_id='OLLAMA-REAL-GATED-PROBE-001';status=$status;mode='REAL_GATED';normalized_output=[ordered]@{content=$normalizedContent;expected_contains='ENGREMIAT_OLLAMA_REAL_PROBE_OK';contains_expected=($normalizedContent -like '*ENGREMIAT_OLLAMA_REAL_PROBE_OK*')};evidence=[ordered]@{real_inference_executed=($status -eq 'PASS');endpoint_generate_called=$true;calls_attempted=1;duration_ms=$durationMs;model=$payload.model;authorization=$requiredAuth};adapter_metadata=[ordered]@{adapter='ENGREMIAT_MODEL_ADAPTER_OLLAMA_001';base_url=$base;status_code=$statusCode}}
WriteJson $resultPath $result
WriteJson $normalizedPath $norm
$result|ConvertTo-Json -Depth 80
