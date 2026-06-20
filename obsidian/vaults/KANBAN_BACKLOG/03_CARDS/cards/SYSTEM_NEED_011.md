---
type: card
card_id: SYSTEM_NEED_011
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Module Registry navegable
system_area: bundles
priority: Alta
risk: MEDIUM
automation_level: ASSISTED
required_adapter: OBSIDIAN
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_011 · Module Registry navegable

## Descripcion

Transformar los 229 modulos oficializados en indices Obsidian por tipo, estado, capacidad, riesgo y reutilizacion.

## Clasificacion

- system_area: bundles
- priority: Alta
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: OBSIDIAN
- required_node: NONE
- related_skill: NONE

## Entrada

data/_OFFICIAL_MODULES y official-modules-index

## Salida esperada

MODULE_REGISTRY vault con vistas por familia y capacidad

## Validacion

validar conteos, modulos invalidos y enlaces

## Evidencia

official modules index

## Next

crear indice por familias
