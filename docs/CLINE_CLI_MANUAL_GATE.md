CLINE_CLI_MANUAL_GATE

Estado: Cline CLI preparado en modo seguro/gated.

Si falta Node/npm:
1. Completar E02 core toolchain.
2. Cerrar y reabrir PowerShell para refrescar PATH.
3. Reejecutar E04.

Si falta Cline y Node/npm existen:
1. Revisar tools/toolchain/Install-ClineCliGate.ps1.
2. Ejecutar solo con autorización explícita: powershell -NoProfile -ExecutionPolicy Bypass -File tools/toolchain/Install-ClineCliGate.ps1 --execute
3. Reejecutar E04.

Reglas:
- auto_apply=False
- auto_approve=False
- worker_real_execution=False
- git_write=False
- human_gate_required=True
