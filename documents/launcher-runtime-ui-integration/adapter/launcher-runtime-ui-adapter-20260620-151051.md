# E03 LAUNCHER RUNTIME UI ADAPTER READONLY

- package: ENGREMIAT_LAUNCHER_RUNTIME_UI_INTEGRATION_001
- stage: E03_CREATE_LAUNCHER_RUNTIME_ADAPTER_NO_UI_MUTATION
- status: READY_NO_UI_MUTATION
- adapter_id: LAUNCHER_RUNTIME_UI_ADAPTER_READONLY_V1
- script: C:\ENGREMIAT_CORE\tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1
- supported_commands: acciones, estado, preview, aprobar(NO_GO), ejecutar(NO_GO), volver, ?, comandos, refrescar
- real_execution: false
- ui_mutated: false
- worker: false
- browser: false
- network: false
- git: false
- next: E03B_SMOKE_LAUNCHER_RUNTIME_ADAPTER_READONLY
