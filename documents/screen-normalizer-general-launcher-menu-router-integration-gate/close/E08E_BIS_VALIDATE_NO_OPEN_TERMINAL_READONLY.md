# E08E_BIS validate no open terminal readonly

## Decision
GO_STATIC_SMOKE_OK_MANUAL_TEST_FROM_NORMAL_LAUNCHER

## Motivo
Se evita Start-Process / apertura automatica de terminal porque la terminal rompe o duplica contexto.

## Checks
- launcher_parse: 
True
- adapter_parse: 
True
- option_visible: 
True
- route_present: 
True
- adapter_readonly: 
True
- preflight_ok: 
True

## Launcher
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1

## Adapter
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\screen-normalizer-general-launcher-adapter.ps1

## Menu lines detected
   74:     L " [1] Abrir proyecto     p" Green
   75:     L " [2] Nuevo proyecto     n" Green
   76:     L " [3] Ver proyectos" Green
   77:     L " [4] Estado compacto    e" Green
   78:     W " [10] Screen normalizer adapter" Cyan
   79:     L " [q] Salir" Yellow
  217:   Write-Host " [10] Screen normalizer adapter" -ForegroundColor Cyan

## Prueba manual recomendada
Abrir el operador desde el acceso normal que ya funciona, no desde script automatico. En el menu GLOBAL comprobar [10], pulsar 10 y devolver:
- E08E_OK opcion 10 visible y abre adapter seguro
- E08E_FAIL + comportamiento observado

## Seguridad
Sin apertura automatica, sin git, sin acciones externas.

