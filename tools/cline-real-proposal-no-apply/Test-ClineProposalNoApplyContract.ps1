$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$objective='ENGREMIAT_CLINE_REAL_PROPOSAL_NO_APPLY_008'
$base='data/cline-real-proposal-no-apply'
$reportPath='reports/cline-real-proposal-no-apply/e01-contract-validation-report.json'
$scopePath="$base/first-cline-proposal-no-apply-scope.json"
$policyPath="$base/cline-proposal-no-apply-policy.json"
$outputPath="$base/cline-proposal-output-contract.json"
$guidePath='docs/CLINE_PROPOSAL_NO_APPLY_CONTRACT_GUIDE.md'
foreach($p in @($scopePath,$policyPath,$outputPath,$guidePath)){if(-not(Test-Path $p)){throw "Falta artefacto requerido: $p"}}
$scope=Get-Content $scopePath -Raw|ConvertFrom-Json
$policy=Get-Content $policyPath -Raw|ConvertFrom-Json
$output=Get-Content $outputPath -Raw|ConvertFrom-Json
$falseFlags=@("cline_task_created","launch_cline_task","prompt_sent","worker_real_execution","auto_apply","apply_executed","source_write_by_worker","git_write","git_commit","git_push","remote_inference","ui_automation")
$bad=@()
foreach($f in $falseFlags){if($scope.safety.$f -ne $false){$bad+=("scope:"+$f)};if($policy.safety.$f -ne $false){$bad+=("policy:"+$f)};if($output.safety.$f -ne $false){$bad+=("output:"+$f)}}
if($scope.safety.proposal_only -ne $true){$bad+="scope:proposal_only"}
if($policy.proposal_only -ne $true){$bad+="policy:proposal_only"}
if($policy.human_review_required -ne $true){$bad+="policy:human_review_required"}
if($policy.apply_allowed -ne $false){$bad+="policy:apply_allowed"}
if($policy.git_write_allowed -ne $false){$bad+="policy:git_write_allowed"}
$required=@("summary","target_context","affected_files","proposed_changes","proposed_diff_or_patch","risks","tests_or_validation","evidence","open_questions","recommended_human_decision")
$missing=@();foreach($s in $required){if(@($output.required_sections) -notcontains $s){$missing+=$s}}
$ok=($bad.Count -eq 0 -and $missing.Count -eq 0)
$report=[ordered]@{objective=$objective;stage="E01";blocks="B01.1-B01.3";steps=6;scope_file=$scopePath;policy_file=$policyPath;output_contract_file=$outputPath;guide_file=$guidePath;required_sections_checked=$required.Count;missing_required_sections=$missing;bad_safety_flags=$bad;proposal_only=$true;human_review_required=$true;cline_task_created=$false;launch_cline_task=$false;prompt_sent=$false;worker_real_execution=$false;auto_apply=$false;apply_executed=$false;source_write_by_worker=$false;git_write=$false;git_commit=$false;git_push=$false;remote_inference=$false;ui_automation=$false;readiness=($(if($ok){100}else{70}));decision=($(if($ok){"GO_E01_CLINE_PROPOSAL_NO_APPLY_CONTRACT_VALIDATED"}else{"NO_GO_E01_REPAIR_REQUIRED"}));next=($(if($ok){"E02_SELECT_KANBAN_CANDIDATE_AND_PROMPT_PREVIEW"}else{"REPAIR_E01_CONTRACT"}))}
J $report $reportPath
if(-not $ok){throw "E01 validation failed"}
Write-Host ("OK objective="+$objective+" stage=E01 readiness="+$report.readiness+" decision="+$report.decision+" auto_apply="+$report.auto_apply+" git_write="+$report.git_write+" report="+$reportPath+" next="+$report.next) -ForegroundColor Green
