# E05N_BIS rewrite INICIO router multiline stable with m

## Decision
GO_INICIO_ROUTER_REWRITTEN_MULTILINE_STABLE_WITH_M_BIS

## Qué se corrige
El router principal estaba en una sola línea y los parches quedaban fuera del while/switch. Se reescribe en formato multilinea estable con m dentro del switch real.

## Checks
- selected_parse: 
True
- parse_before: 
True
- parse_after: 
True
- after_ok: 
True

## Paths
- inicio: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- selected: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\planned\ENGREMIAT-INICIO-NORMALIZED.multiline-stable-router-with-m.bis.latest.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\manual-screen-maintenance-cards\ENGREMIAT-INICIO-NORMALIZED.before-e05n-bis-multiline-stable-router-20260620-195619.ps1

## Hashes
- before_sha256: 
D55628A2DA87792B4A4920306368359C5C1ED6D81FCD0EA4F76C71142C2F2739
- backup_sha256: 
D55628A2DA87792B4A4920306368359C5C1ED6D81FCD0EA4F76C71142C2F2739
- after_sha256: 
FD627958791EC87AD59AD1DADCB3E5C224A2D133D0988A3520E6984252121BFA

## Next
E05O_MANUAL_TEST_ENTER_B_Q_M_FROM_INICIO
