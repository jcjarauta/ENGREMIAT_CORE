# E06B REPAIR LAUNCHER RUNTIME UI PATCH TARGET

- package: ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
- stage: E06B_REPAIR_LAUNCHER_RUNTIME_UI_PATCH_TARGET_EXCLUDE_BACKUPS
- status: PASS
- mode: PATCH_SCRIPT_REPAIRED_PENDING_AUTH_NO_UI_MUTATION
- repaired_target: C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- target_is_backup: false
- patch_script: C:\ENGREMIAT_CORE\documents\launcher-runtime-ui-integration\patch-scripts\apply-launcher-runtime-ui-patch.pending-auth.ps1
- required_env: ENGREMIAT_LAUNCHER_RUNTIME_UI_PATCH_AUTH
- required_value: AUTORIZO_LAUNCHER_RUNTIME_UI_PATCH
- real_execution: false
- ui_mutated: false
- worker: false
- browser: false
- network: false
- git: false
- report: C:\ENGREMIAT_CORE\reports\launcher-runtime-ui-integration\e06b-repair-launcher-runtime-ui-patch-target-exclude-backups-20260620-151340.json
- next: E07_VERIFY_LAUNCHER_RUNTIME_UI_PATCH_SCRIPT_BLOCKS_WITHOUT_AUTH
