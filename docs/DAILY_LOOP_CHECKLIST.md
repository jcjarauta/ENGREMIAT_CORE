# DAILY_LOOP_CHECKLIST

## Checklist diario rapido

- [ ] Terminal en `C:\ENGREMIAT_CORE`.
- [ ] Ejecutar `.\eng.ps1 daily`.
- [ ] Abrir `dashboard/operational/index.html`.
- [ ] Revisar inbox operativo.
- [ ] Revisar historial de decisiones.
- [ ] Revisar propuesta worker/import preview.
- [ ] Revisar salida util diaria E52.
- [ ] Confirmar que Kanban sigue preview_only si no hay gate.
- [ ] Registrar decision humana si procede.
- [ ] Ver siguiente paso con `.\eng.ps1 next`.

## Decision segura por defecto
`.\tools\eng-decision.ps1 -Decision DEFER -Reason "daily_review_pending"`

## Criterio NO_GO
- Falta evidencia critica.
- Hay auto_apply no autorizado.
- Hay remote_execution no autorizada.
- Hay git_write no autorizado.
- No existe rollback/postcheck para accion sensible.
