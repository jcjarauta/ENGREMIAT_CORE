---
type: card
card_id: SYSTEM_NEED_024
card_group: SYSTEM_NEEDS
card_type: FUNCTION_OR_NEED_CANDIDATE
status: 
ACTIVE
title: Errores recurrentes PowerShell
system_area: core
priority: Alta
risk: MEDIUM
automation_level: ASSISTED
required_adapter: POWERSHELL
required_node: NONE
related_skill: NONE
requires_human: true
source: system-needs-25-import-template.tsv
tags: [kanban/system_need, autoanalysis/candidate, status/active]
---
# SYSTEM_NEED_024 · Errores recurrentes PowerShell

## Descripcion

Mantener memoria de errores y reglas preventivas para scripts PowerShell, Git y JSON.

## Clasificacion

- system_area: core
- priority: Alta
- risk: MEDIUM
- automation_level: ASSISTED
- required_adapter: POWERSHELL
- required_node: NONE
- related_skill: NONE

## Entrada

errores previos y playbooks

## Salida esperada

ERROR_PLAYBOOK actualizado y reglas activas

## Validacion

validar que nuevos scripts respetan reglas preventivas

## Evidencia

error memory reports

## Next

actualizar playbook
