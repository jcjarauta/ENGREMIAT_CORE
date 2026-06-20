---
type: official_skill
skill_id: SKILL_ESTADO_ENGREMIAT
candidate_id: CAND-20260618-001
project: ENGREMIAT_OPENWEBUI_SKILLS_001
status: OFFICIAL
tags: [engremiat, official_skill, estado, openwebui]
---
# OFFICIAL SKILL · ESTADO ENGREMIAT

## Proposito

Recuperar rapidamente el estado operativo de ENGREMIAT desde Markdown normalizado, evitando releer conversaciones largas o buscar manualmente reports dispersos.

## Frase de activacion oficial

```text
Usa la Skill ENGREMIAT de estado y resume: estado actual, ultimo bloque cerrado, siguiente paso y riesgos.
```

## Fuentes prioritarias

1. `01_ESTADO/ESTADO_ACTUAL.md`
2. `01_ESTADO/NEXT.md`
3. `90_INDEXES/MASTER_INDEX.md`
4. `03_SKILLS/OFFICIAL_SKILLS_REGISTRY.md`
5. Receipts/reports recientes enlazados.

## Formato de salida esperado

```text
Estado actual:
Ultimo bloque cerrado:
Siguiente paso:
Riesgos:
Decision recomendada:
```

## Reglas operativas

- Priorizar estado actual y NEXT sobre memoria antigua.
- No inventar bloques cerrados.
- Si falta fuente, decirlo.
- Si hay conflicto entre fuentes, señalar conflicto.
- Responder compacto y accionable.

## Evidencia de oficializacion

- Candidata: `CAND-20260618-001`.
- Test manual OpenWebUI: PASS.
- Resultado observado: OpenWebUI recupero estado, ultimo bloque, siguiente paso y riesgos desde Markdown.
- Cierre: B21.

## Estado

OFFICIAL
