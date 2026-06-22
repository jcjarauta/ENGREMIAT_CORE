# DIAGNOSTIC CANONICAL MAP

Estado: PASS
Modo: READONLY_MAP_ONLY
Apply: false
Git write: false

## Problema
Soluciones antiguas o disenadas se pierden si quedan solo en chat, backups o reports sin registry canonico.

## Solucion
Crear una capa permanente: observer puntual + observer-watch + memoria de desarrollo + registry de herramientas recuperables.

## Rutas recomendadas
- observer_file: C:\ENGREMIAT_CORE\tools\observer\engremiat-observer.ps1
- observer_watch_file: C:\ENGREMIAT_CORE\tools\observer\engremiat-observer-watch.ps1
- registry_file: C:\ENGREMIAT_CORE\documents\diagnostics\DIAGNOSTIC_TOOL_REGISTRY.json
- canonical_map_file: C:\ENGREMIAT_CORE\documents\diagnostics\DIAGNOSTIC_CANONICAL_MAP.json
- memory_events: C:\ENGREMIAT_CORE\memory\development\events.jsonl
- memory_latest: C:\ENGREMIAT_CORE\memory\development\latest-state.json
- memory_timeline: C:\ENGREMIAT_CORE\memory\development\timeline.md

## Familias recuperables
### observer_diagnostic
Motivo: Base para recuperar autodiagnostico, readiness, artifact registry y salud del sistema.
Count: 7
- score=138 tags=[diagnostic,kanban,memory,navigation,safe,worker] :: backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT-INICIO-NORMALIZED.before-e10j-workers-paused-safe-operator-access-20260620-191422.ps1
- score=50 tags=[devsystem,diagnostic,kanban,worker] :: backups\template-improvement\official-master-before-e05-20260619-231559\04_SIMULATED_WORKERS\SIM_WORKER_VALIDATOR.md
- score=50 tags=[devsystem,diagnostic,kanban,worker] :: backups\template-improvement\module-inicio-ref-before-e05-20260619-231559\04_SIMULATED_WORKERS\SIM_WORKER_VALIDATOR.md
- score=40 tags=[diagnostic,kanban,navigation] :: backups\screen-normalization\health-launchers.ps1.before-e14r2-m-card-assistant-20260621-064606.ps1
- score=40 tags=[devsystem,diagnostic,kanban] :: data\006E_VALIDACION_OPERATIVA_VISUAL\reports\visual-readiness-report.json
- score=20 tags=[devsystem,diagnostic] :: data\controlled-action-instance-018\artifacts-manifest-after-dry-run.json
- score=20 tags=[devsystem,diagnostic] :: data\controlled-action-instance-018\initial-artifacts-manifest.json

### memory_development
Motivo: Base para memoria de desarrollo: eventos, contexto, artefactos, gates y timeline.
Count: 12
- score=138 tags=[diagnostic,kanban,memory,navigation,safe,worker] :: backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT-INICIO-NORMALIZED.before-e10j-workers-paused-safe-operator-access-20260620-191422.ps1
- score=128 tags=[kanban,navigation,safe,worker] :: data\cline-real-proposal-no-apply\selected-kanban-context.json
- score=70 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-task-creation-gate.json
- score=40 tags=[devsystem,diagnostic,kanban] :: data\006E_VALIDACION_OPERATIVA_VISUAL\reports\visual-readiness-report.json
- score=20 tags=[worker] :: backups\template-improvement\module-inicio-ref-before-e05-20260619-231559\05_HUMAN_GATES\SIM_PROJECT_20260619-144124_GATE_APPROVE_ROADMAP.md
- score=20 tags=[worker] :: backups\template-improvement\official-master-before-e05-20260619-231559\05_HUMAN_GATES\SIM_PROJECT_20260619-144124_GATE_APPROVE_ROADMAP.md
- score=20 tags=[worker] :: data\approval-console-059\proposal-approval-gate.json
- score=20 tags=[devsystem,diagnostic] :: data\controlled-action-instance-018\artifacts-manifest-after-dry-run.json

### navigation_freezer
Motivo: Base para comparar sistema vivo contra contratos, freezer y snapshots.
Count: 5
- score=138 tags=[diagnostic,kanban,memory,navigation,safe,worker] :: backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT-INICIO-NORMALIZED.before-e10j-workers-paused-safe-operator-access-20260620-191422.ps1
- score=128 tags=[kanban,navigation,safe,worker] :: data\cline-real-proposal-no-apply\selected-kanban-context.json
- score=80 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-proposal-prompt-preview.md
- score=70 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-task-creation-gate.json
- score=40 tags=[diagnostic,kanban,navigation] :: backups\screen-normalization\health-launchers.ps1.before-e14r2-m-card-assistant-20260621-064606.ps1

### worker_governance
Motivo: Base para recuperar flujo worker gobernado: Cline/Ollama, proposal-only, gates, receipts y Kanban humano.
Count: 12
- score=138 tags=[diagnostic,kanban,memory,navigation,safe,worker] :: backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT-INICIO-NORMALIZED.before-e10j-workers-paused-safe-operator-access-20260620-191422.ps1
- score=128 tags=[kanban,navigation,safe,worker] :: data\cline-real-proposal-no-apply\selected-kanban-context.json
- score=80 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-proposal-prompt-preview.md
- score=70 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-task-creation-gate.json
- score=50 tags=[devsystem,diagnostic,kanban,worker] :: backups\template-improvement\official-master-before-e05-20260619-231559\04_SIMULATED_WORKERS\SIM_WORKER_VALIDATOR.md
- score=50 tags=[devsystem,diagnostic,kanban,worker] :: backups\template-improvement\module-inicio-ref-before-e05-20260619-231559\04_SIMULATED_WORKERS\SIM_WORKER_VALIDATOR.md
- score=40 tags=[diagnostic,kanban,navigation] :: backups\screen-normalization\health-launchers.ps1.before-e14r2-m-card-assistant-20260621-064606.ps1
- score=40 tags=[devsystem,diagnostic,kanban] :: data\006E_VALIDACION_OPERATIVA_VISUAL\reports\visual-readiness-report.json

### safe_recovery
Motivo: Base para fail-closed, gate humano, rollback, receipt y recuperacion.
Count: 12
- score=138 tags=[diagnostic,kanban,memory,navigation,safe,worker] :: backups\screen-normalizer-general-launcher-menu-router-integration-gate\ENGREMIAT-INICIO-NORMALIZED.before-e10j-workers-paused-safe-operator-access-20260620-191422.ps1
- score=128 tags=[kanban,navigation,safe,worker] :: data\cline-real-proposal-no-apply\selected-kanban-context.json
- score=80 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-proposal-prompt-preview.md
- score=70 tags=[kanban,navigation,risk_review,safe,worker] :: data\cline-real-proposal-no-apply\cline-task-creation-gate.json
- score=20 tags=[worker] :: backups\template-improvement\module-inicio-ref-before-e05-20260619-231559\05_HUMAN_GATES\SIM_PROJECT_20260619-144124_GATE_APPROVE_ROADMAP.md
- score=20 tags=[worker] :: backups\template-improvement\official-master-before-e05-20260619-231559\05_HUMAN_GATES\SIM_PROJECT_20260619-144124_GATE_APPROVE_ROADMAP.md
- score=20 tags=[worker] :: data\approval-console-059\proposal-approval-gate.json
- score=20 tags=[kanban,worker] :: data\controlled-action-from-proposal-015\controlled-action-gate-schema.json

## Decision
No aplicar todavia. El siguiente bloque crea el observer permanente readonly usando freezer + contracts + canonical map.

## Next
E02_CREATE_PERMANENT_OBSERVER_READONLY_USING_FREEZER_AND_CONTRACTS
