---
type: manual_test
skill_id: SKILL_ESTADO_ENGREMIAT
project: ENGREMIAT_OPENWEBUI_SKILLS_001
status: READY
---
# TEST MANUAL · SKILL ESTADO ENGREMIAT

## Objetivo

Comprobar que OpenWebUI puede recuperar el estado ENGREMIAT desde Markdown normalizado y devolver una respuesta compacta.

## Preparacion

1. Asegurar que OpenWebUI tiene acceso a la Knowledge Base Markdown.
2. Incluir como minimo HOME, ESTADO_ACTUAL, NEXT, MASTER_INDEX y SKILL_ESTADO_ENGREMIAT_TEMPLATE.
3. Ejecutar el prompt de prueba.

## Prompt de prueba

```text
Usa la Skill ENGREMIAT de estado y resume: estado actual, ultimo bloque cerrado, siguiente paso y riesgos.
```

## Criterios PASS

- Devuelve estado actual.
- Identifica ultimo bloque cerrado.
- Propone siguiente paso coherente.
- Lista riesgos reales o indica que no detecta riesgos.
- No inventa rutas ni bloques.

## Criterios WARN

- Recupera fuentes pero mezcla contexto antiguo.
- El siguiente paso es razonable pero incompleto.

## Criterios FAIL

- No recupera fuentes utiles.
- Inventa estado.
- Da una respuesta generica sin usar Markdown.
