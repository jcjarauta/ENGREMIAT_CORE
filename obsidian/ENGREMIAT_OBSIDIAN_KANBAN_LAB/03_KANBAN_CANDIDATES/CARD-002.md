---
object_type: kanban_candidate
id: CARD-002
title: "Crear regla de prioridad simple"
source_need: NEED-002
status: CANDIDATE
kanban_decision: PENDING
human_reviewed: false
recommended_column: NEXT
tags: [engremiat_lab, kanban_candidate]
---

# CARD-002 · Crear regla de prioridad simple

## Origen
- [[../01_NEEDS/NEED-002|NEED-002 · Priorizar tareas antes de ejecutar]]

## Objetivo
Crear una tarjeta Kanban clara, con origen, criterio de terminado y evidencia esperada.

## Para probar el flujo
Cambia manualmente el YAML de esta nota a:

```yaml
kanban_decision: GO
human_reviewed: true
```

## Seguridad
Esta card no se importa automáticamente. Solo prepara la decisión humana.
