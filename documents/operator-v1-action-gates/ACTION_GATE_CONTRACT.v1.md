# ACTION GATE CONTRACT v1

## Proposito
Definir gates de acciones V1 para preparar acciones reales sin ejecutarlas.

## Principios
- Preparar gate, no ejecutar
- Autorizacion humana explicita obligatoria
- Riesgo, alcance, rollback y validacion visibles
- Comando solo como preview
- Navegacion read-only preservada
- Una accion = un gate
- Sin push/fetch/merge/delete salvo cierre autorizado

## Estados de gate
- DRAFT
- PENDING_HUMAN_AUTHORIZATION
- APPROVED_FOR_SINGLE_EXECUTION
- REJECTED
- EXPIRED
- EXECUTED_WITH_EVIDENCE

## Campos obligatorios
- gate_id
- screen
- action_id
- title
- risk
- scope
- target_path
- command_preview
- requires_human_authorization
- authorization_phrase
- rollback
- validation
- blocked_by_default
- created_at
- expires_at
- status

## Primeras integraciones propuestas
- Projects: prepare_open_project_folder_gate
- Memory Docs: prepare_open_document_external_gate
- Data Intake: prepare_import_source_gate
- Health Launchers: prepare_run_healthcheck_gate

## Acciones duramente bloqueadas sin autorizacion
- push
- fetch
- merge
- delete_files
- worker_real
- api_external
- browser
- clipboard
- execute_smoke
- execute_repair
- modify_file
- open_external

## NEXT
E02_CREATE_GATE_MODEL_READONLY
