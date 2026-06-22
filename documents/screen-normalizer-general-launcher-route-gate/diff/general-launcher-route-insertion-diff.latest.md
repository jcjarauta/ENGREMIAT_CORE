# DIFF PREVISTO - NO APLICADO

package: ENGREMIAT_SCREEN_NORMALIZER_GENERAL_LAUNCHER_ROUTE_GATE_001
stage: E02B_PREPARE_ROUTE_INSERTION_DIFF_STABLE_NO_APPLY
created_at: 2026-06-20T18:48:31

launcher_real: C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
planned_candidate: C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-route-gate\diff\ENGREMIAT-LAUNCHER-ACTUAL.route-adapter-planned-stable-20260620-184831.ps1
adapter: C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1
proposed_option: 9

## Cambio estable propuesto
En vez de reescribir el switch automaticamente, se prepara una funcion segura al final del launcher candidato:

``powershell


# ENGREMIAT_ROUTE_GATE_PLANNED_BEGIN
# Planned route only. This candidate is NOT applied to the real launcher.
# Human route: Adapter subpantallas normalizadas.
function Invoke-EngremiatSubscreenRoutingAdapter {
  & powershell -NoProfile -ExecutionPolicy Bypass -File 'C:\ENGREMIAT_CORE\documents\screen-normalizer-subscreen-routing-adapter\adapter\ENGREMIAT-SUBSCREEN-ROUTING-ADAPTER.isolated.ps1'
}
# Proposed menu option: [9] Adapter subpantallas normalizadas
# Integration note: wire this function into the launcher menu/switch after explicit apply authorization.
# ENGREMIAT_ROUTE_GATE_PLANNED_END
``

## Backup previsto
- Antes de aplicar: copiar C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1 a carpeta backup con timestamp.

## Rollback previsto
- Si parse falla tras aplicar: restaurar backup inmediatamente.
- Si smoke visual falla: preparar rollback gate.

## Nota
- Este paso NO aplica nada. Solo deja candidato compilable y diff textual.