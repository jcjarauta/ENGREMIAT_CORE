# DUAL PC GIT SYNC CHECKLIST

## Regla principal
Git es la fuente de verdad del codigo. ENGREMIAT_SHARED es puente de contexto/evidencias, no repo vivo.

## Antes de cambiar de PC
[ ] Cerrar o pausar el bloque activo.
[ ] Crear/actualizar handoff.
[ ] Revisar git status local en modo lectura.
[ ] No dejar dos PCs como escritores activos.
[ ] Copiar reports/evidence/handoff a ENGREMIAT_SHARED si procede.

## Al llegar al otro PC
[ ] Leer handoff.
[ ] Validar repo local.
[ ] Confirmar rama y HEAD.
[ ] Confirmar writer lock.
[ ] No usar carpeta compartida como repo.
[ ] No ejecutar fetch/pull/push/merge automaticamente.

## Prohibiciones
[ ] No git add .
[ ] No push automatico.
[ ] No fetch/pull automatico en este objetivo.
[ ] No editar codigo fuente dentro de ENGREMIAT_SHARED.
[ ] No guardar secretos en shared.

## Decision
Solo pasar a escritura si readiness local es GO y hay un unico PC escritor activo.
