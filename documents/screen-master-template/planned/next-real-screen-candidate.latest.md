# E10 seleccionar siguiente pantalla real

## Decision
GO_NEXT_REAL_SCREEN_SELECTED_NO_APPLY

## Excluidas como acciones
- C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-add-module-safe.ps1

## Target seleccionado
- path: C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-context.ps1
- status: NEEDS_TEMPLATE
- template_score: 2
- screen_score: 3
- action_score: 3

## Clasificación resumida
| kind | status | score | screen | action | path |
|---|---|---:|---:|---:|---|
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 4 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-create-module-safe.ps1 |
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 4 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-new-project-safe.ps1 |
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 3 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-STATUS.ps1 |
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 4 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-NAVIGATION-SAFE.ps1 |
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 4 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MEMORY-SAFE.ps1 |
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MODULE-CARDS-BRIDGE.ps1 |
| ACTION_SCRIPT_WITH_PROMPTS | NEEDS_TEMPLATE | 1 | 2 | 4 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-SAFE.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 3 | 3 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-context.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 4 | 2 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-library-import.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 3 | 1 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-navigation.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 4 | 3 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-select-module-safe.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 4 | 0 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-status.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 4 | 0 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 2 | 3 | 3 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MEMORY.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 3 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-project-modules-screen.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 2 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 0 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 0 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 0 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 1 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-CARDS.ps1 |
| SCREEN_CANDIDATE | NEEDS_TEMPLATE | 3 | 4 | 1 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-WORKSPACE.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 4 | 4 | 3 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-cards-screen.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 4 | 4 | 3 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-workspace-screen.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 4 | 4 | 2 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 4 | 4 | 0 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARD-DETAIL-VIEW-NORMALIZED.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 4 | 4 | 0 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 4 | 4 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO.ps1 |
| SCREEN_CANDIDATE | PARTIAL | 5 | 4 | 3 | C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-library-screen.ps1 |
| SCREEN_CANDIDATE | READY | 6 | 4 | 2 | C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1 |

## Next
E11_PREPARE_SCREEN_TEMPLATE_PATCH_FOR_SELECTED_SCREEN_NO_APPLY
