param([string]$Root='C:\ENGREMIAT_CORE',[switch]$OpenReport)
$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W($m,$c='Cyan'){Write-Host $m -ForegroundColor $c}
function CP($k,$p,[bool]$r=$true){$e=Test-Path $p;[pscustomobject]@{key=$k;path=$p;required=$r;exists=$e;status=if($e){'OK'}elseif($r){'MISSING'}else{'OPTIONAL_MISSING'}}}
function CF($p,$f){if(!(Test-Path $p)){return 0};(Get-ChildItem $p -Filter $f -File -ErrorAction SilentlyContinue).Count}
W 'ENGREMIAT_PACKAGE_BEGIN package=TOOL_LINKING_HEALTHCHECK_RUN_003'
$paths=@()
$paths+=CP 'core_root' $Root
$paths+=CP 'tool_linking_map' (Join-Path $Root 'docs\tool-linking-readiness\TOOL_LINKING_READINESS_MAP.md')
$paths+=CP 'tool_linking_contract' (Join-Path $Root 'contracts\tool-linking\tool-linking-permissions-contract.json')
$paths+=CP 'readonly_inbox' (Join-Path $Root 'docs\openwebui-openclaw-readonly-adapter\inbox')
$paths+=CP 'readonly_intake_tool' (Join-Path $Root 'tools\kanban-local\Invoke-OpenWebUIOpenClawReadonlyIntake.ps1')
$paths+=CP 'openclaw_skill' (Join-Path $Root 'docs\openclaw-skill-packet\engremiat-readonly-intake-skill\SKILL.md')
$paths+=CP 'openclaw_skill_contract' (Join-Path $Root 'contracts\openclaw-skill-packet\openclaw-readonly-intake-output-contract.json')
$paths+=CP 'recurrent_model_tool' (Join-Path $Root 'tools\kanban-local\Invoke-RecurrentCardRefreshModel.ps1')
$paths+=CP 'obsidian_export_tool' (Join-Path $Root 'tools\kanban-local\Export-ObsidianCandidatePack.ps1')
$paths+=CP 'obsidian_vault_gate_tool' (Join-Path $Root 'tools\kanban-local\Invoke-ObsidianVaultWriteGate.ps1')
$paths+=CP 'appendix_dashboard' (Join-Path $Root 'docs\system-dashboard\ENGREMIAT_APPENDIX_SYSTEM_DASHBOARD.html')
$paths+=CP 'system_kanban' (Join-Path $Root 'docs\kanban-backlog\system-view\ENGREMIAT_SYSTEM_KANBAN.html')
$paths+=CP 'first_real_linking_sandbox_report' (Join-Path $Root 'reports\tool-linking-sandbox\FIRST_REAL_LINKING_SANDBOX_001.close-report.json')
$paths+=CP 'first_real_linking_sandbox_inbox' (Join-Path $Root 'runtime\tool-linking-sandbox\openclaw-openwebui-inbox')
$paths+=CP 'obsidian_vault_path_config_optional' (Join-Path $Root 'config\obsidian-vault-path.txt') $false
$counts=[ordered]@{
  inbox_json=CF (Join-Path $Root 'docs\openwebui-openclaw-readonly-adapter\inbox') '*.json'
  processed_json=CF (Join-Path $Root 'docs\openwebui-openclaw-readonly-adapter\processed') '*.json'
  detected_inputs=CF (Join-Path $Root 'docs\openwebui-openclaw-readonly-adapter\detected-inputs') '*.json'
  recurrent_cards=CF (Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model\cards') '*.md'
  obsidian_candidates=CF (Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model\obsidian-candidates') '*.obsidian-candidate.md'
  obsidian_export_notes=CF (Join-Path $Root 'docs\obsidian-export-candidates\notes') '*.md'
  inline_batches=CF (Join-Path $Root 'docs\kanban-backlog\recurrent-card-refresh-model\inline-batches') '*.md'
  sandbox_inbox_json=CF (Join-Path $Root 'runtime\tool-linking-sandbox\openclaw-openwebui-inbox') '*.json'
  sandbox_reports=CF (Join-Path $Root 'reports\tool-linking-sandbox') '*.json'
}
$missing=@($paths|Where-Object{$_.required -and !$_.exists})
$readiness=if($missing.Count -eq 0){100}else{[math]::Max(0,100-($missing.Count*10))}
$decision=if($missing.Count -eq 0){'GO_TOOL_LINKING_HEALTHCHECK_READY'}else{'WARN_TOOL_LINKING_MISSING_REQUIRED_ARTIFACTS'}
$next=if($missing.Count -eq 0){'DROP_REAL_OPENWEBUI_OR_OPENCLAW_JSON_IN_SANDBOX_INBOX'}else{'REPAIR_MISSING_REQUIRED_ARTIFACTS'}
$stamp=Get-Date -Format 'yyyyMMdd-HHmmss'
$reportDir=Join-Path $Root 'reports\tool-linking-healthcheck'
$docDir=Join-Path $Root 'docs\tool-linking-readiness'
New-Item -ItemType Directory -Force -Path $reportDir,$docDir | Out-Null
$report=Join-Path $reportDir "tool-linking-healthcheck.$stamp.json"
$md=Join-Path $docDir 'TOOL_LINKING_HEALTHCHECK_REPORT.md'
[pscustomobject]@{package='TOOL_LINKING_HEALTHCHECK_RUN_003';created_at=(Get-Date).ToString('s');readiness=$readiness;decision=$decision;paths=$paths;counts=$counts;missing_required=$missing;policy=[pscustomobject]@{openwebui_api_called=$false;openclaw_api_called=$false;native_kanban_write='disabled';obsidian_real_write='gated';execution_allowed=$false;mode='LOCAL_READONLY_HEALTHCHECK'};next=$next}|ConvertTo-Json -Depth 8|Set-Content $report -Encoding UTF8
$lines=@('# TOOL LINKING HEALTHCHECK REPORT','',"generated_at: $((Get-Date).ToString('s'))","readiness: $readiness","decision: $decision",'','## Counts')
foreach($k in $counts.Keys){$lines+=('- {0}: {1}' -f $k,$counts[$k])}
$lines+=@('','## Required paths')
foreach($p in ($paths|Where-Object{$_.required})){$lines+=('- {0}: {1}' -f $p.key,$p.status);$lines+=('  - {0}' -f $p.path)}
$lines+=@('','## Optional paths')
foreach($p in ($paths|Where-Object{!$_.required})){$lines+=('- {0}: {1}' -f $p.key,$p.status);$lines+=('  - {0}' -f $p.path)}
$lines+=@('','## Next',$next)
Set-Content $md $lines -Encoding UTF8
if($OpenReport){Start-Process notepad.exe $md}
W "OK readiness=$readiness" Green
W "OK decision=$decision" Green
W "OK report=$report" Green
W "OK markdown=$md" Green
W "OK missing_required=$($missing.Count)" $(if($missing.Count -eq 0){'Green'}else{'Yellow'})
W "DECISION=$decision" $(if($missing.Count -eq 0){'Green'}else{'Yellow'})
W "NEXT=$next" Magenta
W 'ENGREMIAT_PACKAGE_END package=TOOL_LINKING_HEALTHCHECK_RUN_003'
