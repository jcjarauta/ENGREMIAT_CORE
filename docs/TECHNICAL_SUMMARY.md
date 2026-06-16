# TECHNICAL_SUMMARY — ENGREMIAT_CORE_MVP_001

## Arquitectura técnica

- JSON/JSONL como formato canónico.
- Ledger append-only en `data/events/events.jsonl`.
- Estado derivado en `data/state/`.
- Evidencia en `evidence/` y `data/evidence/`.
- Documentación en `docs/`.
- Reportes y Mermaid en `reports/`.

## Ciclo validado

project/task → matching → offer → policy → lease → simulated execution → evidence → verification → close → digital twin → manifest.

## Seguridad

Todo el cierre es LOCAL_ONLY: no red, no Git, no ejecución remota, no sistemas externos.
