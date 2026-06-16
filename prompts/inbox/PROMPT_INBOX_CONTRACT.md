# PROMPT_INBOX_CONTRACT

## Propósito
Estandarizar la respuesta devuelta por Cline/Ollama sin aplicar cambios automáticamente.

## Ruta esperada
Guardar respuestas en `prompts/inbox/*.json` o `prompts/inbox/*.md`.

## Campos recomendados
- worker_id
- task_id
- decision: GO|NO_GO|REQUEST_CHANGES|BLOCKED
- summary
- files_touched
- tests_executed
- risks
- evidence
- validation_report
- external_network=false
- git_write=false
- next

## Seguridad
La importación de respuesta solo registra evidencia. No aplica cambios. No hace commit. No hace push.
