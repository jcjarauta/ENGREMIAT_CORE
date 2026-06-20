$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$core='C:\ENGREMIAT_CORE'
$report='C:\ENGREMIAT_CORE\reports\internal-improvement-kanban-seed-001'
New-Item -ItemType Directory -Force -Path $report|Out-Null
$patterns=@('*validation-report.json','*close*.json','*feedback*.json','NEXT_OBJECTIVE.md','HUMAN_MACHINE_MANUAL.md','module.json')
$roots=@("$core\reports","$core\data\_OFFICIAL_MODULES\_NEXT_MODULES")
$signals=@()
foreach($r in $roots){
 if(Test-Path $r){
  foreach($pat in $patterns){
   Get-ChildItem -Path $r -Filter $pat -Recurse -File -ErrorAction SilentlyContinue|Select-Object -First 1000|%{
    $kind=if($_.Name -like '*validation*'){'VALIDATION'}elseif($_.Name -like '*close*'){'CLOSE'}elseif($_.Name -like '*feedback*'){'FEEDBACK'}elseif($_.Name -eq 'NEXT_OBJECTIVE.md'){'NEXT_OBJECTIVE'}elseif($_.Name -eq 'HUMAN_MACHINE_MANUAL.md'){'MANUAL'}elseif($_.Name -eq 'module.json'){'MODULE'}else{'SOURCE'}
    $raw=''
    try{$raw=Get-Content -Raw $_.FullName -ErrorAction Stop}catch{}
    $status='UNKNOWN';$readiness=$null;$closed=$null;$next=$null
    if($_.Extension -eq '.json'){
     try{$j=$raw|ConvertFrom-Json;$status=[string]$j.status;$readiness=$j.readiness;$closed=$j.closed;$next=$j.next}catch{}
    }else{
     if($raw -match 'next=([A-Z0-9_\-]+)'){$next=$Matches[1]}
    }
    $signals+=[ordered]@{source_path=$_.FullName;source_name=$_.Name;source_kind=$kind;status=$status;readiness=$readiness;closed=$closed;next=$next;size=$_.Length;modified_utc=$_.LastWriteTimeUtc.ToString('o')}
   }
  }
 }
}
$out=[ordered]@{package_id='ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001';scanner='Invoke-KanbanSourceScanner';status='PASS';readonly=$true;signals_count=$signals.Count;signals=$signals}
$out|ConvertTo-Json -Depth 80|Set-Content -Encoding UTF8 "$report\kanban-source-signals.json"
$out|ConvertTo-Json -Depth 80
