# Contrato local: heartbeat -> proyecto -> terminal -> Obsidian

Fecha: 2026-06-20T10:36:31

## Idea
El heartbeat es el pulso vivo del sistema. No ejecuta nada: solo informa del estado de workers, tareas y proyectos.

## Capas
1. Heartbeat: señal atomica del worker.
2. Project-signal: resumen operativo por proyecto.
3. Terminal UX: tabla viva para supervision humana.
4. Obsidian sync: Markdown/YAML para grafo, relaciones y memoria visual.

## Estados canonicos
- IDLE
- QUEUED
- RUNNING
- WAITING_HUMAN
- BLOCKED
- DONE
- ERROR

## Campos minimos heartbeat
- project_id
- worker_id
- task_id
- state
- phase
- current_step
- progress_pct
- blocked_reason
- next_action
- evidence_path
- heartbeat_at
- expires_at

## Relacion con Obsidian
Cada señal puede materializar nodos Markdown con YAML: Project, Worker, Task y Signal. Obsidian no decide ni ejecuta; representa y permite navegar el estado.

## Siguiente
E64_CREATE_HEARTBEAT_OBSIDIAN_SYNC_DRY_RUN: generar señales demo y exportarlas a Markdown/YAML local.
