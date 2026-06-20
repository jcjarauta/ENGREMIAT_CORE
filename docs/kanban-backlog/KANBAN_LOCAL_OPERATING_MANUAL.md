# KANBAN_LOCAL_OPERATING_MANUAL

## Modelo operativo confirmado
El backlog real de ENGREMIAT_CORE vive en archivos markdown dentro de docs/kanban-backlog. Cline/Kanban funciona como panel humano de lectura, ejecucion controlada y revision, no como almacenamiento principal del backlog.

## Fuente de verdad
- Fuente principal: docs/kanban-backlog/*.md
- Indice principal: docs/kanban-backlog/INDEX.md
- Manifiesto: docs/kanban-backlog/kanban-local-backlog-manifest.json
- Kanban/Cline: interfaz de lectura, decision, ejecucion controlada y Review.

## Regla principal
No usar + Create task como almacenamiento principal de tarjetas. Usarlo solo para pedir a Cline que lea una tarjeta local, revise, proponga o ejecute bajo gate explicito.

## Formato minimo de tarjeta local
Cada tarjeta markdown debe incluir:
- H1 con ID estable.
- Titulo.
- Estado.
- Tipo.
- Riesgo.
- Agente.
- Objetivo.
- Reglas.
- Criterio de exito.

## Flujo humano-maquina
1. Crear o actualizar tarjeta local markdown.
2. Registrar la tarjeta en INDEX.md.
3. Pedir a Cline/Kanban que lea la tarjeta.
4. Cline responde en Review.
5. Humano valida PASS, WARN o NO_GO.
6. Solo con autorizacion explicita se permite modificar archivos o ejecutar comandos.

## Estados recomendados
- BACKLOG: tarjeta pendiente.
- READY: lista para lectura/revision.
- IN_REVIEW: revisada por Cline/Kanban.
- APPROVED_FOR_EXECUTION: autorizada explicitamente por humano.
- DONE: cerrada con evidencia.
- NO_GO: bloqueada.

## Seguridad
Por defecto todas las tarjetas son readonly-first. Ninguna tarea debe modificar archivos, ejecutar comandos, usar herramientas externas o aplicar cambios si la tarjeta no lo autoriza explicitamente.

## Decision actual
KANBAN_LOCAL_BACKLOG_READY_FOR_OPERATION
