# HUMAN_APPROVAL_READONLY_GUIDE

Objetivo: documentar una aprobacion humana limitada para la primera ejecucion Cline readonly.

Decision: APPROVE.
Human confirmation: true.

Autoriza solo:
- lanzar Cline para lectura/propuesta.
- devolver resumen.
- devolver riesgos.
- recomendar siguiente paso.

No autoriza:
- escribir archivos.
- modificar codigo.
- ejecutar comandos.
- auto_apply.
- git_write.
- commit.
- push/fetch/merge.
- inferencia remota.

Esta aprobacion solo vale para el request: 
REQ-FIRST-CLINE-READONLY-001

Cualquier accion adicional requiere otro gate humano separado.
