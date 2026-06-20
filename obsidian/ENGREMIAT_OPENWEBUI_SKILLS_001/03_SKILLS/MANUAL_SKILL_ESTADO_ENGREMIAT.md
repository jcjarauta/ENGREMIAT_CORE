---
type: manual
skill_id: SKILL_ESTADO_ENGREMIAT
project: ENGREMIAT_OPENWEBUI_SKILLS_001
status: ACTIVE
---
# MANUAL · SKILL ESTADO ENGREMIAT

## Cuando usarla

Usarla al retomar el desarrollo, al abrir OpenWebUI, antes de decidir el siguiente bloque o cuando haya duda sobre el estado real del proyecto.

## Prompt

```text
Usa la Skill ENGREMIAT de estado y resume: estado actual, ultimo bloque cerrado, siguiente paso y riesgos.
```

## Como evaluar la respuesta

PASS si devuelve:

- Estado actual.
- Ultimo bloque cerrado.
- Siguiente paso coherente.
- Riesgos reales o ausencia razonada de riesgos.
- Sin inventar rutas ni bloques.

WARN si mezcla contexto antiguo pero ayuda.

FAIL si no recupera fuentes utiles o responde generico.

## Mantenimiento

Actualizar `01_ESTADO/ESTADO_ACTUAL.md` y `01_ESTADO/NEXT.md` al cerrar bloques importantes.
