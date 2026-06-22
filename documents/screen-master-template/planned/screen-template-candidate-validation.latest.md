# E07 validar plantilla master contra pantallas candidatas

## Decision
GO_CANDIDATE_SCREENS_CLASSIFIED_NEEDS_MIGRATION_PLAN

## Regla
Read-only. No modifica pantallas. La migración se hará pantalla por pantalla con gate.

## Resumen
- Pantallas candidatas: 
34
- READY: 
1
- PARTIAL/NEEDS_TEMPLATE: 
33

## Tabla
| status | score | enter | b | q | m | ? | compressed | path |
|---|---:|---|---|---|---|---|---|---|
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-add-module-safe.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-create-module-safe.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-new-project-safe.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-STATUS.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-NAVIGATION-SAFE.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MEMORY-SAFE.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MODULE-CARDS-BRIDGE.ps1 |
| NEEDS_TEMPLATE | 1 | False | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-SAFE.ps1 |
| NEEDS_TEMPLATE | 2 | True | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-context.ps1 |
| NEEDS_TEMPLATE | 2 | True | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-library-import.ps1 |
| NEEDS_TEMPLATE | 2 | False | False | False | False | True | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-navigation.ps1 |
| NEEDS_TEMPLATE | 2 | True | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-select-module-safe.ps1 |
| NEEDS_TEMPLATE | 2 | True | False | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-status.ps1 |
| NEEDS_TEMPLATE | 2 | False | True | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1 |
| NEEDS_TEMPLATE | 2 | False | True | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MEMORY.ps1 |
| NEEDS_TEMPLATE | 3 | True | True | False | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-project-modules-screen.ps1 |
| NEEDS_TEMPLATE | 3 | False | False | False | True | True | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1 |
| NEEDS_TEMPLATE | 3 | True | False | True | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1 |
| NEEDS_TEMPLATE | 3 | False | True | False | False | True | True | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER.ps1 |
| NEEDS_TEMPLATE | 3 | False | True | False | False | True | True | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1 |
| NEEDS_TEMPLATE | 3 | True | False | True | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1 |
| NEEDS_TEMPLATE | 3 | True | True | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER.ps1 |
| NEEDS_TEMPLATE | 3 | False | True | False | False | True | True | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1 |
| NEEDS_TEMPLATE | 3 | True | True | False | False | False | True | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1 |
| NEEDS_TEMPLATE | 3 | True | True | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-CARDS.ps1 |
| NEEDS_TEMPLATE | 3 | True | True | False | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-WORKSPACE.ps1 |
| PARTIAL | 4 | True | True | True | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-cards-screen.ps1 |
| PARTIAL | 4 | True | True | True | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-workspace-screen.ps1 |
| PARTIAL | 4 | True | True | True | False | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1 |
| PARTIAL | 4 | True | True | True | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARD-DETAIL-VIEW-NORMALIZED.ps1 |
| PARTIAL | 4 | True | True | True | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1 |
| PARTIAL | 4 | True | True | True | False | False | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO.ps1 |
| PARTIAL | 5 | True | True | True | True | False | False | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-library-screen.ps1 |
| READY | 6 | True | True | True | True | True | False | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1 |

## Siguiente recomendado
E08_PREPARE_FIRST_SCREEN_MIGRATION_PLAN_NO_APPLY: elegir la primera pantalla PARTIAL/NEEDS_TEMPLATE y preparar parche NO_APPLY usando la plantilla master.
