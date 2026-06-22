# MCARD eng-context router integration fail

- screen_id: ENG_CONTEXT_PROJECTS_ACTIVE
- route: PROYECTOS ACTIVOS
- severity: HIGH
- expected: encabezados/ruta/comandos comunes visibles y funcionales: Enter, b/q, m, ?
- observed: no salen encabezados ni rutas y los comandos no van tras aplicar footer al final de eng-context.ps1
- action_done: E12 aplico candidato E11; E13 manual detecto que la pantalla real tiene router propio y no integra footer
- status: OPEN
- next: preparar auditoria del router real de PROYECTOS ACTIVOS antes de parchear

## Nota
No migrar por append final. Hay que localizar el Read-Host/router real de la pantalla y reescribir esa frontera concreta.
