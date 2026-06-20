$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_INTERNAL_PRIORITY_ENGINE_001'
$report='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001'
$sigPath="$report\priority-signals-report.json"
if(!(Test-Path $sigPath)){throw "MISSING_SIGNALS $sigPath"}
$sig=Get-Content -Raw $sigPath|ConvertFrom-Json
$rank=@()
foreach($s in @($sig.signals)){
 $col=[string]$s.column;$typ=[string]$s.type
 $bonus=0;if($col -eq 'GATED'){$bonus+=10};if($col -eq 'VALIDATION'){$bonus+=5}
 $score=[math]::Round((([double]$s.impact_signal*0.25)+([double]$s.risk_signal*0.15)+([double]$s.dependency_signal*0.15)+([double]$s.readiness_signal*0.15)+([double]$s.benefit_signal*0.15)+$bonus),2)
 $reasons=@();if($col -eq 'READY'){$reasons+='READY: siguiente accion disponible'};if($col -eq 'GATED'){$reasons+='GATED: requiere decision humana'};if($col -eq 'BLOCKED'){$reasons+='BLOCKED: bloqueo a resolver'};if($col -eq 'VALIDATION'){$reasons+='VALIDATION: mejora fiabilidad'};if($typ -eq 'NEXT_OBJECTIVE'){$reasons+='NEXT_OBJECTIVE: conecta continuidad'};if($reasons.Count -eq 0){$reasons+='Prioridad calculada por senales base'}
 $rank+=[ordered]@{card_id=$s.card_id;title=$s.title;type=$typ;column=$col;priority_score=$score;reasons=$reasons;source_path=$s.source_path}
}
$ranked=@($rank|Sort-Object -Property priority_score -Descending)
[ordered]@{package_id=$package;status='PASS';readonly=$true;cards_ranked=$ranked.Count;ranking=$ranked}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\priority-ranking-output.json"
[ordered]@{package_id=$package;status='PASS';top_count=(@($ranked|Select-Object -First 10)).Count;recommendations=@($ranked|Select-Object -First 10)}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\top-priority-recommendations.json"
