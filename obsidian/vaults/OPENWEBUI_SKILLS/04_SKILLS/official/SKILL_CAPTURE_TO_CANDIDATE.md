---
type: official_skill
skill_id: SKILL_CAPTURE_TO_CANDIDATE
candidate_id: CAND-20260618-002
project: ENGREMIAT_OPENWEBUI_SKILLS_002_SKILL_FACTORY_LIGHT
status: OFFICIAL
automation_status: MANUAL_ONLY
tags: [engremiat, official_skill, capture, candidate, openwebui]
---
# OFFICIAL SKILL · CAPTURE TO CANDIDATE

## Proposito

Convertir una captura útil de OpenWebUI, Ollama, Cline, ChatGPT o una observación humana en una ficha de candidata de skill, sin oficializarla prematuramente.

## Frase de activacion oficial

```text
Convierte esta captura en candidata de skill ENGREMIAT usando el schema de Skill Factory Light.
```

## Modo recomendado

Usar plantilla estricta rellenable. No usar instrucción abierta.

## Plantilla obligatoria

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

## Reglas

- No oficializar desde esta skill.
- No devolver PASS como decisión final.
- No explicar narrativamente si se pide plantilla.
- No usar JSON salvo que el humano lo pida.
- Mantener `test_status: PENDING`.
- Mantener `decision: CANDIDATE` o `CAPTURE_ONLY`.
- El siguiente paso debe ser test manual PASS/WARN/FAIL.

## Evidencia de oficializacion

- B05: WARN por salida desviada.
- B07: WARN por salida narrativa.
- B09: FAIL_CONTEXT resuelto con bundle Markdown único.
- B10: PASS_STRICT_TEMPLATE tras importar bundle y usar plantilla rígida.

## Estado

OFFICIAL · MANUAL_ONLY
