param([string]$DecisionPath="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
if([string]::IsNullOrWhiteSpace($DecisionPath)){throw "DecisionPath required"}
if(!(Test-Path $DecisionPath)){throw "Decision not found: $DecisionPath"}
$d=Get-Content $DecisionPath -Raw|ConvertFrom-Json
$required=@("decision_id","gate_id","card_id","proposal_id","blueprint_id","decision","status","mode","human_gate","reason","effects_planned","effects_applied","forbidden_execution","source_gate_path","created_at")
foreach($k in $required){if($d.PSObject.Properties.Name -notcontains $k){throw "Missing required field: $k"};if($null -eq $d.$k){throw "Null required field: $k"}}
$allowed=@("APPROVE_BLUEPRINT","BLOCK_BLUEPRINT","REQUEST_CHANGES")
if($allowed -notcontains [string]$d.decision){throw "Invalid decision: $($d.decision)"}
if([string]$d.status -ne "DRY_RUN_DECISION_CREATED"){throw "Decision status must be DRY_RUN_DECISION_CREATED"}
if([string]$d.mode -ne "DRY_RUN_NO_GATE_MUTATION"){throw "Decision mode must be DRY_RUN_NO_GATE_MUTATION"}
if([string]$d.human_gate -ne "SI"){throw "Decision human_gate must be SI"}
if(@($d.effects_applied).Count -ne 0){throw "Dry-run decision must not apply effects"}
if(!(Test-Path ([string]$d.source_gate_path))){throw "source_gate_path not found: $($d.source_gate_path)"}
$g=Get-Content ([string]$d.source_gate_path) -Raw|ConvertFrom-Json
if([string]$g.gate_id -ne [string]$d.gate_id){throw "Gate id mismatch"}
if([string]$g.decision -ne "PENDING_HUMAN_DECISION"){throw "Gate was mutated or is not pending"}
if([string]$g.status -ne "PENDING"){throw "Gate status was mutated or is not PENDING"}
$guards=@("execute_worker","modify_code_directly","git_commit","git_push","network_call","browser_action","autohotkey_action","delete_files")
foreach($x in $guards){if(@($d.forbidden_execution) -notcontains $x){throw "Decision missing guard: $x"}}
W ("OK human_gate_decision_valid decision_id="+$d.decision_id+" decision="+$d.decision+" mode="+$d.mode+" gate_status="+$g.status) Green