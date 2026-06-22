# E05F rollback broken INICIO commands after m guard

## Decision
GO_ROLLBACK_E05D_DONE_INICIO_PARSE_OK

## Motivo
Tras E05D no funcionaban b/q, m ni Enter. Se restaura backup previo a E05D.

## Paths
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- restored_from_backup: 
C:\ENGREMIAT_CORE\backups\manual-screen-maintenance-cards\ENGREMIAT-INICIO-NORMALIZED.before-e05d-m-guard-after-readhost-20260620-194145.ps1

## Checks
- backup_parse: 
True
- inicio_parse_after: 
True
- guard_removed: 
True
- hint_still_present: 
True

## Hashes
- before_rollback_sha256: 
959D65427E0913291BC842184DBE00DBF18142A5874954281C611F2DC3C45EE8
- backup_sha256: 
7DD2DF350B29E5353F4F4C620C24B21A41F3E1EB6804134A03A0133E3524BED6
- after_rollback_sha256: 
7DD2DF350B29E5353F4F4C620C24B21A41F3E1EB6804134A03A0133E3524BED6

## Next
E05G_DEEP_AUDIT_INICIO_MAIN_ROUTER_READHOST_NO_APPLY
