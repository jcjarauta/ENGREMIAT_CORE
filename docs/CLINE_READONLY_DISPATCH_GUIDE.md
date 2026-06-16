# CLINE_READONLY_DISPATCH_GUIDE

Objetivo: preparar el dispatch controlado de Cline para una primera ejecucion readonly.

Estado por defecto:
- preview_only=true
- execute=false
- Cline no se lanza en E03.

Permitido solo con gate posterior:
- lanzar Cline para analisis/propuesta readonly.

Bloqueado:
- escribir archivos
- ejecutar comandos
- auto_apply
- git_write
- commit
- push/fetch/merge
- inferencia remota.

Script dispatcher:
tools/gated-worker-execution/Invoke-ClineReadonlyGated.ps1

Uso seguro actual:
powershell -NoProfile -ExecutionPolicy Bypass -File tools/gated-worker-execution/Invoke-ClineReadonlyGated.ps1

Uso de ejecucion futura, solo cuando toque E04:
powershell -NoProfile -ExecutionPolicy Bypass -File tools/gated-worker-execution/Invoke-ClineReadonlyGated.ps1 -ExecuteGate

En E03 no usamos -ExecuteGate.
