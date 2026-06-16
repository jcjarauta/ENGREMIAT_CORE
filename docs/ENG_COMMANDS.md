# ENG_COMMANDS

## Visual Memory Operative
- `.\eng.ps1 memory` — alias de estado resumido.
- `.\eng.ps1 memory-status` — muestra objetivo, etapa, readiness, eventos, gates, artefactos y next.
- `.\eng.ps1 memory-sync` — escanea evidencias, crea eventos, sincroniza notas, mapas y dashboard data.
- `.\eng.ps1 memory-dashboard` — genera y abre dashboard visual local.
- `.\eng.ps1 memory-graph` — actualiza/consulta estado básico de nodes.jsonl y edges.jsonl.

## Flujo recomendado
1. Ejecutar bloque de desarrollo.
2. Ejecutar `.\eng.ps1 memory-sync`.
3. Ejecutar `.\eng.ps1 memory-dashboard`.
4. Decidir siguiente paso desde dashboard.

# PROMPT FACTORY COMMANDS

## Comandos Prompt Factory
- `.\eng.ps1 prompt-status` — muestra estado del outbox, prompt activo y next-step.
- `.\eng.ps1 prompt-next` — reconstruye contexto, genera PROMPT_NEXT y lo publica en `prompts/outbox/ACTIVE_PROMPT.md`.
- `.\eng.ps1 prompt-repair` — detecta último ERR/NO_GO, genera PROMPT_REPAIR y lo publica.
- `.\eng.ps1 prompt-open` — abre el prompt activo para copiar o entregar a Cline/Ollama.
- `.\eng.ps1 prompt-inbox` — importa respuestas de `prompts/inbox` sin aplicar cambios.

## Flujo recomendado
1. `.\eng.ps1 prompt-status`
2. `.\eng.ps1 prompt-next`
3. `.\eng.ps1 prompt-open`
4. Entregar `ACTIVE_PROMPT.md` a Cline/Ollama.
5. Guardar respuesta en `prompts/inbox`.
6. `.\eng.ps1 prompt-inbox`
7. Revisar reporte antes de aplicar nada.

## Límites
No ejecuta worker real, no usa navegador, no usa red externa, no hace commit, no hace push y no aplica cambios sensibles.
