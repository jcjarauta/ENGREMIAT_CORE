# E05P fix INICIO b/q return

## Decision
GO_INICIO_BQ_RETURN_FIXED_M_STILL_PRESENT

## Correccion
`b` y `q` pasan de `break` a `return` para salir del script INICIO desde dentro del switch.

## Checks
- parse_before: 
True
- parse_after: 
True
- b_return: true
- q_return: true
- m_route: true

## Paths
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\manual-screen-maintenance-cards\ENGREMIAT-INICIO-NORMALIZED.before-e05p-fix-bq-return-20260620-195847.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\planned\ENGREMIAT-INICIO-NORMALIZED.fix-bq-return.latest.ps1

## Hashes
- before_sha256: 
FD627958791EC87AD59AD1DADCB3E5C224A2D133D0988A3520E6984252121BFA
- backup_sha256: 
FD627958791EC87AD59AD1DADCB3E5C224A2D133D0988A3520E6984252121BFA
- after_sha256: 
E744978DE53C02E02B874E69601446CC59A46AF6A43099634EA6AB104C436026

## Next
E05Q_MANUAL_TEST_ENTER_B_Q_M_FROM_INICIO_FINAL
