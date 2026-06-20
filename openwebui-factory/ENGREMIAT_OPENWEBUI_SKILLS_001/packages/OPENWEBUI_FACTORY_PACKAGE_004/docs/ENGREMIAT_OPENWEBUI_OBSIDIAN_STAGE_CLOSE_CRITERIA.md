# ENGREMIAT_OPENWEBUI_OBSIDIAN_STAGE_CLOSE_CRITERIA

## Criterio de cierre
La etapa puede cerrarse cuando Package 004 responda correctamente a: estado con cápsula, estado sin cápsula, gate explícito y roadmap B12/B13.

## PASS mínimo
- Con STATE_CAPSULE: status=PASS, estado_actual correcto, último bloque correcto, siguiente paso correcto, riesgos correctos, gate_required=False.
- Sin STATE_CAPSULE: status=WARN, pide evidencia y no inventa.
- Gate: calcula False cuando no hay escritura real.
- Roadmap: después de B12 propone B13_IMPORT_PACKAGE_004_AND_FINAL_MANUAL_VALIDATION.

## Decisión tras cierre
Solo tras B13 se valora añadir nuevas funcionalidades.
