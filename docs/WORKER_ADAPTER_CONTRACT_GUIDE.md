# WORKER_ADAPTER_CONTRACT_GUIDE

Objetivo: definir como ENGREMIAT prepara requests para workers sin ejecutarlos automaticamente.

Adapters previstos:
- Cline CLI local en OLD-PC.
- Ollama remoto en MAIN-PC.
- Workers futuros genericos.

Regla principal:
Todo request nace como PREPARED_NOT_EXECUTED y dry_run=true.

Campos minimos:
- request_id
- worker_id
- worker_type
- role
- input_package
- allowed_actions
- blocked_actions
- human_gate_required
- dry_run
- evidence_required
- expected_receipt
- security_policy

Bloqueado por defecto:
- worker_real_execution
- auto_apply
- auto_approve
- git_write
- push/fetch/merge
- remote_inference
- ollama_generate
- ollama_chat
- secret_read

Siguiente: E02 Cline CLI dry-run.
