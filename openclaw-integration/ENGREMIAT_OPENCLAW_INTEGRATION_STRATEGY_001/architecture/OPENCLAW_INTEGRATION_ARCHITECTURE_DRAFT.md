# OPENCLAW INTEGRATION ARCHITECTURE DRAFT

## Arquitectura conceptual

```text
Obsidian
  -> conocimiento curado, decisiones, skill-candidates
Open WebUI
  -> consulta RAG local FAST/FULL
Ollama
  -> modelo local
OpenClaw
  -> futura capa agente/gateway gobernada
Telegram
  -> futura UX guiada
Backend ENGREMIAT
  -> estado, tareas, evidencias, contratos
```

## Flujo inicial recomendado
1. Obsidian documenta rol y limites.
2. Open WebUI consulta estrategia.
3. OpenClaw se evalua solo como laboratorio READ_ONLY.
4. El humano valida utilidad.
5. Solo despues se decide si OpenClaw va antes o despues de Skills.

## Pregunta de diseño
OpenClaw debe ser router, asistente, gateway, agente de accion o solo conector? La decision queda pendiente hasta evaluar el laboratorio read-only.
