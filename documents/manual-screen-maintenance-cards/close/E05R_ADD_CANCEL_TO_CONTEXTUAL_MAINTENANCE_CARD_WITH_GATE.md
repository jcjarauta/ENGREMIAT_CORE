# E05R add cancel to contextual maintenance card

## Decision
GO_CONTEXTUAL_MAINTENANCE_CARD_CANCEL_ADDED

## Correccion
La tarjeta contextual ya permite cancelar con b, q, c, cancelar, cancel o salir en cualquier campo. No bloquea el flow.

## Checks
- parse_after: true
- cancel_present: true
- m_route: true
- bq_return: true

## Paths
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\planned\ENGREMIAT-INICIO-NORMALIZED.maintenance-card-cancel.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\manual-screen-maintenance-cards\ENGREMIAT-INICIO-NORMALIZED.before-e05r-maintenance-card-cancel-20260620-200217.ps1

## Hashes
- before_sha256: 
E744978DE53C02E02B874E69601446CC59A46AF6A43099634EA6AB104C436026
- backup_sha256: 
E744978DE53C02E02B874E69601446CC59A46AF6A43099634EA6AB104C436026
- after_sha256: 
E6418BF6B525F7F5EC9D6B27D28AE215C6D7435CE392CBFFB5E44C7886D12C42

## Next
E05S_MANUAL_TEST_M_CANCEL_AND_CREATE_CARD
