---
type: card
card_id: SYSTEM_NEED_019
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Grafo de relaciones
system_area: visual_memory
priority: Media
risk: MEDIUM
automation_level: SEMI_AUTOMATED
required_adapter: POWERSHELL
required_node: MAIN_PC
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_019 · Grafo de relaciones

## Descripcion

Crear una vision relacional entre proyectos, tarjetas, modulos, skills, bundles, gates, workers y evidencias.

## Clasificacion

- system_area: visual_memory
- priority: Media
- risk: MEDIUM
- automation_level: SEMI_AUTOMATED
- required_adapter: POWERSHELL
- required_node: MAIN_PC
- related_skill: NONE

## Entrada

indices Obsidian y registros JSON

## Salida esperada

nodes, edges y mapa grafico local

## Validacion

validar nodos huerfanos y relaciones basicas

## Evidencia

graph export reports

## Next

generar grafo local
