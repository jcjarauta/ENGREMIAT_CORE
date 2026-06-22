# MCARD projects screen template gap

- screen_id: PROJECTS
- route: INICIO > Proyectos
- severity: HIGH
- expected: pantalla PROYECTOS debe cumplir plantilla master: Enter, b/q, m, ? y ruta visible
- observed: pantalla muestra ruta y b/Enter, pero no m, ?, q; no corresponde a PROYECTOS ACTIVOS ya parcheada
- action_done: E19 prueba manual tras E18
- status: OPEN
- next: auditar renderer real de PROYECTOS y preparar parche NO_APPLY
