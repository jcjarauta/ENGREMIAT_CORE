# DUAL PC DEVELOPMENT WORKFLOW GUIDE

## Objetivo
Permitir que el humano pueda desarrollar desde dos PCs sin romper trazabilidad, repo ni autoridad de escritura.

## Roles
- PC actual: preparacion, revision, dashboards, handoff, trabajo ligero.
- MAIN-PC: Cline real, Ollama, GPU, workers pesados y vinculacion real cuando toque.
- ENGREMIAT_SHARED: puente de handoff, reports, prompts y evidencias.
- Git: fuente de verdad del codigo.

## Regla principal
Solo un PC escritor activo por objetivo o bloque.

## Desde PC actual
Puedes preparar policies, reports, dashboards, handoff y readiness. No debes lanzar Cline/Ollama reales ni tocar MAIN-PC.

## Desde MAIN-PC
Cuando se indique explicitamente, validar repo local, leer handoff y ejecutar readiness antes de Cline/Ollama.

## Prohibiciones
No usar shared como repo vivo. No guardar secretos. No git remoto automatico. No auto-apply. No dos PCs escribiendo a la vez.

## Siguiente
Cerrar E06 y decidir si se continua en PC actual o se vuelve a MAIN-PC para vinculacion real.
