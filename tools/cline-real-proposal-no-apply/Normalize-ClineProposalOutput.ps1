$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$base='data/cline-real-proposal-no-apply'
$rawPath="$base/cline-proposal-raw-output.json"
$candidatePath="$base/cline-proposal-task-candidate.json"
$outPath="$base/cline-proposal-normalized.json"
foreach($p in @($rawPath,$candidatePath)){if(-not(Test-Path $p)){throw "Falta artefacto requerido: $p"}}
$raw=Get-Content $rawPath -Raw|ConvertFrom-Json
$candidate=Get-Content $candidatePath -Raw|ConvertFrom-Json
$text=[string]$raw.raw_text
$pending=($raw.status -eq 'PENDING_OUTPUT')
$proposal=[ordered]@{objective='ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008';stage='E05';status=($(if($pending){'PENDING_OUTPUT'}else{'NORMALIZED_FROM_RAW_OUTPUT'}));summary=($(if($pending){'No hay output real de Cline porque la tarea no fue creada o no se ha aportado salida manual.'}else{($text.Substring(0,[Math]::Min(500,$text.Length)))}));target_context=[ordered]@{candidate_id=$candidate.candidate_id;source_card_id=$candidate.source_card_id;title=$candidate.title};affected_files=@();proposed_changes=@();proposed_diff_or_patch=($(if($pending){'PENDING_OUTPUT_NO_DIFF_AVAILABLE'}else{$text}));risks=@('No aplicar sin revision humana','Output pendiente si no existe tarea real Cline');tests_or_validation=@('Validar propuesta antes de abrir objetivo apply separado');evidence=@($rawPath,$candidatePath,'data/cline-real-proposal-no-apply/cline-proposal-output-contract.json');open_questions=@($(if($pending){'Esperar autorizacion/tarea real o aportar salida manual de Cline en manual-cline-output.md'}else{'Revisar si la propuesta es suficiente para un objetivo apply separado'}));recommended_human_decision=($(if($pending){'DEFER'}else{'REVIEW_MORE'}));safety=[ordered]@{proposal_only=$true;apply_executed=$false;source_write_by_worker=$false;git_write=$false;git_commit=$false;git_push=$false;remote_inference=$false;ui_automation=$false}}
J $proposal $outPath
Write-Host ("OK objective=ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008 stage=E05 normalized_status="+$proposal.status+" decision="+$proposal.recommended_human_decision+" output="+$outPath) -ForegroundColor Green
