---
type: card
card_id: SYSTEM_NEED_003
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Autoanalisis de backlog
system_area: kanban
priority: Alta
risk: MEDIUM
automation_level: SEMI_AUTOMATED
required_adapter: POWERSHELL
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_003 · Autoanalisis de backlog

## Descripcion

Crear un flujo que detecte necesidades nuevas, tarjetas obsoletas y candidatos de automatizacion sin aplicar cambios reales.

## Clasificacion

- system_area: kanban
- priority: Alta
- risk: MEDIUM
- automation_level: SEMI_AUTOMATED
- required_adapter: POWERSHELL
- required_node: NONE
- related_skill: NONE

## Entrada

reports recientes, gates, errores, bundles y estados

## Salida esperada

DETECTED_NEEDS, STALE_CARDS y REFRESH_PROPOSAL

## Validacion

ejecutar solo en modo propuesta y validar con gate humano

## Evidencia

AUTOANALYSIS_REPORT

## Next

crear refresh controlado
