# E09 close menu router integration gate

## Decision
CLOSED_STATIC_OK_MANUAL_SMOKE_PENDING_FROM_NORMAL_LAUNCHER

## Estado
- Static smoke: 
True
- Manual smoke: pending_from_normal_launcher
- Open terminal automatically: false
- Launcher write: false
- Adapter write: false
- Git write: false

## Checks
- launcher_parse: 
True
- adapter_parse: 
True
- option_10_visible_in_launcher: 
True
- route_present: 
True
- adapter_readonly: 
True

## Paths
- launcher: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1
- source_report: 
C:\ENGREMIAT_CORE\reports\screen-normalizer-general-launcher-menu-router-integration-gate\e08e-bis-validate-no-open-terminal-readonly-20260620-190538.json

## Hashes
- launcher_sha256: 
7C09A41A74F467FC4AD4392F5ED858FDA377D43CE07905891ADB9104F6772B9F
- adapter_sha256: 
109FC8676BF4DE9B833D504A174717AD0316E585862F261E7FFE030204FBFE19

## Resultado operativo
La integracion queda cerrada a nivel estatico. No se debe volver a lanzar el operador con Start-Process desde estos smokes porque rompe/duplica terminal. La comprobacion manual debe hacerse desde el acceso normal que ya funciona.

## Prueba manual pendiente
Abrir ENGREMIAT desde el acceso normal, confirmar que aparece [10], pulsar 10 y devolver:
`
E08E_OK opcion 10 visible y abre adapter seguro
`

## Siguiente recomendado
E10_CLOSE_STAGE_AFTER_MANUAL_OK_OR_REPAIR_IF_FAIL
