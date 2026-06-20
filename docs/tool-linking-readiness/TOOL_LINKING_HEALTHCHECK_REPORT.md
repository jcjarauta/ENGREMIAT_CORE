# TOOL LINKING HEALTHCHECK REPORT

generated_at: 2026-06-18T10:59:09
readiness: 100
decision: GO_TOOL_LINKING_HEALTHCHECK_READY

## Counts
- inbox_json: 3
- processed_json: 6
- detected_inputs: 3
- recurrent_cards: 10
- obsidian_candidates: 10
- obsidian_export_notes: 4
- inline_batches: 5
- sandbox_inbox_json: 1
- sandbox_reports: 2

## Required paths
- core_root: OK
  - C:\ENGREMIAT_CORE
- tool_linking_map: OK
  - C:\ENGREMIAT_CORE\docs\tool-linking-readiness\TOOL_LINKING_READINESS_MAP.md
- tool_linking_contract: OK
  - C:\ENGREMIAT_CORE\contracts\tool-linking\tool-linking-permissions-contract.json
- readonly_inbox: OK
  - C:\ENGREMIAT_CORE\docs\openwebui-openclaw-readonly-adapter\inbox
- readonly_intake_tool: OK
  - C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-OpenWebUIOpenClawReadonlyIntake.ps1
- openclaw_skill: OK
  - C:\ENGREMIAT_CORE\docs\openclaw-skill-packet\engremiat-readonly-intake-skill\SKILL.md
- openclaw_skill_contract: OK
  - C:\ENGREMIAT_CORE\contracts\openclaw-skill-packet\openclaw-readonly-intake-output-contract.json
- recurrent_model_tool: OK
  - C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-RecurrentCardRefreshModel.ps1
- obsidian_export_tool: OK
  - C:\ENGREMIAT_CORE\tools\kanban-local\Export-ObsidianCandidatePack.ps1
- obsidian_vault_gate_tool: OK
  - C:\ENGREMIAT_CORE\tools\kanban-local\Invoke-ObsidianVaultWriteGate.ps1
- appendix_dashboard: OK
  - C:\ENGREMIAT_CORE\docs\system-dashboard\ENGREMIAT_APPENDIX_SYSTEM_DASHBOARD.html
- system_kanban: OK
  - C:\ENGREMIAT_CORE\docs\kanban-backlog\system-view\ENGREMIAT_SYSTEM_KANBAN.html
- first_real_linking_sandbox_report: OK
  - C:\ENGREMIAT_CORE\reports\tool-linking-sandbox\FIRST_REAL_LINKING_SANDBOX_001.close-report.json
- first_real_linking_sandbox_inbox: OK
  - C:\ENGREMIAT_CORE\runtime\tool-linking-sandbox\openclaw-openwebui-inbox

## Optional paths
- obsidian_vault_path_config_optional: OPTIONAL_MISSING
  - C:\ENGREMIAT_CORE\config\obsidian-vault-path.txt

## Policy
- OpenWebUI API: not called
- OpenClaw API: not called
- Native Kanban write: disabled
- Obsidian real write: gated
- Execution: disabled

## Next
DROP_REAL_OPENWEBUI_OR_OPENCLAW_JSON_IN_SANDBOX_INBOX
