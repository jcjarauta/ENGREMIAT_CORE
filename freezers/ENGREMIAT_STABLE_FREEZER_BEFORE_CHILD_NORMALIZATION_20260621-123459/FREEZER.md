# ENGREMIAT STABLE FREEZER

Fecha: 
2026-06-21T12:34:59
Estado: 
PASS

## Inicio canonico
C:\WINDOWS\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\ENGREMIAT.ps1"

## Leyenda comun
[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar

## Arbol de navegacion
- [1] Inicio operador -> C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1
- [2] Proyectos -> C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- [3] Memoria y documentacion -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
- [4] Data Intake -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- [5] Health launchers -> C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1
- [m] Mantenimiento -> C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1
- [?] Ayuda -> internal
- [Enter] Refrescar -> internal
- [b/q] Salir/volver -> internal

## Pantallas
- master: exists=True parse=True legend=True path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1
  funciones: Run-Screen, Show-Help, Show-Maintenance, Show-Menu, W, Wait-Back
- inicio: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1
  funciones: B, W
- proyectos: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
  funciones: B, D, EnsureProjectJson, GetActivePath, GetProjects, LoadJsonOrNew, New-EngProjectsManagerMaintenanceCard, SaveActive, SendHistoric, SetProp, Show-EngProjectsManagerHelp, ShowWorkspace, W
- memoria: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
  funciones: ActiveProfilePath, Arr, AssistGrantProfile, DossierClientes, DossierPartners, DossierSubvenciones, EditGrantProfile, EnsureDir, EnsureDoc, EnsureProfile, GenerateAdaptedDossier, Header, Menu, OpenDataIntake, OpenMd, P, PlaceholderSub, StatusHelp, SubConvocatorias, UX
- data: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
  funciones: ActiveProfilePath, EditManualProfile, EnsureDemoProfile, EnsureDir, ExtractValue, GrantsDir, Header, ImportJson, ImportTxtMd, IntakeContracts, IntakeInbox, IntakeNormalized, NewDemoObject, OpenPath, P, SaveProfile, ShowHelp, ShowStatus, UX, UXErr
- health: exists=True parse=True legend=False path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1
  funciones: ParseOk, W
- mantenimiento: exists=True parse=True legend=True path=C:\ENGREMIAT_CORE\tools\human-card-assistant.ps1
  funciones: Ensure-Dirs, Is-Cancel, New-HumanCard, Read-FormValue, SafeText, Show-Help, Show-Inbox, Show-Index, Show-Maintenance, W, Wait-Back
- launcher_actual: exists=True parse=True legend=True path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
  funciones: ActiveProject, Invoke-HumanCardAssistant, Main, OpenActiveProjectFolder, P, RunScript, Show-EngLauncherActualHelp, Show-EngLauncherActualMaintenance, ShowStatus, W

## Necesidades antes de seguir
- MEDIUM: normalizar leyenda comun en inicio
- MEDIUM: normalizar leyenda comun en proyectos
- MEDIUM: normalizar leyenda comun en memoria
- MEDIUM: normalizar leyenda comun en data
- MEDIUM: normalizar leyenda comun en health

## Proyectos detectados
- C:\ENGREMIAT_CORE\projects\ENGREMIAT_PROJECT_heartbeat_demo
- C:\ENGREMIAT_CORE\projects\projects
- C:\Users\pc\Desktop\ENGREMIAT_PROJECT_E1_20260619-220618
- C:\Users\pc\Desktop\ENGREMIAT_PROJECT_nuevo-proyecto_20260619-161706

## Modulos / espacios detectados
- C:\ENGREMIAT_CORE\tools\cline-real-proposal-no-apply
- C:\ENGREMIAT_CORE\tools\controlled-action-from-proposal-015
- C:\ENGREMIAT_CORE\tools\controlled-action-instance-018
- C:\ENGREMIAT_CORE\tools\controlled-action-replication-016
- C:\ENGREMIAT_CORE\tools\controlled-action-template-017
- C:\ENGREMIAT_CORE\tools\controlled-apply-or-repair-014
- C:\ENGREMIAT_CORE\tools\desktop-terminal-operator
- C:\ENGREMIAT_CORE\tools\dual-pc-development-workflow
- C:\ENGREMIAT_CORE\tools\first-cline-proposal-task-009
- C:\ENGREMIAT_CORE\tools\gated-worker-execution
- C:\ENGREMIAT_CORE\tools\global-modular-replicable
- C:\ENGREMIAT_CORE\tools\health
- C:\ENGREMIAT_CORE\tools\human-maintenance-cards
- C:\ENGREMIAT_CORE\tools\kanban-backlog
- C:\ENGREMIAT_CORE\tools\kanban-human-control
- C:\ENGREMIAT_CORE\tools\kanban-local
- C:\ENGREMIAT_CORE\tools\kanban-real-setup-012
- C:\ENGREMIAT_CORE\tools\kanban-visible-ollama-ready-013
- C:\ENGREMIAT_CORE\tools\launcher
- C:\ENGREMIAT_CORE\tools\local-kanban-execution-cycle
- C:\ENGREMIAT_CORE\tools\local-kanban-state-update
- C:\ENGREMIAT_CORE\tools\local-kanban-worker-loop
- C:\ENGREMIAT_CORE\tools\local-multiworker-launch-and-link-n1
- C:\ENGREMIAT_CORE\tools\local-multiworker-launch-and-link-n2
- C:\ENGREMIAT_CORE\tools\main-pc-linking
- C:\ENGREMIAT_CORE\tools\memory
- C:\ENGREMIAT_CORE\tools\module-cards
- C:\ENGREMIAT_CORE\tools\node-link
- C:\ENGREMIAT_CORE\tools\obsidian-to-worker-real-exercise
- C:\ENGREMIAT_CORE\tools\operational
- C:\ENGREMIAT_CORE\tools\operator-context
- C:\ENGREMIAT_CORE\tools\plan-to-worker
- C:\ENGREMIAT_CORE\tools\prompt-factory
- C:\ENGREMIAT_CORE\tools\real-cline-kanban-ollama-tests
- C:\ENGREMIAT_CORE\tools\real-intake-importer
- C:\ENGREMIAT_CORE\tools\real-roadmap-generator-ollama-preview
- C:\ENGREMIAT_CORE\tools\runtime
- C:\ENGREMIAT_CORE\tools\screen-master-template
- C:\ENGREMIAT_CORE\tools\screen-normalizer
- C:\ENGREMIAT_CORE\tools\template-improvement
- C:\ENGREMIAT_CORE\tools\tool-calibration-controller
- C:\ENGREMIAT_CORE\tools\toolchain
- C:\ENGREMIAT_CORE\tools\vault-module-builder
- C:\ENGREMIAT_CORE\tools\worker-adapters
- C:\ENGREMIAT_CORE\tools\worker-response-import-020

## Tarjetas normalizadas / referencia
- documents\human-cards\observer-review\observer-review-20260621-061203.md
- documents\module-cards\flow-close\module-card-action-flow-close-20260620-145744.md
- documents\module-cards\flow-close\module-card-action-flow-close.latest.json
- documents\module-cards\flow-close\module-card-action-flow-close-20260620-145744.json
- documents\module-cards\approved-action-runner\approved-module-action-execution.latest.json
- documents\module-cards\approved-action-runner\approved-module-action-execution-20260620-145718.json
- documents\module-cards\approved-action-runner\pending-auth-module-action-runner-20260620-145635.md
- documents\module-cards\approved-action-runner\pending-auth-module-action-runner.latest.json
- documents\module-cards\approved-action-runner\pending-auth-module-action-runner-20260620-145635.json
- documents\module-cards\blueprint-execution-plans\approved-module-blueprint-execution-plan-20260620-145604.md
- documents\module-cards\blueprint-execution-plans\approved-module-blueprint-execution-plan-20260620-145604.json
- documents\module-cards\blueprint-execution-plans\approved-module-blueprint-execution-plan.latest.json
- documents\module-cards\approved-action-flow\approved-module-card-action-flow-20260620-145539.md
- documents\module-cards\approved-action-flow\approved-module-card-action-flow-20260620-145539.json
- documents\module-cards\approved-action-flow\approved-module-card-action-flow.latest.json
- documents\module-cards\action-unlocks\human-gate-cab-cap-card-action-unlock.latest.json
- documents\module-cards\action-unlocks\human-gate-cab-cap-card-action-unlock-20260620-145515.md
- documents\module-cards\action-unlocks\human-gate-cab-cap-card-action-unlock-20260620-145515.json
- documents\module-cards\gate-mutation-contracts\gate-approval-real-mutation-receipt-20260620-145448.json
- documents\module-cards\gate-state\human-gate-cab-cap-card-state.json
- documents\module-cards\gate-state\human-gate-cab-cap-card-state.README.20260620-145334.md
- documents\module-cards\gate-state\human-gate-cab-cap-card-state.before-e110-20260620-145448.json
- documents\module-cards\gate-mutation-contracts\canonical-gate-target-classification-20260620-145307.json
- documents\module-cards\gate-mutation-contracts\canonical-gate-target-classification-20260620-145307.md
- documents\module-cards\gate-mutation-contracts\canonical-gate-target-readonly-plan-20260620-145237.md
- documents\module-cards\gate-mutation-contracts\gate-approval-real-mutation-script.pending-auth.20260620-145137.json
- documents\module-cards\gate-mutation-contracts\gate-mutation-preview.dry-run.20260620-145102.md
- documents\module-cards\gate-mutation-contracts\gate-mutation-preview.dry-run.20260620-145102.json
- documents\module-cards\gate-mutation-contracts\gate-mutation-validator.no-execution.schema-tolerant.json
- documents\module-cards\gate-mutation-contracts\gate-mutation-validator.no-execution.json
- documents\module-cards\gate-mutation-contracts\GMC-HUMAN-GATE-CAB-CAP-CARD-ENGREMIAT_PROJECT_projects-MODULE_inicio-START-001-20260620-140830-20260620-144931.json
- documents\module-cards\gate-mutation-contracts\gate-decision-mutation-contract.schema.json
- documents\module-cards\gate-mutation-contracts\gate-decision-mutation-contract.md
- documents\module-cards\HUMAN_GATE_DECISION_DRY_RUN_STAGE_CLOSE.md
- documents\module-cards\gate-decisions\HGD-HUMAN-GATE-CAB-CAP-CARD-ENGREMIAT_PROJECT_projects-MODULE_inicio-START-001-20260620-140830-20260620-144247.json
- documents\module-cards\HUMAN_GATE_READONLY_STAGE_CLOSE.md
- documents\module-cards\gates\card-blueprint-human-gate.schema.json
- documents\module-cards\gates\HUMAN-GATE-CAB-CAP-CARD-ENGREMIAT_PROJECT_projects-MODULE_inicio-START-001-20260620-140830.json
- documents\module-cards\gates\card-blueprint-human-gate.example.json
- documents\module-cards\CARD_ACTION_VIEW_STAGE_CLOSE.md
- documents\module-cards\CARD_ACTION_PROPOSAL_FLOW_CLOSE.md
- documents\module-cards\blueprints\CAB-CAP-CARD-ENGREMIAT_PROJECT_projects-MODULE_inicio-START-001-20260620-140830.json
- documents\module-cards\proposals\CAP-CARD-ENGREMIAT_PROJECT_projects-MODULE_inicio-START-001-20260620-140830.json
- documents\module-cards\card-action-proposal.example.json
- documents\module-cards\card-action-proposal.schema.json
- documents\module-cards\card-action-proposal-flow.json
- documents\module-cards\card-action-proposal-flow.md
- documents\module-cards\MODULE_CARD_CANON_FINAL_CLOSE.md
- documents\module-cards\module-linked-card.index.json
- documents\module-cards\project-module-card-table.normalized.json
- documents\module-cards\MODULE_CARD_PROJECT_ROUTE_STAGE_CLOSE.md
- documents\module-cards\CARD-ENGREMIAT_PROJECT_projects-MODULE_inicio-START-001.json
- documents\module-cards\CARD-projects-MODULE_inicio-START-001.json
- documents\module-cards\CARD-ENGREMIAT_PROJECT_heartbeat_demo-MODULE_inicio-START-001.json
- documents\module-cards\project-start-module-rule.json
- documents\module-cards\card-view-project-module-integration.decision.json
- documents\module-cards\card-view-project-module-integration.decision.md
- documents\module-cards\project-module-card-view.contract.json
- documents\module-cards\project-module-card-view.contract.md
- documents\module-cards\MODULE_CARD_CANON_STAGE_CLOSE.md
- documents\module-cards\card-to-module-flow.md
- documents\module-cards\card-to-module-decision-matrix.json
- documents\module-cards\card-to-module-flow.json
- documents\module-cards\README.md
- documents\module-cards\module-linked-card.template.md
- documents\module-cards\module-linked-card.example.json
- documents\module-cards\module-linked-card.schema.json

## Snapshots
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\contract_MASTER_ENTRY_CONTRACT__MASTER_ENTRY_CONTRACT.json
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\contract_NAVIGATION_CONTRACT__NAVIGATION_CONTRACT.json
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\data__ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\health__ENGREMIAT-LAUNCHER-HEALTH.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\inicio__Start-EngremiatOperatorMenu.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\launcher_actual__ENGREMIAT-LAUNCHER-ACTUAL.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\mantenimiento__human-card-assistant.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\master__ENGREMIAT.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\memoria__ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1
- C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\proyectos__eng-projects-manager.ps1
