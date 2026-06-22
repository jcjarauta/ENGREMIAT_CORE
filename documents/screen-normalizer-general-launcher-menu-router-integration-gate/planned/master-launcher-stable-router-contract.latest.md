# Master launcher stable router contract

## Decision
GO_ADOPT_MASTER_LAUNCHER_AS_ROUTER_DO_NOT_PATCH_VISUAL_MENU_MORE

## Principle
El launcher usado en PC debe ser el launcher maestro estable de inicio. Su responsabilidad principal no es acumular opciones funcionales, sino enrutar hacia launchers versionados/normalizados vigentes.

## Consequence
No seguir parcheando opciones funcionales como [6] en el menu visual del maestro. La prueba del adapter debe validarse en la ruta versionada vigente: maestro -> INICIO/launcher actual -> operador versionado -> opcion [10] adapter.

## Required behavior
1. ENGREMIAT.ps1 mantiene nombre estable.
2. ENGREMIAT.ps1 debe mostrar o registrar a que version/ruta enruta.
3. Las opciones funcionales profundas viven en INICIO/launchers versionados, no en el maestro.
4. Si se necesita acceso diagnostico directo, debe estar en una zona de Launchers/configuracion, no como menu principal permanente.
5. Worker real sigue pausado; no se activa para esta integracion.

## Current checks
- stable_parse: 
True
- inicio_parse: 
True
- operator_parse: 
True
- adapter_parse: 
True
- stable_has_6_experimental: 
True
- stable_routes_inicio: 
True
- inicio_routes_operator: 
True
- operator_has_10: 
True
- operator_routes_adapter: 
True
- adapter_readonly: 
True
- static_ok: 
True

## Paths
- master_launcher: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1
- inicio_launcher: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- operator_launcher: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1
- adapter: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Next technical direction
Preparar limpieza del acceso experimental [6] en ENGREMIAT.ps1 si procede, y preparar auditoria/normalizacion de la ruta maestro -> INICIO -> operador sin usar la pantalla WORKERS PAUSADO como puente.

## Rule
NO_APPLY. Este contrato no modifica archivos de runtime ni git.
