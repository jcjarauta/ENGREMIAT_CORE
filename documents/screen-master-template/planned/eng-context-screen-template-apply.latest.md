# E12 apply eng-context screen template

## Status
PASS

## Applied
- target: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-context.ps1
- backup: 
C:\ENGREMIAT_CORE\backups\screen-master-template\eng-context.before-e12-screen-template-20260620-204223.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\eng-context.screen-master-candidate.latest.ps1

## Checks
- target_parse_before: True
- candidate_parse: True
- target_parse_after: True
- has_footer: True
- has_m: True
- has_b: True
- has_q: True
- has_help: True
- has_cancel: True
- has_backup: True

## Manual smoke
Ejecutar la ruta que invoque eng-context y validar: Enter vuelve/refresca, b/q vuelve, ? ayuda, m tarjeta cancelable.

## Next
E13_MANUAL_TEST_ENG_CONTEXT_SCREEN_TEMPLATE
