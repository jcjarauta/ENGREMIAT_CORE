# E03 PENDING AUTH ROUTE BINDING SCRIPT

- package: ENGREMIAT_SCREEN_MAINTENANCE_ROUTE_BINDING_001
- stage: E03_CREATE_PENDING_AUTH_ROUTE_BINDING_PATCH_NO_APPLY
- status: PASS
- mode: PENDING_AUTH_ROUTE_BINDING_SCRIPT_CREATED_AND_BLOCKED_WITHOUT_AUTH
- target: C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- script: C:\ENGREMIAT_CORE\documents\screen-maintenance-route-binding\pending-auth-patch\apply-route-binding-m-maintenance.pending-auth.ps1
- required_authorization_code: AUTORIZO_BIND_M_MANTENIMIENTO_OPERATOR
- dry_run_without_auth: NO_GO
- report: C:\ENGREMIAT_CORE\reports\screen-maintenance-route-binding\e03-create-pending-auth-route-binding-patch-no-apply-20260620-155203.json
- real_execution: false
- system_mutation: false
- screen_mutation: false
- worker: false
- browser: false
- network: false
- git: false
- next: E04_APPLY_ROUTE_BINDING_WITH_EXPLICIT_AUTH
