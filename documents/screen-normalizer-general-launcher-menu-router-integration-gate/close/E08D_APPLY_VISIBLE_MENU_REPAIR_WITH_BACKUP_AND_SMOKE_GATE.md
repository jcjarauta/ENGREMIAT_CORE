# E08D apply visible menu repair

## Decision
GO_VISIBLE_MENU_REPAIR_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

## Apply
- Apply now: true
- Launcher write: true
- Git write: false
- Rollback done: false

## Checks
- launcher_parse_before: 
True
- selected_parse: 
True
- launcher_parse_after: 
True
- option_visible: 
True
- route_present: 
True
- adapter_exists: 
True

## Paths
- launcher: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.option-10-visible-menu-selected.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-normalizer-general-launcher-menu-router-integration-gate\Start-EngremiatDesktopOperator.before-e08d-visible-menu-20260620-190402.ps1

## Hashes
- before_sha256: 
F61573AA4877633D56B541F3379F494468E368F463877E101F9FB59D0225B092
- selected_sha256: 
7C09A41A74F467FC4AD4392F5ED858FDA377D43CE07905891ADB9104F6772B9F
- backup_sha256: 
F61573AA4877633D56B541F3379F494468E368F463877E101F9FB59D0225B092
- after_sha256: 
7C09A41A74F467FC4AD4392F5ED858FDA377D43CE07905891ADB9104F6772B9F

## Next
E08E_SMOKE_LAUNCHER_OPTION_10_MANUAL_AFTER_VISIBLE_REPAIR
