# WORKER_RECEIPT_GUIDE

Objetivo: explicar como interpretar receipts de worker en ENGREMIAT.

Un receipt demuestra:
- que existe un request
- que existe una decision humana o estado DEFER
- que existe una response real o simulada
- que se registran hashes
- que se puede auditar si hubo ejecucion o no

En E04 el receipt es simulado y seguro:
- executed=false
- no_execution=true
- worker_real_execution=false
- cline_launched=false
- ollama_called=false
- auto_apply=false
- git_write=false

Campos clave:
- receipt_id
- request_id
- worker_id
- decision
- executed
- no_execution
- request_sha256
- response_sha256
- gate_sha256

Regla: si no hay APPROVE explicito, el receipt debe indicar no_execution=true.
