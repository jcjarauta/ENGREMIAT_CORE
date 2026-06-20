# E01 · Card execution cycle contract

## Objetivo

Unificar las piezas ya validadas en un ciclo completo y gobernado de ejecución de una tarjeta local.

## Flujo objetivo

```text
select card
→ create job
→ worker mock/Ollama gated
→ response/evidence
→ transition proposal
→ human gate
→ backup/update card
→ rebuild dashboard
→ receipt
```

## Política de selección

- kanban_decision: GO
- human_reviewed: true
- columnas preferidas: DOING, NEXT, REVIEW
- columnas excluidas: DONE, BLOCKED

## Seguridad

- No Cline/Kanban write.
- No git.
- No red externa.
- Ollama solo con frase explícita.
- Toda actualización Markdown/YAML requiere backup y gate.

## Archivos

- Contract JSON: 
C:\ENGREMIAT_CORE\data\local-kanban-execution-cycle-001\contracts\card-execution-cycle-contract.v1.json

## Siguiente

E02_SELECT_NEXT_OPERABLE_CARD_DRY_RUN
