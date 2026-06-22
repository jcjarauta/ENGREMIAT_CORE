# E114 PENDING AUTH MODULE ACTION RUNNER

- package: ENGREMIAT_MODULE_CARD_ACTION_FLOW_001
- stage: E114_CREATE_PENDING_AUTH_MODULE_ACTION_RUNNER
- status: PASS
- mode: RUNNER_CREATED_ONLY_NO_EXECUTION
- runner: C:\ENGREMIAT_CORE\tools\launcher\module-actions\run-approved-module-action.pending-auth.ps1
- source_plan: C:\ENGREMIAT_CORE\documents\module-cards\blueprint-execution-plans\approved-module-blueprint-execution-plan.latest.json
- authorization_required: true
- required_env: ENGREMIAT_MODULE_ACTION_AUTH
- required_value: AUTORIZO_E115_RUN_APPROVED_MODULE_ACTION
- real_execution: false
- module_action_executed: false
- worker: false
- browser: false
- network: false
- git: false
- next: E114B_VERIFY_MODULE_ACTION_RUNNER_BLOCKS_WITHOUT_AUTH
