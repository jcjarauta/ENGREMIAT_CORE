# DECISION - OPENCLAW INSTALLATION DEFERRED

## Decision
ENGREMIAT aplaza la instalacion de OpenClaw hasta preparar un laboratorio aislado READ_ONLY con gate humano.

## Motivo
OpenClaw puede aportar valor como capa agente/gateway, pero tambien incrementa superficie de ataque si tiene acceso a herramientas, skills, credenciales o filesystem amplio.

## Condiciones para cambiar a GO
- Laboratorio aislado definido.
- Paquete read-only preparado.
- Sin credenciales reales.
- Sin Telegram real.
- Sin escritura.
- Sin ejecucion de comandos.
- Criterios PASS/WARN/FAIL claros.

## Estado
install_deferred=True
strategy_continues=True
next=B04_DESIGN_ISOLATED_READONLY_LAB
