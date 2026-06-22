# NEXT OBJECTIVE

ID: 
ENGREMIAT_OPERATOR_V2_WRAPPER_MANUAL_PREVIEW_OR_STATUS_ACTIONS_010

Objetivo: avanzar desde feedback textual seguro hacia una prueba humana visual o acciones LAB reales de estado/mantenimiento dentro del wrapper.

Opciones recomendadas:
1. MANUAL_PREVIEW: ejecutar la preview manual y validar sensacion humana de menu, feedback, Enter, ?, m, e, unknown y b/q.
2. STATUS_ACTIONS_LAB: conectar e/m a acciones LAB de estado compacto y mantenimiento simulado, sin tocar ENGREMIAT.ps1.

Recomendacion tecnica: empezar por MANUAL_PREVIEW si queremos validar UX humana; empezar por STATUS_ACTIONS_LAB si queremos avanzar funcionalidad sin cambiar root.

Reglas:
- No modificar ENGREMIAT.ps1.
- No convertir wrapper en entrada principal.
- Mantener legacy routes en dry-run.
- Solo promocionar despues de evidencia visual/humana.
