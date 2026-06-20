# HUMAN_USABLE_MVP_MANUAL

## Uso diario
1. Abrir `C:\ENGREMIAT_CORE`.
2. Ejecutar `.\eng.ps1 start` para abrir la pantalla inicial.
3. Ejecutar `.\eng.ps1 status` para ver estado.
4. Ejecutar `.\eng.ps1 next` para ver el siguiente paso.
5. Usar `.\eng.ps1 prompt` para preparar trabajo asistido.
6. Usar `.\eng.ps1 inbox` y `.\eng.ps1 review` para revisar propuestas.
7. Usar `.\tools\eng-decision.ps1 -Decision DEFER -Reason "motivo"` para registrar decision humana.

## Principio operativo
Cline/Ollama proponen; el humano decide; ENGREMIAT registra.

## Seguridad
No auto_apply, no remote_execution, no git_write, no red externa por defecto.

## Dashboards
- `dashboard/human-start/index.html`
- `dashboard/kanban-mvp/index.html`
- `dashboard/mvp-demo/index.html`
- `ENGREMIAT_MEMORY/dashboard/memory/index.html`
