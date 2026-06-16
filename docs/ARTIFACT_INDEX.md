# ARTIFACT_INDEX

Generado desde `data/registry/artifact-registry.jsonl`.

## ENGREMIAT_DEV_ASSISTED_WORKER_ADAPTER_001

| Paso | Artefacto | Ruta | Tipo | Estado |
|---|---|---|---|---|
| P00.1.1 | assisted-worker-adapter-contract.json | data/dev-assisted-worker/assisted-worker-adapter-contract.json | contract | ACTIVE |
| P00.1.2 | ASSISTED_WORKER_ADAPTER_GUIDE.md | docs/ASSISTED_WORKER_ADAPTER_GUIDE.md | guide | ACTIVE |
| P00.2.1 | assisted-worker-policy.json | data/dev-assisted-worker/assisted-worker-policy.json | policy | ACTIVE |
| P00.2.2 | assisted-worker-contract-validation-report.json | reports/dev-assisted-worker/e00-contract/assisted-worker-contract-validation-report.json | report | ACTIVE |
| P00.3.1 | assisted-worker-modes.json | data/dev-assisted-worker/assisted-worker-modes.json | state | ACTIVE |
| P00.3.2 | assisted-worker-modes-validation-report.json | reports/dev-assisted-worker/e00-contract/assisted-worker-modes-validation-report.json | report | ACTIVE |
| P01.1.1 | agent-task-package.schema.json | data/dev-assisted-worker/agent-task-package.schema.json | schema | ACTIVE |
| P01.1.2 | agent-task-package.fixture.json | data/dev-assisted-worker/agent-task-package.fixture.json | fixture | ACTIVE |
| P01.2.1 | eng-assisted-task-builder.ps1 | tools/eng-assisted-task-builder.ps1 | tool | ACTIVE |
| P01.2.2 | assisted-task-builder-validation-report.json | reports/dev-assisted-worker/e01-agent-task-package/assisted-task-builder-validation-report.json | report | ACTIVE |
| P01.3.1 | assisted-worker-prompt-template.md | docs/assisted-worker-prompt-template.md | template | ACTIVE |
| P01.3.2 | assisted-worker-prompt.sample.md | docs/assisted-worker-prompt.sample.md | sample | ACTIVE |
| P01.3.2 | assisted-worker-prompt-validation-report.json | reports/dev-assisted-worker/e01-agent-task-package/assisted-worker-prompt-validation-report.json | report | ACTIVE |
| P02.1.1 | assisted-handoff-record.schema.json | data/dev-assisted-worker/assisted-handoff-record.schema.json | schema | ACTIVE |
| P02.1.2 | handoff-registry.jsonl | data/dev-assisted-worker/handoff-registry.jsonl | registry | ACTIVE |
| P02.2.1 | eng-assisted-handoff.ps1 | tools/eng-assisted-handoff.ps1 | tool | ACTIVE |
| P02.2.2 | assisted-handoff-validation-report.json | reports/dev-assisted-worker/e02-controlled-handoff/assisted-handoff-validation-report.json | report | ACTIVE |
| P02.2.2 | prompt.md | data/dev-assisted-worker/handoffs/AW-HANDOFF-FIXTURE-001/prompt.md | prompt | ACTIVE |
| P02.3.1 | assisted-worker-state.json | data/dev-assisted-worker/assisted-worker-state.json | state | ACTIVE |
| P02.3.2 | assisted-worker-state-validation-report.json | reports/dev-assisted-worker/e02-controlled-handoff/assisted-worker-state-validation-report.json | report | ACTIVE |
| P03.1.1 | agent-result-proposal.schema.json | data/dev-assisted-worker/agent-result-proposal.schema.json | schema | ACTIVE |
| P03.1.2 | agent-result-proposal.fixture.json | data/dev-assisted-worker/agent-result-proposal.fixture.json | fixture | ACTIVE |
| P03.2.1 | eng-assisted-intake.ps1 | tools/eng-assisted-intake.ps1 | tool | ACTIVE |
| P03.2.2 | assisted-intake-validation-report.json | reports/dev-assisted-worker/e03-intake-result/assisted-intake-validation-report.json | report | ACTIVE |
| P03.2.2 | assisted-worker-review-request.json | data/dev-assisted-worker/results/assisted-worker-review-request.json | review | ACTIVE |
| P03.3.1 | assisted-worker-evidence-manifest.json | data/dev-assisted-worker/evidence/assisted-worker-evidence-manifest.json | evidence | ACTIVE |
| P03.3.2 | assisted-worker-context-update-report.json | reports/dev-assisted-worker/e03-intake-result/assisted-worker-context-update-report.json | report | ACTIVE |

## ENGREMIAT_DEV_SYSTEM_001

| Paso | Artefacto | Ruta | Tipo | Estado |
|---|---|---|---|---|
| P00.x.x | DEV_SYSTEM_GUIDE.md | docs/DEV_SYSTEM_GUIDE.md | e00_artifact | ACTIVE |
| P00.x.x | dev-system-contract.json | data/dev/dev-system-contract.json | e00_artifact | ACTIVE |
| P00.x.x | dev-system-contract-validation-report.json | reports/dev-system/e00-contract/dev-system-contract-validation-report.json | e00_artifact | ACTIVE |
| P00.x.x | dev-system-policy.json | data/dev/dev-system-policy.json | e00_artifact | ACTIVE |
| P01.1.1 | artifact-record.schema.json | data/registry/artifact-record.schema.json | schema | ACTIVE |
| P01.1.2 | artifact-registry.jsonl | data/registry/artifact-registry.jsonl | registry | ACTIVE |
| P01.1.2 | artifact-registry-latest.json | data/registry/artifact-registry-latest.json | state | ACTIVE |
| P01.2.1 | eng-artifacts.ps1 | tools/eng-artifacts.ps1 | tool | ACTIVE |
| P01.2.2 | ARTIFACT_INDEX.md | docs/ARTIFACT_INDEX.md | index | ACTIVE |
| P02.1.1 | context-snapshot.schema.json | data/dev/context-snapshot.schema.json | schema | ACTIVE |
| P02.1.2 | context-snapshot.json | data/dev/context-snapshot.json | state | ACTIVE |
| P02.2.1 | eng-context.ps1 | tools/eng-context.ps1 | tool | ACTIVE |
| P02.2.2 | CURRENT_CONTEXT.md | docs/CURRENT_CONTEXT.md | doc | ACTIVE |
| P02.2.2 | last-context.txt | reports/context/last-context.txt | report | ACTIVE |
| P03.1.1 | active-row.schema.json | data/dev/active-row.schema.json | schema | ACTIVE |
| P03.1.2 | active-row.json | data/dev/active-row.json | state | ACTIVE |
| P03.2.1 | next-package.json | data/dev/next-package.json | state | ACTIVE |
| P03.2.2 | eng-dev-runner.ps1 | tools/eng-dev-runner.ps1 | tool | ACTIVE |
| P04.1.1 | gate-record.schema.json | data/gates/gate-record.schema.json | schema | ACTIVE |
| P04.1.2 | gate-registry.jsonl | data/gates/gate-registry.jsonl | registry | ACTIVE |
| P04.1.2 | pending-gates.json | data/gates/pending-gates.json | state | ACTIVE |
| P04.2.1 | eng-gates.ps1 | tools/eng-gates.ps1 | tool | ACTIVE |
| P04.2.2 | GATE_INDEX.md | docs/GATE_INDEX.md | index | ACTIVE |
| P04.2.2 | pending-gates.json | reports/gates/pending-gates.json | report | ACTIVE |
| P05.1.1 | readiness-report.schema.json | data/dev/readiness-report.schema.json | schema | ACTIVE |
| P05.1.2 | readiness.json | data/dev/readiness.json | state | ACTIVE |
| P05.2.1 | eng-readiness.ps1 | tools/eng-readiness.ps1 | tool | ACTIVE |
| P05.2.2 | current-readiness.json | reports/readiness/current-readiness.json | report | ACTIVE |
| P05.2.2 | current-readiness.md | reports/readiness/current-readiness.md | report | ACTIVE |
| P05.2.2 | index.html | reports/readiness/index.html | dashboard | ACTIVE |
| P06.1.1 | error-memory-record.schema.json | data/errors/error-memory-record.schema.json | schema | ACTIVE |
| P06.1.2 | error-memory.jsonl | data/errors/error-memory.jsonl | registry | ACTIVE |
| P06.1.2 | last-error.json | data/errors/last-error.json | state | ACTIVE |
| P06.2.1 | eng-errors.ps1 | tools/eng-errors.ps1 | tool | ACTIVE |
| P06.2.2 | ERROR_PLAYBOOK.md | docs/ERROR_PLAYBOOK.md | doc | ACTIVE |
| P07.1.1 | doc-sync-plan.json | data/dev/doc-sync-plan.json | plan | ACTIVE |
| P07.1.2 | DEVELOPMENT_LOG.md | docs/DEVELOPMENT_LOG.md | doc | ACTIVE |
| P07.2.1 | eng-doc-sync.ps1 | tools/eng-doc-sync.ps1 | tool | ACTIVE |
| P07.2.2 | doc-sync-validation-report.json | reports/dev-system/e07-doc-sync/doc-sync-validation-report.json | report | ACTIVE |
| P08.1.1 | dashboard-data.schema.json | data/dev/dashboard-data.schema.json | schema | ACTIVE |
| P08.1.2 | dashboard-data.json | reports/dev-dashboard/dashboard-data.json | data | ACTIVE |
| P08.2.1 | index.html | reports/dev-dashboard/index.html | dashboard | ACTIVE |
| P08.2.2 | dev-dashboard-validation-report.json | reports/dev-system/e08-dev-dashboard/dev-dashboard-validation-report.json | report | ACTIVE |
| P09.1.1 | eng.ps1 | eng.ps1 | tool | ACTIVE |
| P09.1.2 | ENG_COMMANDS.md | docs/ENG_COMMANDS.md | doc | ACTIVE |
| P09.2.1 | dev-system-smoke-report.json | reports/dev-system/e09-command-hub-close/dev-system-smoke-report.json | report | ACTIVE |
| P09.2.2 | checksums.sha256 | manifests/ENGREMIAT_DEV_SYSTEM_001/checksums.sha256 | checksum | ACTIVE |
| P09.2.2 | DEMO_SCRIPT.md | DEMO_SCRIPT.md | doc | ACTIVE |
| P09.2.2 | manifest.json | manifests/ENGREMIAT_DEV_SYSTEM_001/manifest.json | manifest | ACTIVE |
| P09.2.2 | NEXT_OBJECTIVE.md | NEXT_OBJECTIVE.md | doc | ACTIVE |

