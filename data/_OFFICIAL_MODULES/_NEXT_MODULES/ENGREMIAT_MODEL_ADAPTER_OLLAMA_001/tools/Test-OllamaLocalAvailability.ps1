$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\ollama-adapter-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$baseUrl='http://127.0.0.1:11434'
$available=$false;$statusCode=$null;$errorText=$null
try{$r=Invoke-WebRequest -Uri "$baseUrl/api/tags" -Method Get -TimeoutSec 3 -UseBasicParsing;$statusCode=$r.StatusCode;$available=($r.StatusCode -ge 200 -and $r.StatusCode -lt 300)}catch{$errorText=$_.Exception.Message}
$out=[ordered]@{package_id='ENGREMIAT_MODEL_ADAPTER_OLLAMA_001';tool='Test-OllamaLocalAvailability';status=$(if($available){'PASS'}else{'WARN'});readonly=$true;base_url=$baseUrl;endpoint='/api/tags';status_code=$statusCode;available=$available;error=$errorText;generates_text=$false;real_inference=$false;network_scope='LOCALHOST_ONLY'}
$out|ConvertTo-Json -Depth 50|Set-Content -Encoding UTF8 "$report\ollama-local-availability-report.json"
$out|ConvertTo-Json -Depth 50
