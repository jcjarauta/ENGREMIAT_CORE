# DAILY_OPERATIONAL_MANUAL

## ENGREMIAT post-MVP operational daily loop

Objetivo: usar ENGREMIAT cada dia como sistema local-first humano-maquina para revisar estado, inbox, decisiones, worker preview, dashboard operativo, Kanban preview y siguiente paso.

## Rutina base
1. Abrir terminal en `C:\ENGREMIAT_CORE`.
2. Ejecutar `.\eng.ps1 daily`.
3. Abrir `dashboard/operational/index.html`.
4. Revisar inbox operativo: `dashboard/operational-inbox/index.html`.
5. Revisar historial humano: `dashboard/decision-history/index.html`.
6. Revisar propuesta worker importada o sample: `data/worker-import-049/worker-proposal-sample.json`.
7. Ver Kanban bridge preview: `data/kanban-bridge-051/kanban-sync-preview.json`.
8. Revisar salida util diaria: `data/daily-production-052/production-output.json`.
9. Aplicar criterio humano: APPROVE, REPAIR, DEFER o REJECT.

## Comandos principales
- `.\eng.ps1 daily`
- `.\eng.ps1 status`
- `.\eng.ps1 next`
- `.\eng.ps1 inbox`
- `.\eng.ps1 review`
- `.\tools\eng-decision.ps1 -Decision DEFER -Reason "daily_review"`
- `.\tools\eng-operational-demo.ps1`

## Seguridad
- No auto_apply.
- No remote_execution.
- No git_write sin autorizacion.
- No red externa por defecto.
- Kanban es vista/control humano, no motor.
- Worker import no ejecuta worker ni aplica propuesta.
- Toda accion sensible requiere gate humano.

## Siguiente
E55_POST_MVP_CLOSE_AND_NEXT_RELEASE
