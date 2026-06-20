---
type: manual
skill_id: SKILL_CAPTURE_TO_CANDIDATE
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: ACTIVE
---
# MANUAL · SKILL CAPTURE TO CANDIDATE

## Cuando usarla

Cuando una respuesta o captura parezca útil y quieras convertirla en candidata reusable sin crear una skill oficial todavía.

## Prompt recomendado

```text
Rellena la plantilla siguiente.

REGLAS ESTRICTAS:
- No expliques el proceso.
- No devuelvas JSON.
- No escribas introduccion ni cierre.
- No oficialices la skill.
- No uses PASS.
- Mantén test_status: PENDING.
- Mantén decision: CANDIDATE.
- Devuelve SOLO la plantilla rellenada.

CAPTURA A CONVERTIR:
[pegar captura]

PLANTILLA OBLIGATORIA:
candidate_id: [asignar id]
proposed_skill_id: [asignar id]
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

## Criterios PASS

- Devuelve todos los campos.
- Mantiene test_status PENDING.
- Mantiene decision CANDIDATE o CAPTURE_ONLY.
- No oficializa.
- Define next como test manual.

## Mantenimiento

Si OpenWebUI no encuentra contexto, usar un bundle Markdown único importable con schema, contrato y plantilla.
