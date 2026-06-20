---
type: graph_view_filters
status: active
tags:
  - engremiat/graph
  - engremiat/navigation
---
# ENGREMIAT · Graph View Filters

## Objetivo
Evitar ruido visual de configuración técnica y dejar visible la estructura navegable.

## Filtro recomendado
`-path:.obsidian -path:_AUDIT_REVIEW -path:STUBS`

## Interpretación
- Oculta ficheros técnicos internos de Obsidian.
- Oculta notas auxiliares de auditoría.
- Mantiene HOME, índices normalizados, módulos, proyectos, canvas y nodos semánticos.

## Validación humana
Abrir Graph View y comprobar que desaparecen `app.json`, `appearance.json`, `graph.json`, `workspace.json` y similares.
