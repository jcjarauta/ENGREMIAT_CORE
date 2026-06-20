$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001'
$report='C:\ENGREMIAT_CORE\reports\ollama-real-gated-probe-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$base='http://127.0.0.1:11434'
$model='qwen3:14b'
$available=$false;$modelFound=$false;$statusCode=$null;$err=$null;$models=@()
try{
  $r=Invoke-WebRequest -Uri "$base/api/tags" -UseBasicParsing -TimeoutSec 5
  $statusCode=$r.StatusCode
  $available=($statusCode -ge 200 -and $statusCode -lt 300)
  $json=$r.Content|ConvertFrom-Json
  $models=@($json.models|%{$_.name})
  $modelFound=($models -contains $model)
}catch{$err=$_.Exception.Message}
$out=[ordered]@{package_id='ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001';tool='Test-OllamaProbePreflight';status=$(if($available -and $modelFound){'PASS'}elseif($available){'WARN_MODEL_NOT_FOUND'}else{'WARN_OLLAMA_NOT_AVAILABLE'});readonly=$true;base_url=$base;endpoint='/api/tags';status_code=$statusCode;available=$available;allowed_model=$model;model_found=$modelFound;models=$models;error=$err;generates_text=$false;real_inference=$false}
$out|ConvertTo-Json -Depth 50|Set-Content -Encoding UTF8 "$report\model-availability-report.json"
$out|ConvertTo-Json -Depth 50
