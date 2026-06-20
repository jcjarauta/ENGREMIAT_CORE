param([string]$Authorization='')
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_KANBAN_WRITE_GATED_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-write-gated-001'
$requiredAuth='AUTORIZO_KANBAN_LOCAL_WRITE_GATED'
$planPath="$report\kanban-write-plan.json"
$outPath="$report\kanban-written-board.json"
$evidencePath="$report\kanban-write-evidence.json"
function WriteJson($p,$o){$o|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 $p}
if($Authorization -ne $requiredAuth){
 $blocked=[ordered]@{package_id=$package;stage='E06';status='BLOCKED';authorization_required=$requiredAuth;authorization_status='PENDING_EXPLICIT_HUMAN_AUTHORIZATION';local_artifact_written=$false;external_write_executed=$false}
 WriteJson $evidencePath $blocked
 $blocked|ConvertTo-Json -Depth 100
 return
}
if(!(Test-Path $planPath)){throw "MISSING_WRITE_PLAN $planPath"}
$plan=Get-Content -Raw $planPath|ConvertFrom-Json
$cards=@()
foreach($a in @($plan.actions)){
 $cards+=[ordered]@{card_id=$a.card_id;title=$a.title;type=$a.type;column=$a.column;source_path=$a.source_path;written_to='LOCAL_ARTIFACT_ONLY';external_write=$false}
}
$board=[ordered]@{package_id=$package;status='PASS';target='LOCAL_ARTIFACT_ONLY';cards_count=$cards.Count;cards=$cards;written_at_utc=(Get-Date).ToUniversalTime().ToString('o');external_write_executed=$false}
WriteJson $outPath $board
$evidence=[ordered]@{package_id=$package;stage='E06';status='PASS';authorization_used=$requiredAuth;local_artifact_written=$true;target=$outPath;cards_written=$cards.Count;external_write_executed=$false;git=$false}
WriteJson $evidencePath $evidence
$evidence|ConvertTo-Json -Depth 100
