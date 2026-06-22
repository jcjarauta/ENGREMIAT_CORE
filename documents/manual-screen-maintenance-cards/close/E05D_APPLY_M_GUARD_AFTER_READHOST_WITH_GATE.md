# E05D apply m guard after ReadHost

## Decision
GO_M_GUARD_AFTER_READHOST_APPLIED_WITH_BACKUP_AND_STATIC_SMOKE_PASS

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
- guard_present: 
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
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\planned\ENGREMIAT-INICIO-NORMALIZED.m-guard-after-readhost-selected.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\manual-screen-maintenance-cards\ENGREMIAT-INICIO-NORMALIZED.before-e05d-m-guard-after-readhost-20260620-194145.ps1
- cards_dir: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards

## Hashes
- before_sha256: 
7DD2DF350B29E5353F4F4C620C24B21A41F3E1EB6804134A03A0133E3524BED6
- selected_sha256: 
959D65427E0913291BC842184DBE00DBF18142A5874954281C611F2DC3C45EE8
- backup_sha256: 
7DD2DF350B29E5353F4F4C620C24B21A41F3E1EB6804134A03A0133E3524BED6
- after_sha256: 
959D65427E0913291BC842184DBE00DBF18142A5874954281C611F2DC3C45EE8

## Next
E05E_MANUAL_TEST_M_CONTEXTUAL_CARD_FROM_INICIO_AFTER_GUARD
