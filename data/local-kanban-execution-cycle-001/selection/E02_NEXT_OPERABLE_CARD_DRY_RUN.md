# E02 · Select next operable card · dry-run

## Resultado

```text
OPERABLE_CARD_SELECTED_FOR_CYCLE_DRY_RUN
```

## Política

- required_kanban_decision: GO
- required_human_reviewed: true
- preferred_columns: DOING, NEXT, REVIEW
- excluded_columns: DONE, BLOCKED

## Cards analizadas

### CARD-001 · Crear backlog visible
- operable: True
- score: 103
- column: DOING
- decision: GO
- reviewed: true
- priority: HIGH

### CARD-002 · Crear regla de prioridad simple
- operable: False
- score: 5
- column: BACKLOG
- decision: PENDING
- reviewed: false
- priority: MEDIUM

### CARD-003 · Crear evidencia de ejecución
- operable: True
- score: 100
- column: DOING
- decision: GO
- reviewed: true
- priority: MEDIUM

## Selección

- selected_card_id: CARD-001
- title: Crear backlog visible
- column: DOING
- score: 103
- path: C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\cards\CARD-001.md

## Archivos

- selection_json: C:\ENGREMIAT_CORE\data\local-kanban-execution-cycle-001\selection\next-operable-card.dry-run.json
- cycle_dry_run: C:\ENGREMIAT_CORE\data\local-kanban-execution-cycle-001\cycles\CYCLE-CARD-001-20260619-083507.cycle-dry-run.json

## Siguiente

E03_PREPARE_CARD_EXECUTION_CYCLE_JOB_DRY_RUN
