---
type: skill-candidate
status: candidate
created: 2026-06-18
risk: LOW
source: inbox/2026-06-18-captura-real-001-resumen-estado-engremiat
---

# Skill Candidate 001 - Resumir estado ENGREMIAT

## Procedimiento repetible
Generar un resumen breve del estado actual de ENGREMIAT a partir de reports, logs y notas activas.

## Entrada
- Ultimo log pegado por el humano.
- Reports de cierre si existen.
- 01_CURRENT_STATUS.md.
- 04_NEXT_ACTIONS.md.

## Proceso
1. Detectar objetivo activo.
2. Detectar ultimo bloque cerrado.
3. Identificar status PASS/WARN/FAIL.
4. Extraer rutas de evidencia.
5. Resumir readiness y riesgos.
6. Proponer siguiente paso.

## Salida
Resumen compacto con estado, readiness, evidencia, riesgos y NEXT.

## Reglas
No inventar estado. Si falta evidencia, marcar WARN. No ejecutar acciones.

## Evidencia
Debe citar package_id, status y ruta de report si existe.

## Riesgo
LOW. Solo lectura y resumen.

## Decision
- [ ] Mantener como manual
- [x] Convertir en Skill cuando se inicie ENGREMIAT_OPENWEBUI_SKILLS_001
- [ ] Aplazar
- [ ] Descartar

## Enlaces
- [[SKILLS_ENTRY_GATE]]
- [[KNOWLEDGE_GRAPH_HUB]]
