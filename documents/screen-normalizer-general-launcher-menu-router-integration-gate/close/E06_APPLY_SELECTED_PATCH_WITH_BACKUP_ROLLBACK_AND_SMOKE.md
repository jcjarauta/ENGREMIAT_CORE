# E06 apply selected patch with backup rollback and smoke

## Decision
GO_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

## Apply
- Apply now: true
- Launcher write: true
- Git write: false
- Rollback done: false

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Selected planned
C:\ENGREMIAT_CORE\documents\screen-normalizer-general-launcher-menu-router-integration-gate\planned\Start-EngremiatDesktopOperator.menu-router-adapter-selected.latest.ps1

## Backup
C:\ENGREMIAT_CORE\backups\screen-normalizer-general-launcher-menu-router-integration-gate\Start-EngremiatDesktopOperator.before-e06-20260620-190023.ps1

## Checks
- launcher_parse_before: 
True
- selected_parse: 
True
- launcher_parse_after: 
True
- menu_found: 
True
- route_found: 
True
- adapter_found: 
True

## Integration
- option: 
10
- input variable: $
suggested
- flow: 
return

## Hashes
- before_sha256: 
54255998DEDE706155450FC5622C12E878069C1D3EC142F0C5BCF0E43ABF7E4D
- selected_sha256: 
F61573AA4877633D56B541F3379F494468E368F463877E101F9FB59D0225B092
- backup_sha256: 
54255998DEDE706155450FC5622C12E878069C1D3EC142F0C5BCF0E43ABF7E4D
- after_sha256: 
F61573AA4877633D56B541F3379F494468E368F463877E101F9FB59D0225B092

## Siguiente
E07_CREATE_OR_VALIDATE_SCREEN_NORMALIZER_ADAPTER_FILE_NO_DANGER
