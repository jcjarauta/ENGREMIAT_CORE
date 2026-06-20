# Modelo canonico UX: tablas y procesos en terminal

Fecha: 2026-06-20T10:33:21

## Objetivo
Pasar de listados simples a pantallas operativas que permitan ver trabajo, madurez, bloqueos y actividad de workers.

## Tabla canonica
Columnas base:
- N: numero local de fila.
- NOMBRE: entidad o proyecto.
- FASE: etapa detectada o estado dominante.
- PROGRESO: barra visual + porcentaje/estado.
- WORKER: IDLE/RUN/WAIT/BLOCK/DONE/ERR.
- BLOQ: OK/WARN/BLOCK.
- NEXT: siguiente accion humana o automatizable.

## Progreso visual
Ejemplos:
- [####------] 40%
- [####>-----] RUN
- [!!!!------] BLOCK
- [##########] DONE

## Proceso en pantalla
Cada pantalla de proceso debe tener:
1. Header canonico.
2. Resumen agregado.
3. Tabla operativa.
4. Detalle seleccionable.
5. Acciones locales.
6. Enter para refrescar.

## Workers en tiempo real
Fase actual: señales locales por reports, locks y ultima actividad.
Fase posterior: eventos worker JSONL/DB con heartbeat, task_id, current_step y blocked_reason.

## Siguiente
E61_APPLY_TABLE_PROCESS_UX_TO_PROJECTS_VIEW.
