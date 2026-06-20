$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\internal-improvement-kanban-seed-001'
$signalsPath="$report\kanban-source-signals.json"
if(!(Test-Path $signalsPath)){throw "MISSING_SIGNALS $signalsPath"}
$sig=Get-Content -Raw $signalsPath|ConvertFrom-Json
$cards=@()
$i=0
foreach($s in @($sig.signals)){
 $i++
 $type=if($s.source_kind -eq 'NEXT_OBJECTIVE'){'NEXT_OBJECTIVE'}elseif($s.source_kind -eq 'VALIDATION'){'VALIDATION'}elseif($s.source_kind -eq 'FEEDBACK'){'IMPROVEMENT'}elseif($s.source_kind -eq 'CLOSE'){'EVIDENCE'}elseif($s.source_kind -eq 'MODULE'){'MODULE'}else{'EVIDENCE'}
 $col=if($s.status -eq 'ERR' -or $s.status -eq 'NO_GO'){'BLOCKED'}elseif($s.source_kind -eq 'NEXT_OBJECTIVE'){'READY'}elseif($s.source_kind -eq 'VALIDATION'){'VALIDATION'}elseif($s.closed -eq $true -or [string]$s.readiness -eq '100'){'DONE'}elseif($s.source_kind -eq 'FEEDBACK'){'BACKLOG'}else{'BACKLOG'}
 $title="$($s.source_kind): $($s.source_name)"
 $cards+=[ordered]@{card_id=('KANBAN-SEED-{0:0000}' -f $i);title=$title;type=$type;column=$col;source_path=$s.source_path;source_kind=$s.source_kind;status=$s.status;readiness=$s.readiness;evidence_ref=$s.source_path;next=$s.next}
}
$out=[ordered]@{package_id='ENGREMIAT_INTERNAL_IMPROVEMENT_KANBAN_SEED_001';generator='Invoke-KanbanSeedGenerator';status='PASS';real_kanban_write=$false;cards_count=$cards.Count;columns=@('BACKLOG','READY','IN_PROGRESS','GATED','VALIDATION','DONE','BLOCKED');cards=$cards}
$out|ConvertTo-Json -Depth 80|Set-Content -Encoding UTF8 "$report\kanban-seed-output.json"
$out|ConvertTo-Json -Depth 80
