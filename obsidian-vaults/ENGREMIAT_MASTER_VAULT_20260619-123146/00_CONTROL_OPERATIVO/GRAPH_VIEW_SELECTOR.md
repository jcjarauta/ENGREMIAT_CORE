---
type: graph_view_selector
status: active
tags:
  - engremiat/graph
  - engremiat/navigation
  - engremiat/control
---
# ENGREMIAT - Selector de vistas del grafo

## IMPORTANTE
No usar filtros `file:` porque Obsidian puede abrir enlaces externos `file://`. Usar solo `path:` y `tag:`.

## Uso
Copia el filtro de la vista que quieras y pegalo en el buscador de Graph View.

## Vista recomendada inicial
Filtro: 
-path:.obsidian -path:_AUDIT_REVIEW -path:STUBS -path:app.json -path:appearance.json -path:graph.json -path:workspace.json

## Vistas disponibles

### 
VIEW_CLEAN_GENERAL
 - 
Vista limpia general
Filtro: 
-path:.obsidian -path:_AUDIT_REVIEW -path:STUBS -path:app.json -path:appearance.json -path:graph.json -path:workspace.json

### 
VIEW_NAVIGATION
 - 
Navegacion
Filtro: 
path:HOME OR path:GRAPH_NAVIGATION_MAP OR path:GRAPH_VIEW_SELECTOR OR tag:#engremiat/navigation

### 
VIEW_SYSTEM
 - 
Sistema
Filtro: 
path:01_SISTEMA_ENGREMIAT OR tag:#engremiat/system

### 
VIEW_CONTROL
 - 
Control y gates
Filtro: 
path:00_CONTROL_OPERATIVO OR path:04_GATES_DECISIONES OR tag:#engremiat/control

### 
VIEW_PROJECTS
 - 
Proyectos
Filtro: 
path:02_PROYECTOS OR path:PROJECT_INDEX OR tag:#engremiat/project

### 
VIEW_MODULES
 - 
Modulos
Filtro: 
path:03_MODULOS OR path:MODULE_INDEX OR tag:#engremiat/module

### 
VIEW_WORKERS
 - 
Workers
Filtro: 
path:06_WORKERS OR tag:#engremiat/worker

### 
VIEW_EVIDENCE
 - 
Evidencias
Filtro: 
path:05_EVIDENCIAS OR tag:#engremiat/evidence

### 
VIEW_GRAPH_CANVAS
 - 
Grafo y canvas
Filtro: 
path:07_OBSIDIAN_GRAPH OR path:MASTER_GROUPED_CANVAS.canvas OR tag:#engremiat/graph

## Grupos oficiales de color

### 
G00_HOME_NAV
 - 
Home y navegacion
Query: 
path:HOME OR path:GRAPH_NAVIGATION_MAP OR path:GRAPH_VIEW_SELECTOR OR tag:#engremiat/navigation

### 
G01_CORE
 - 
Sistema Engremiat
Query: 
path:01_SISTEMA_ENGREMIAT OR tag:#engremiat/system OR tag:#engremiat/home

### 
G02_CONTROL
 - 
Control operativo
Query: 
path:00_CONTROL_OPERATIVO OR path:04_GATES_DECISIONES OR tag:#engremiat/control

### 
G03_PROJECTS
 - 
Proyectos
Query: 
path:02_PROYECTOS OR path:PROJECT_INDEX OR tag:#engremiat/project

### 
G04_MODULES
 - 
Modulos
Query: 
path:03_MODULOS OR path:MODULE_INDEX OR tag:#engremiat/module

### 
G05_WORKERS
 - 
Workers
Query: 
path:06_WORKERS OR tag:#engremiat/worker

### 
G06_EVIDENCE
 - 
Evidencias
Query: 
path:05_EVIDENCIAS OR tag:#engremiat/evidence

### 
G07_GRAPH_CANVAS
 - 
Grafo y canvas
Query: 
path:07_OBSIDIAN_GRAPH OR path:MASTER_GROUPED_CANVAS.canvas OR tag:#engremiat/graph

### 
G08_SURFACES
 - 
Superficies de trabajo
Query: 
path:10_SUPERFICIES_TRABAJO OR path:WORK_SURFACE_INDEX OR tag:#engremiat/work-surface

## Validacion manual de grupos
Si el panel Grupos aparece vacio, cierra y reabre la boveda para que Obsidian recargue `.obsidian/graph.json`.

## Referencia auxiliar
- [[00_CONTROL_OPERATIVO/GRAPH_GROUPS_MANUAL_APPLY]]

