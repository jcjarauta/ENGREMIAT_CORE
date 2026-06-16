# WORKER_HANDOFF

## Uso manual con Cline/Ollama
1. Ejecutar o generar prompt con Prompt Factory.
2. Publicar prompt en outbox.
3. Abrir `prompts/outbox/ACTIVE_PROMPT.md`.
4. Entregar ese contenido al worker local.
5. Guardar la respuesta del worker en `prompts/inbox/`.
6. Ejecutar importación de respuesta.
7. Revisar reporte antes de aplicar nada.

## Comandos esperados
- `.\eng.ps1 prompt-next`
- `.\eng.ps1 prompt-repair`
- `.\eng.ps1 prompt-open`

## Límites
No hay ejecución automática de Cline/Ollama en esta etapa. No hay apply, commit, push ni red externa.
