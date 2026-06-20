---
type: architecture_content_map
module_id: 
MODULE_arquitectura_global_engremiat
status: defined
tags:
  - engremiat/architecture
  - engremiat/module
  - engremiat/system
---
# Arquitectura Global ENGREMIAT - Mapa de contenido

## Capas

### 
L01_CORE
 - 
Core local
Identidad, contratos, estado, eventos, memoria y reglas base.

### 
L02_HUMAN_CONTROL
 - 
Control humano
Superficies de decision, gates, dashboards y validacion humana.

### 
L03_VISUAL_MEMORY
 - 
Memoria visual Obsidian
Bovedas, grafos, grupos, vistas, indices y relaciones navegables.

### 
L04_PROJECT_MODULE_BUILDER
 - 
Builder de proyectos y modulos
Crear espacios gobernados para proyectos, modulos y superficies.

### 
L05_WORKER_LOOP
 - 
Loop de workers
Preparar ejecucion asistida futura sin activarla por defecto.

### 
L06_EVIDENCE_REPORTING
 - 
Evidencia y reportes
Trazabilidad, dashboards, manifestos, auditorias y cierres.

## Fronteras
- **B01_NO_EXECUTION_BY_DEFAULT**: Nada ejecuta workers sin autorizacion explicita.
- **B02_OBSIDIAN_IS_VISUAL_MEMORY**: Obsidian organiza y visualiza; no es motor de ejecucion.
- **B03_CANONICAL_DATA_OUTSIDE_OBSIDIAN**: Datos canonicos siguen en data/reports/dashboard/docs; Obsidian enlaza y explica.
- **B04_MODULES_REQUIRE_INDEX_AND_GROUP**: Todo modulo necesita indice, grupo, vista, evidencia y estado.

## Flujos
- **F01_HUMAN_PROJECT_TO_ROADMAP**: Humano propone proyecto -> sistema propone roadmap -> humano aprueba.
- **F02_ROADMAP_TO_MODULE_SPACE**: Roadmap aprobado -> builder crea modulo/espacio de trabajo.
- **F03_MODULE_TO_WORKER_PACKET**: Modulo estructurado -> paquete controlado para worker futuro.
- **F04_EVIDENCE_TO_MEMORY**: Resultado/evidencia -> reporte canonico -> nota Obsidian -> grafo.

## Decisiones
- **D01_BOVEDA_MASTER_ADOPTED**: BOVEDA_ENGREMIAT_MASTER queda como base operativa visual.
- **D02_FIRST_MODULE_ADOPTED**: MODULE_arquitectura_global_engremiat queda como primer modulo oficial preview.
- **D03_PREVIEW_ONLY**: Contenido actual sin ejecucion real, sin git, sin red externa.

## Notas relacionadas
- [[01_ARQUITECTURA/ARCHITECTURE_BOUNDARIES]]
- [[01_ARQUITECTURA/ARCHITECTURE_FLOWS]]
- [[01_ARQUITECTURA/ARCHITECTURE_DECISIONS]]
- [[ARCHITECTURE_GLOBAL_CANVAS.canvas]]

## Contrato del modulo
- [[MODULE_CONTRACT]]

