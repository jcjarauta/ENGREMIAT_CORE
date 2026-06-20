# MVP_DEMO_CHECKLIST

## Demo de 10 minutos

1. Ejecutar `.\eng.ps1 start` y abrir pantalla humana.
2. Ejecutar `.\eng.ps1 status` y `.\eng.ps1 next`.
3. Ejecutar `.\eng.ps1 prompt` para mostrar worker asistido sin envio.
4. Ejecutar `.\tools\eng-decision.ps1 -Decision DEFER -Reason demo_safe_defer`.
5. Abrir `dashboard/kanban-mvp/index.html` y verificar que Kanban es VIEW_ONLY.
6. Abrir `ENGREMIAT_MEMORY/dashboard/memory/index.html`.
7. Abrir `dashboard/mvp-demo/index.html`.

## Reglas
- No auto_apply.
- No remote_execution.
- No git_write.
- No red externa.
- El humano conserva decision final.

## Resultado esperado
Demo completa, reproducible y trazable para explicar el MVP humano-maquina.
