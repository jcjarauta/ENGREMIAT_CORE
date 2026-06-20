$ErrorActionPreference='Stop'
param([string]$TaskId='TASK-ASSISTED-001',[string]$OutDir='data/dev-assisted-worker')
New-Item -ItemType Directory -Force -Path $OutDir|Out-Null
$pkg=[ordered]@{task_id=$TaskId;objective_id='ENGREMIAT_MVP_FINAL_026_035';stage_id='E34';block_id='B34.2';step_id='P34.2.1';context='Assisted worker proposal-only package.';allowed_paths=@('docs/','reports/','data/dev-assisted-worker/');forbidden_paths=@('.git/','.env','secrets/','node_modules/','dist/');allowed_actions=@('READ','ANALYZE','GENERATE_DOC','SUGGEST_VALIDATION');forbidden_actions=@('APPLY_WITHOUT_GATE','PUSH','FETCH','MERGE','READ_SECRETS');expected_output='proposal with summary, files, evidence, risks, validation';gate_policy='HUMAN_APPROVE_REQUIRED_FOR_APPLY';evidence_required=@('summary','proposed_files','validation_commands','risks')}
$path=Join-Path $OutDir 'agent-task-package.sample.json'
$pkg|ConvertTo-Json -Depth 20|Set-Content $path -Encoding UTF8
Write-Host ('OK tool=eng-assisted-task-builder task='+$TaskId+' output='+$path+' mode=PROPOSAL_ONLY')
