# CLINE_ADAPTER_GUIDE

Objetivo: usar Cline CLI como worker local gobernado, sin autonomia.

Estado del adapter:
- worker_type: cline_cli_local
- execution_mode: DRY_RUN_ONLY
- dry_run: true
- human_gate_required: true

Permitido en E02:
- detectar cline --version
- generar request JSON
- validar contrato
- simular dispatch
- generar evidencia

Bloqueado en E02:
- abrir tarea Cline
- enviar prompt a Cline
- auto-approve
- auto-apply
- escribir cambios en codigo
- git write
- push/fetch/merge

Para ejecucion real futura se requerira gate humano APPROVE explicito.
