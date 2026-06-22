# E03B locate real launcher no apply repair sort

## Decision
GO_REAL_LAUNCHER_CANDIDATE_FOUND_NO_APPLY

## Roots scanned
C:\ENGREMIAT_CORE
C:\Users\pc\Desktop

## Candidates
- 1. score=240 path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1 modified=2026-06-20 16:13:23
- 2. score=240 path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatOperatorMenu.ps1 modified=2026-06-20 00:43:46
- 3. score=220 path=C:\ENGREMIAT_CORE\launchers\Start-ENGREMIAT-OPERADOR-OneClick.ps1 modified=2026-06-20 00:18:24
- 4. score=170 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1 modified=2026-06-20 03:49:30
- 5. score=150 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1 modified=2026-06-20 16:17:25
- 6. score=130 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1 modified=2026-06-20 13:45:37
- 7. score=110 path=C:\ENGREMIAT_CORE\tools\launcher\runtime-ui-adapter\launcher-runtime-ui-adapter.readonly.ps1 modified=2026-06-20 15:10:51
- 8. score=80 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO.ps1 modified=2026-06-20 08:58:39
- 9. score=80 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-STATUS.ps1 modified=2026-06-20 08:52:05
- 10. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARD-DETAIL-VIEW-NORMALIZED.ps1 modified=2026-06-20 14:44:05
- 11. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1 modified=2026-06-20 14:02:37
- 12. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MODULE-CARDS-BRIDGE.ps1 modified=2026-06-20 13:41:37
- 13. score=60 path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1 modified=2026-06-20 13:08:48
- 14. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1 modified=2026-06-20 10:17:28
- 15. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1 modified=2026-06-20 10:14:05
- 16. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER.ps1 modified=2026-06-20 09:40:57
- 17. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER.ps1 modified=2026-06-20 09:24:44
- 18. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-CARDS.ps1 modified=2026-06-20 08:35:57
- 19. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-SELECT-MODULE-WORKSPACE.ps1 modified=2026-06-20 08:35:57
- 20. score=60 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECT-MEMORY.ps1 modified=2026-06-20 08:05:57
- 21. score=60 path=C:\ENGREMIAT_CORE\launchers\ENGREMIAT_OPERADOR_SIMPLE.ps1 modified=2026-06-20 00:19:04
- 22. score=40 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-UPDATE-HELPER.ps1 modified=2026-06-20 13:14:52
- 23. score=40 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-HEALTH.ps1 modified=2026-06-20 13:08:48
- 24. score=40 path=C:\ENGREMIAT_CORE\data\real-execution-launcher-186\real-execution-launcher.ps1 modified=2026-06-17 18:29:18
- 25. score=40 path=C:\ENGREMIAT_CORE\data\real-execution-launcher-185\launcher-monitor.ps1 modified=2026-06-17 18:26:32

## Best candidate
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Regla
NO_APPLY. Este paso solo localiza candidatos. No modifica launcher, no git, no adapter.

## Siguiente
E03C_REAUDIT_PATTERN_WITH_DETECTED_LAUNCHER_NO_APPLY
