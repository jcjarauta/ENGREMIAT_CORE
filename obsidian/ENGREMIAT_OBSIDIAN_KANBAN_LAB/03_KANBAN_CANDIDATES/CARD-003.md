---
object_type: kanban_candidate
id: CARD-003
title: "Crear evidencia de ejecución"
source_need: NEED-003
status: CANDIDATE
kanban_decision: PENDING
human_reviewed: false
recommended_column: NEXT
tags: [engremiat_lab, kanban_candidate]
---

# CARD-003 · Crear evidencia de ejecución

## Origen
- [[../01_NEEDS/NEED-003|NEED-003 · Recoger evidencia del resultado]]

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
