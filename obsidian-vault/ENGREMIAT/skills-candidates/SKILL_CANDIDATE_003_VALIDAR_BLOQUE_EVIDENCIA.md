---
type: skill-candidate
status: candidate
created: 2026-06-18
risk: LOW
source: inbox/2026-06-18-captura-real-003-validacion-bloque
---

# Skill Candidate 003 - Validar bloque y cierre con evidencia

## Procedimiento repetible
Analizar logs de ejecución ENGREMIAT y decidir si un bloque queda cerrado, en WARN o en FAIL.

## Entrada
- Log PowerShell pegado por humano.
- package_id.
- step_id.
- rutas REPORT_JSON/READINESS si aparecen.

## Proceso
1. Extraer package_id y step_id.
2. Detectar status PASS/WARN/FAIL.
3. Identificar NEXT.
4. Identificar evidencias generadas.
5. Detectar riesgos pendientes.
6. Proponer cierre, reparación o siguiente bloque.

## Salida
Diagnostico compacto: status, evidencias, riesgos, decision y siguiente accion.

## Reglas
No cerrar como PASS si hay errores no resueltos. WARN no bloquea si hay estrategia documentada. FAIL exige reparacion antes de avanzar.

## Evidencia
Debe devolver rutas reportadas y conclusion.

## Riesgo
LOW. Solo interpretacion de logs.

## Decision
- [ ] Mantener como manual
- [x] Convertir en Skill cuando se inicie ENGREMIAT_OPENWEBUI_SKILLS_001
- [ ] Aplazar
- [ ] Descartar

## Enlaces
- [[WORKFLOW_CAPTURE_CLASSIFICATION]]
- [[SKILLS_ENTRY_GATE]]
- [[KNOWLEDGE_GRAPH_HUB]]
