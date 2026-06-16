# FIRST_GATED_EXECUTION_GUIDE

Objetivo: preparar la primera ejecucion real de worker, pero en modo no destructivo.

Worker previsto:
- Cline CLI local en OLD-PC.

Accion permitida:
- READONLY_ANALYSIS_AND_PROPOSAL.

Permitido:
- leer el request
- analizar contexto
- devolver propuesta textual
- listar riesgos
- recomendar siguiente paso

Bloqueado:
- escribir archivos
- modificar codigo
- ejecutar comandos
- instalar paquetes
- auto_apply
- git_write
- commit
- push/fetch/merge
- inferencia remota
- Ollama generate/chat

Estado actual:
- preparado, no ejecutado.

Siguiente: crear gate humano APPROVE limitado en E02.
