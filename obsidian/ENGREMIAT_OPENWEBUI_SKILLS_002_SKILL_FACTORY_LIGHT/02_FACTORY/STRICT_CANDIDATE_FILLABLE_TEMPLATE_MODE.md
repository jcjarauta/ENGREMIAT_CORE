---
type: factory_decision
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: ACTIVE
---
# STRICT CANDIDATE FILLABLE TEMPLATE MODE

## Decisión

Para convertir capturas en candidatas, OpenWebUI debe recibir una plantilla exacta y completar campos, no recibir una instrucción abierta.

## Motivo

Los tests B05 y B07 muestran que el modelo tiende a resumir o explicar, aunque se le pida schema.

## Regla nueva

Usar siempre salida rígida:

```text
candidate_id:
proposed_skill_id:
name:
source:
human_problem:
trigger_phrase:
expected_output:
source_files:
test_status: PENDING
decision: CANDIDATE
next:
```

## Límite

No oficializar desde esta salida. Solo crear candidata y preparar test manual.
