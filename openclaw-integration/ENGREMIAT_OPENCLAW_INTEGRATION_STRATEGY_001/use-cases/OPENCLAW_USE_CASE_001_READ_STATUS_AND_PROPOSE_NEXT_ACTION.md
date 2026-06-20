# OPENCLAW USE CASE 001 - READ STATUS AND PROPOSE NEXT ACTION

## Nombre
Leer estado ENGREMIAT y proponer siguiente accion.

## Tipo
READ_ONLY.

## Entrada
- OBSIDIAN_VAULT_READINESS_REPORT.md.
- KNOWLEDGE_BASE_READINESS_REPORT.md.
- NEXT_OBJECTIVE_OPENWEBUI_SKILLS_001.md.
- OPENCLAW_BOUNDARIES_POLICY.md.

## Proceso
1. Leer documentos preparados.
2. Detectar objetivo activo.
3. Identificar ultimo estado validado.
4. Proponer siguiente accion.
5. Indicar si la accion requiere autorizacion humana.

## Salida
Resumen compacto con status, decision y next.

## Riesgo
LOW si no ejecuta nada.

## Estado
candidate=True
execution_allowed=False
