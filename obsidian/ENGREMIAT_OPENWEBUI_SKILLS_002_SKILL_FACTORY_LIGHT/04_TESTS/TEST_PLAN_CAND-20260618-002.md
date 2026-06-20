---
type: manual_test_plan
candidate_id: CAND-20260618-002
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: READY
---
# TEST PLAN · CAND-20260618-002

## Objetivo

Comprobar si OpenWebUI puede transformar una captura útil en una candidata de skill usando el schema de la fábrica ligera.

## Prompt

```text
Convierte esta captura en candidata de skill ENGREMIAT usando el schema de Skill Factory Light.

Captura:
La respuesta de OpenWebUI sobre el estado ENGREMIAT fue útil porque resumió estado actual, último bloque, siguiente paso y riesgos. Queremos convertir este patrón en una candidata reutilizable para próximas capturas.
```

## Criterios PASS

- Respeta los campos obligatorios del schema.
- No oficializa directamente.
- Propone test_status PENDING.
- Propone decision CANDIDATE o CAPTURE_ONLY.
- Define siguiente paso manual.

## Criterios WARN

- La ficha es útil pero incompleta.

## Criterios FAIL

- Inventa una skill oficial sin test.
- No usa el schema.
- Responde genérico.
