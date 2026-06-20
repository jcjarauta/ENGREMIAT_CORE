---
type: card
card_id: SYSTEM_NEED_021
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Control de un solo escritor
system_area: nodes
priority: Alta
risk: HIGH
automation_level: ASSISTED
required_adapter: OBSIDIAN
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_021 · Control de un solo escritor

## Descripcion

Registrar que solo un PC o nodo escribe por objetivo o bloque para evitar conflictos entre MAIN-PC, old-pc y carpetas compartidas.

## Clasificacion

- system_area: nodes
- priority: Alta
- risk: HIGH
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

manuales main-pc linking y node-link

## Salida esperada

policy de escritor activo y handoff seguro

## Validacion

validar writer activo antes de acciones reales

## Evidencia

node-link reports

## Next

crear ficha de nodos
