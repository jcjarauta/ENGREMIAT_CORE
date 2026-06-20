# KB002_BACKLOG_INDEX_REVIEW

Titulo: Revisar indice de backlog local
Estado: IN_REVIEW
Tipo: KANBAN_LOCAL_CARD
Riesgo: LOW
Agente: CLINE_READONLY_FIRST

## Objetivo
Comprobar que el backlog local tiene estructura legible para operacion humana desde Kanban.

## Reglas
- No modificar archivos salvo autorizacion explicita.
- No ejecutar comandos salvo autorizacion explicita.
- No usar herramientas externas.
- Primero leer y resumir.
- Si propone cambios, dejarlos como propuesta.

## Criterio minimo de estructura legible
Para considerar valido el backlog local, INDEX.md debe listar tarjetas con ID y titulo, el manifiesto debe coincidir con esas tarjetas y cada tarjeta markdown debe incluir H1, Titulo, Estado, Tipo, Riesgo, Agente, Objetivo, Reglas y Criterio de exito.

## Criterio de exito
Cline identifica tarjetas disponibles, verifica coherencia entre INDEX.md y el manifiesto, valida el formato minimo de tarjeta y recomienda la siguiente tarjeta.

## Resultado de revision
PASS. Backlog local markdown usable como fuente de verdad. Siguiente recomendada: KB003_DEV_SYSTEM_NEXT_STEP.
