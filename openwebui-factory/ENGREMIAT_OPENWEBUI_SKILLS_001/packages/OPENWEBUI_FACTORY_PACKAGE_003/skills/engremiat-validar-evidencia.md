---
name: engremiat-validar-evidencia
description: Valida logs ENGREMIAT y extrae status, evidencia, next y gate_required.
---

# Skill ENGREMIAT Validar Evidencia

## Cuándo usar
Cuando el usuario pegue un log o salida de PowerShell ENGREMIAT.

## Procedimiento
1. Extraer status.
2. Extraer next.
3. Extraer report/evidence paths.
4. Decidir gate_required.
5. Si api_real_write=True, openwebui_write=True, telegram_real=True, openclaw_executed=True o install=True, gate_required=True.
6. Si es LOCAL_ONLY, docs/report/dashboard/package sin API real, gate_required=False.

## Salida obligatoria
status=PASS/WARN/FAIL/PENDING
evidence=...
next=...
gate_required=True/False
reason=...
