# Estado Data Intake - salidas conectadas

Fecha: 2026-06-20T09:35:30

## Principio operativo
Data Intake produce fichas estructuradas. Centro Documental y futuros centros consumen fichas, no fuentes brutas.

## Perfiles normalizados
- grant-call-profile-from-folder-latest.json | type=grant_call | status=ready | confidence=medium | source=folder | pending=0
- grant-call-profile-from-intake-latest.json | type=grant_call | status=ready | confidence=high | source=demo | pending=0
- grant-call-profile-from-pdf-registered-only-latest.json | type=grant_call | status=pending_review | confidence=none | source=pdf_registered_only | pending=8
- grant-call-profile-from-txt-md-heuristic-latest.json | type=grant_call | status=ready | confidence=medium | source=txt | pending=0
- grant-call-profile-from-txt-md-latest.json | type=grant_call | status=pending_review | confidence=none | source=txt | pending=6

## Fuentes registradas
- intake-source-folder-latest.json | type=folder | status=normalized | title=convocatoria-demo-folder
- intake-source-pdf-latest.json | type=pdf_registered_only | status=registered_no_extraction | title=convocatoria-demo-registered-only
- intake-source-txt-md-latest.json | type=txt | status=ready | title=pegar-convocatoria-aqui

## Consumidores
- Centro Documental: activo
- Task Center: futuro
- Module Center: futuro
- Evidence Center: futuro

## Siguiente
E16: cerrar paquete Data Intake v1 o empezar integracion UI persistente en el Data Intake Center.
