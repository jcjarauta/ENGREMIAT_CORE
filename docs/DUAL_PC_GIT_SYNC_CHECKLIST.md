# DUAL PC GIT SYNC CHECKLIST

## Regla principal
Git es la fuente de verdad del codigo. ENGREMIAT_SHARED es puente de handoff, reportes, prompts y evidencia; no es un repo vivo.

## Antes de cambiar de PC
[ ] Cerrar el bloque activo
[ ] Crear o actualizar handoff
[ ] Revisar git status en modo lectura
[ ] Mantener un solo escritor activo
[ ] Copiar evidencia necesaria a ENGREMIAT_SHARED

## Al llegar al otro PC
[ ] Leer el handoff
[ ] Validar repo local
[ ] Confirmar rama y HEAD
[ ] Confirmar writer lock
[ ] No usar shared como repo

## Prohibiciones
[ ] No git add .
[ ] No fetch/pull/push automaticos
[ ] No editar codigo fuente dentro de ENGREMIAT_SHARED
[ ] No guardar secretos
[ ] No auto apply
