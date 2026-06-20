# E03 · Human gate for card state transitions

## Objetivo

Autorizar o diferir la aplicación real de transiciones de estado sobre tarjetas Markdown/YAML del Kanban local.

## Estado

```text
TRANSITION_PROPOSALS_READY_FOR_GATE
```

## Importante

Este paso E03 no modifica tarjetas. Solo prepara gate y aplicador bloqueado.

## Frase de autorización para E04

```text
AUTORIZO_APLICAR_TRANSICIONES_KANBAN_LOCAL_CON_BACKUP
```

## Propuestas listas

### CARD-001 CARD-002 CARD-003 · Crear backlog visible Crear regla de prioridad simple Crear evidencia de ejecución
- from: NEXT BACKLOG DOING
- to: DOING BACKLOG REVIEW
- reason: Worker response/evidence exists; propose entering DOING as controlled intermediate before REVIEW Card decision is not GO Worker response/evidence captured; propose human review
- risk: MEDIUM LOW MEDIUM
- card_path: C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\cards\CARD-001.md C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\cards\CARD-002.md C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\cards\CARD-003.md
- response_path: C:\ENGREMIAT_CORE\data\local-kanban-worker-loop-001\responses\JOB-CARD-001-OLLAMA-20260619-082149.worker-response.md  C:\ENGREMIAT_CORE\data\local-kanban-worker-loop-001\responses\JOB-CARD-003-20260619-080934.worker-response.md
- evidence_path: C:\ENGREMIAT_CORE\data\local-kanban-worker-loop-001\evidence\JOB-CARD-001-OLLAMA-20260619-082149.evidence.md  C:\ENGREMIAT_CORE\data\local-kanban-worker-loop-001\evidence\JOB-CARD-003-20260619-080934.evidence.md

## Seguridad

- backup_required: true
- apply_without_human_authorization: false
- write_to_cline_kanban: false
- git_write: false
- external_network: false

## Siguiente

Si autorizas, responder con la frase exacta para ejecutar E04_APPLY_CARD_STATE_TRANSITION_WITH_BACKUP.
