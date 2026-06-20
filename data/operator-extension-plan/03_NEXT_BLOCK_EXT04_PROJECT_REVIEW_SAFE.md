# 03 SIGUIENTE BLOQUE RECOMENDADO

## EXT04_PROJECT_REVIEW_SAFE

Objetivo: crear eng-review-project-safe.ps1, un diagnóstico readonly del proyecto activo.

Debe comprobar:
- active_project existe.
- BOVEDA_PROYECTO existe.
- 00_PLANTILLA_MAESTRA_OFICIAL existe y tiene archivos.
- MODULOS/MODULE_inicio existe.
- module.json existe.
- template-source.json existe.
- operator-state coherente.
- navegación congelada sigue válida.

Resultado esperado: reporte JSON + pantalla compacta PASS/WARN.

No debe modificar el operador ni el proyecto.
