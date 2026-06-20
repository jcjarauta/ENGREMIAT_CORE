# E08 · Top candidates and import adapter decision

## Objetivo

Filtrar los 1005 candidatos de E07 y detectar si Cline/Kanban tiene almacenamiento local file-based que podamos importar sin tocar UI.

## Resultado

- Hits E07: 
1005
- Candidatos filtrados: 
734
- Top candidatos revisados: 
40
- Samples creadas: 
10

## Top candidatos
- score=71 kind=file size=13977 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=71 kind=file size=888 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e02-kanban-board-generation-report.json
- score=71 kind=file size=799 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e03-kanban-dashboard-validation-report.json
- score=71 kind=file size=13977 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=71 kind=file size=888 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\reports\kanban-human-control\e02-kanban-board-generation-report.json
- score=71 kind=file size=799 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\reports\kanban-human-control\e03-kanban-dashboard-validation-report.json
- score=71 kind=file size=13977 path=C:\Users\pc\.cline\worktrees\c4546\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=69 kind=file size=893 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\docs\KANBAN_HUMAN_DASHBOARD_GUIDE.md
- score=69 kind=file size=893 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\docs\KANBAN_HUMAN_DASHBOARD_GUIDE.md
- score=66 kind=file size=7293 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\tools\kanban-human-control\Build-KanbanHumanDashboard.ps1
- score=66 kind=file size=7293 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\tools\kanban-human-control\Build-KanbanHumanDashboard.ps1
- score=63 kind=file size=2575 path=C:\ENGREMIAT_CORE\data\file-kanban-preview-155\kanban-preview-board.json
- score=63 kind=file size=13977 path=C:\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=63 kind=file size=4063 path=C:\ENGREMIAT_CORE\data\kanban-real-setup-012\kanban-board.json
- score=63 kind=file size=4595 path=C:\ENGREMIAT_CORE\data\kanban-sync-042\kanban-mvp-board.json
- score=58 kind=dir size=0 path=C:\ENGREMIAT_CORE\data\ENGREMIAT_MODULAR_PLATFORM_001\E06\kanban-adapter-dashboard
- score=58 kind=dir size=0 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\dashboard\kanban-human-control
- score=58 kind=dir size=0 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\dashboard\kanban-human-control
- score=58 kind=dir size=0 path=C:\Users\pc\.cline\worktrees\c4546\ENGREMIAT_CORE\dashboard\kanban-human-control
- score=56 kind=file size=1715 path=C:\ENGREMIAT_CORE\data\first-cline-proposal-task-009\selected-kanban-context.json
- score=55 kind=dir size=0 path=C:\ENGREMIAT_CORE\dashboard\real-cline-kanban-ollama-tests
- score=55 kind=file size=8107 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\cline-real-proposal-no-apply\selected-kanban-context.json
- score=55 kind=file size=2673 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\cards\KANBAN-005-E06.json
- score=55 kind=file size=2601 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\cards\KANBAN-006-E06.json
- score=55 kind=file size=1917 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\cards\KANBAN-007-E02.json
- score=55 kind=file size=2211 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\cline-kanban-adapter-contract.json
- score=55 kind=file size=9641 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\cline-kanban-export-preview.json
- score=55 kind=file size=2989 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\kanban-card-schema.json
- score=55 kind=file size=6690 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\kanban-human-control-manifest.json
- score=55 kind=file size=2097 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\kanban-write-gate.json
- score=55 kind=file size=4543 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\kanban-write-request-preview.json
- score=55 kind=file size=1950 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\sample-kanban-card.json
- score=55 kind=file size=942 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\cline-real-proposal-no-apply\e02-kanban-source-validation-report.json
- score=55 kind=file size=704 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e01-kanban-card-schema-validation-report.json
- score=55 kind=file size=933 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e04-cline-kanban-adapter-preview-report.json
- score=55 kind=file size=1103 path=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e05-kanban-write-gate-validation-report.json
- score=55 kind=file size=8107 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\data\cline-real-proposal-no-apply\selected-kanban-context.json
- score=55 kind=file size=2673 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\data\kanban-human-control\cards\KANBAN-005-E06.json
- score=55 kind=file size=2601 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\data\kanban-human-control\cards\KANBAN-006-E06.json
- score=55 kind=file size=1917 path=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\data\kanban-human-control\cards\KANBAN-007-E02.json

## Samples read-only
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-01-kanban-board.json.txt source=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-02-e02-kanban-board-generation-report.json.txt source=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e02-kanban-board-generation-report.json
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-03-e03-kanban-dashboard-validation-report.json.txt source=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\reports\kanban-human-control\e03-kanban-dashboard-validation-report.json
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-04-kanban-board.json.txt source=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-05-e02-kanban-board-generation-report.json.txt source=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\reports\kanban-human-control\e02-kanban-board-generation-report.json
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-06-e03-kanban-dashboard-validation-report.json.txt source=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\reports\kanban-human-control\e03-kanban-dashboard-validation-report.json
- score=71 sample=09_IMPORT_DISCOVERY\samples\sample-07-kanban-board.json.txt source=C:\Users\pc\.cline\worktrees\c4546\ENGREMIAT_CORE\data\kanban-human-control\kanban-board.json
- score=69 sample=09_IMPORT_DISCOVERY\samples\sample-08-KANBAN_HUMAN_DASHBOARD_GUIDE.md.txt source=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\docs\KANBAN_HUMAN_DASHBOARD_GUIDE.md
- score=69 sample=09_IMPORT_DISCOVERY\samples\sample-09-KANBAN_HUMAN_DASHBOARD_GUIDE.md.txt source=C:\Users\pc\.cline\worktrees\65c2a\ENGREMIAT_CORE\docs\KANBAN_HUMAN_DASHBOARD_GUIDE.md
- score=66 sample=09_IMPORT_DISCOVERY\samples\sample-10-Build-KanbanHumanDashboard.ps1.txt source=C:\Users\pc\.cline\worktrees\07b15\ENGREMIAT_CORE\tools\kanban-human-control\Build-KanbanHumanDashboard.ps1

## Decisión provisional
PENDING_HUMAN_INSPECTION

## Qué mirar ahora

1. Si aparece un JSON/MD claramente de Kanban board, podemos diseñar adapter file-based.
2. Si solo aparecen worktrees/código/extensión, no hay importación directa todavía.
3. Si el formato real no aparece, mantener flujo: Obsidian genera paquete → humano importa/crea en Kanban.

## Siguiente

Revisar este archivo y las samples. Después decidir: FILE_BASED_IMPORT_GO, MANUAL_IMPORT_ONLY o SEARCH_DEEPER.
