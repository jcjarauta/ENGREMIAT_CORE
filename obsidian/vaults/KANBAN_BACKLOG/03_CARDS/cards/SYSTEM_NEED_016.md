---
type: card
card_id: SYSTEM_NEED_016
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Evidence First universal
system_area: core
priority: Alta
risk: LOW
automation_level: ASSISTED
required_adapter: POWERSHELL
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_016 · Evidence First universal

## Descripcion

Garantizar que todo cierre tenga report, manifest, receipt, checksum o evidencia verificable.

## Clasificacion

- system_area: core
- priority: Alta
- risk: LOW
- automation_level: ASSISTED
- required_adapter: POWERSHELL
- required_node: NONE
- related_skill: NONE

## Entrada

reports, manifests y receipts

## Salida esperada

indice de evidencias por objetivo y bloque

## Validacion

validar presencia de artefactos minimos antes de PASS

## Evidencia

evidence indexes

## Next

crear validador de evidencia
