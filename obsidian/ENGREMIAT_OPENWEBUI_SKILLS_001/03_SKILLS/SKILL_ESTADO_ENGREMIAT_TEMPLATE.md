---
type: skill_template
skill_id: SKILL_ESTADO_ENGREMIAT
candidate_id: CAND-20260618-001
project: ENGREMIAT_OPENWEBUI_SKILLS_001
status: TESTABLE
tags: [engremiat, skill, estado, resumen]
---
# SKILL · ESTADO ENGREMIAT

## Proposito

Recuperar rapidamente el estado operativo del proyecto ENGREMIAT sin releer conversaciones largas ni navegar reports dispersos.

## Frase de activacion

Usa la Skill ENGREMIAT de estado y resume: estado actual, ultimo bloque cerrado, siguiente paso y riesgos.

## Fuentes prioritarias

1. [[../01_ESTADO/ESTADO_ACTUAL]]
2. [[../01_ESTADO/NEXT]]
3. [[../90_INDEXES/MASTER_INDEX]]
4. [[SKILL_CANDIDATE_LOG]]
5. Reports de cierre recientes si estan enlazados.

## Formato de salida esperado

```text
Estado actual:
Ultimo bloque cerrado:
Siguiente paso:
Riesgos:
Decision recomendada:
```

## Reglas

- Responder compacto.
- Citar incertidumbre si falta fuente.
- Priorizar estado actual y NEXT sobre memoria antigua.
- No inventar bloques cerrados.
- Si hay conflicto entre fuentes, indicar conflicto.

## Estado

TESTABLE
