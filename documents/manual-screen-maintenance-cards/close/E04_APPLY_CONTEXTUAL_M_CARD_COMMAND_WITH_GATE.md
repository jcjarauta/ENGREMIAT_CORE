# E04 apply contextual m maintenance card command

## Decision
GO_CONTEXTUAL_M_CARD_COMMAND_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

## Apply
- Apply now: true
- INICIO write: true
- Git write: false
- Rollback done: false

## Checks
- inicio_parse_before: 
True
- selected_parse: 
True
- inicio_parse_after: 
True
- function_present: 
True
- hint_present: 
True
- route_present: 
True
- base_exists: 
True

## Paths
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\planned\ENGREMIAT-INICIO-NORMALIZED.contextual-m-card-selected.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\manual-screen-maintenance-cards\ENGREMIAT-INICIO-NORMALIZED.before-e04-contextual-m-card-20260620-193832.ps1
- cards_dir: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards
- queue: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\MAINTENANCE_QUEUE.json

## Hashes
- before_sha256: 
F1F6EDD55AC784CAC5227919A54EDC143F84419FC274CF12179FB34C54953A99
- selected_sha256: 
7DD2DF350B29E5353F4F4C620C24B21A41F3E1EB6804134A03A0133E3524BED6
- backup_sha256: 
F1F6EDD55AC784CAC5227919A54EDC143F84419FC274CF12179FB34C54953A99
- after_sha256: 
7DD2DF350B29E5353F4F4C620C24B21A41F3E1EB6804134A03A0133E3524BED6

## Next
E05_MANUAL_TEST_M_CONTEXTUAL_CARD_FROM_INICIO
