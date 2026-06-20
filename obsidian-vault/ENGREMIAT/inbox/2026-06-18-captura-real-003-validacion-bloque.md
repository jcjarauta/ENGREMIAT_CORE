---
type: capture
status: classified
created: 2026-06-18
classification: reports, skill-candidate
---

# Captura real 003 - Validacion de bloque y cierre con evidencia

## Contexto
Tras ejecutar bloques PowerShell, el humano pega logs. Hay que validar PASS/WARN/FAIL, extraer rutas, detectar errores y decidir siguiente accion.

## Informacion bruta
El flujo se repite: recibir log, comprobar package, step, status, report_json, next, readiness y riesgos pendientes.

## Clasificacion
- [x] report
- [x] skill-candidate
- [x] manual

## Siguiente accion
Convertir en Skill candidate: validar bloque y generar cierre con evidencia.

## Enlaces
- [[00_INDEX]]
- [[WORKFLOW_CAPTURE_CLASSIFICATION]]
- [[SKILLS_ENTRY_GATE]]
