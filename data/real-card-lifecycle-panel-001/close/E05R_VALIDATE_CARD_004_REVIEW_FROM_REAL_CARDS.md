# E05R · Validate CARD-004 REVIEW from real cards

## Decisión

```text
REAL_CARD_LIFECYCLE_PANEL_CARD_004_REVIEW_GO
```

## Reparación

La validación anterior leía el JSON como colección agregada. Esta versión reconstruye dashboard y lifecycle desde las cards Markdown/YAML reales y valida CARD-004 por ID exacto.

## Validación

- card_id: CARD-004
- status: 
REVIEW
- recommended_column: 
REVIEW
- rebuilt_dashboard_status: 
REVIEW
- rebuilt_dashboard_column: 
REVIEW
- last_cycle_id: 
REAL-LIFECYCLE-CYCLE-CARD-004-20260619-091515
- last_transition_id: 
LIFECYCLE-TRANSITION-CARD-004-20260619-091855
- backup: 
C:\ENGREMIAT_CORE\data\real-card-lifecycle-panel-001\backups\CARD-004.md.20260619-091855.bak.md
- worker_response_exists: 
True
- worker_evidence_exists: 
True

## Cadena validada

```text
Obsidian CARD-004
→ panel lifecycle
→ botón worker mock
→ response/evidence
→ gate humano
→ backup
→ transición DOING → REVIEW
→ dashboard reconstruido desde cards reales
```

## Resultado clave

La prueba real funciona de punta a punta para una tarjeta creada desde Obsidian.

## Siguiente

E06_CLOSE_REAL_CARD_LIFECYCLE_PANEL_001_AND_DECIDE_NEXT
