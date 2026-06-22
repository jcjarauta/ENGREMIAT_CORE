# DETAIL VIEWER READONLY v1

## Script
tools/operator-v1/operator-v1-detail-viewer-readonly.ps1

## Proposito
Visor comun para mostrar detalle seguro de elementos seleccionados desde pantallas V1.

## Politica
- Mode: READONLY
- No abre archivos externos
- No ejecuta scripts
- No modifica archivos
- No usa clipboard
- No usa navegador
- No usa red/API externa

## Smoke
- Screen: 
OPERATOR_V1_DETAIL_VIEWER_READONLY
- Path exists: 
True
- Path inside root: 
True

## NEXT
E05_INTEGRATE_PROJECTS_ACTIONS_READONLY
