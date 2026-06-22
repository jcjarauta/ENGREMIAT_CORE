param([string]$ProposalPath="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c="Gray"){try{Write-Host $m -ForegroundColor $c}catch{Write-Host $m}}
if([string]::IsNullOrWhiteSpace($ProposalPath)){throw "ProposalPath required"}
if(!(Test-Path $ProposalPath)){throw "Proposal not found: $ProposalPath"}
$raw=Get-Content $ProposalPath -Raw
$p=$raw|ConvertFrom-Json
$required=@("proposal_id","card_id","project_id","module_id","action","status","risk","human_gate","reason","expected_output","forbidden_execution","created_by","created_at")
foreach($k in $required){if($p.PSObject.Properties.Name -notcontains $k){throw "Missing required field: $k"};if($null -eq $p.$k){throw "Null required field: $k"}}
$allowedActions=@("review","approve_proposal","block","convert_to_module_blueprint","convert_to_task_blueprint")
$allowedStatus=@("PROPOSED","REVIEWED","APPROVED_FOR_BLUEPRINT","BLOCKED","BLUEPRINT_CREATED")
$allowedRisk=@("LOW","MEDIUM","HIGH")
$guards=@("execute_worker","modify_code_directly","git_commit","git_push","network_call","browser_action","autohotkey_action","delete_files")
if($allowedActions -notcontains [string]$p.action){throw "Invalid action: $($p.action)"}
if($allowedStatus -notcontains [string]$p.status){throw "Invalid status: $($p.status)"}
if($allowedRisk -notcontains [string]$p.risk){throw "Invalid risk: $($p.risk)"}
if([string]$p.human_gate -notin @("SI","NO")){throw "Invalid human_gate: $($p.human_gate)"}
if([string]$p.action -ne "review" -and [string]$p.human_gate -ne "SI"){throw "Unsafe proposal: non-review actions require human_gate=SI"}
foreach($x in @($p.forbidden_execution)){if($guards -notcontains [string]$x){throw "Unknown forbidden_execution guard: $x"}}
foreach($x in $guards){if(@($p.forbidden_execution) -notcontains $x){throw "Missing forbidden execution guard: $x"}}
foreach($x in $guards){$needle1=[char]34+$x+[char]34+":"+"true";$needle2=[char]34+$x+[char]34+": true";$needle3=$x+"=true";if($raw.Replace(" ","").Contains($needle1.Replace(" ","")) -or $raw.Contains($needle2) -or $raw.ToLower().Contains($needle3.ToLower())){throw "Unsafe payload tries to enable forbidden action: $x"}}
W ("OK card_action_proposal_valid proposal_id="+$p.proposal_id+" card_id="+$p.card_id+" action="+$p.action+" status="+$p.status+" human_gate="+$p.human_gate) Green