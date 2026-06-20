---
type: project
project_id: "{{project_id}}"
title: "{{project_title}}"
status: review
readiness: 0
priority: media
decision: WAIT_HUMAN_REVIEW
next_action: "{{next_action}}"
source_path: "{{source_path}}"
created_at: "{{created_at}}"
updated_at: "{{updated_at}}"
tags:
  - engremiat/project
  - status/review
---
# Proyecto · {{project_title}}

## Estado operativo
- Estado: `review`
- Readiness: `0`
- Decisión: `WAIT_HUMAN_REVIEW`
- Siguiente acción: {{next_action}}

## Flujo principal
[[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_01-intake-intake-normalizado]] → [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_02-roadmap-roadmap-ia-local]] → [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_03-tareas-tasks-index]] → [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_04-gates-decisiones-gates-index]] → [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_05-evidencias-evidence-index]] → [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_07-resultados-result-summary]]

## Gates pendientes
- [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_04-gates-decisiones-gate-roadmap-approval]]
- [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_04-gates-decisiones-gate-worker-execution]]

## Evidencias
- [[08_PLANTILLAS/_AUDIT_REVIEW/STUBS/STUB_05-evidencias-evidence-index]]

## Nota
Esta nota organiza el proyecto; la fuente canónica permanece en `data/`, `reports/`, `exports/`, `manifests/` y `dashboard/`.








