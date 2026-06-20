# OPENCLAW READ ONLY LAB GATE 001

## Decision
OpenClaw no puede instalarse ni ejecutarse hasta que el humano apruebe explicitamente una prueba READ_ONLY aislada.

## Estado actual
openclaw_installed=False
openclaw_executed=False
install_allowed=False
execution_allowed=False
read_only_lab_designed=True

## Autorizacion requerida
Para pasar de diseno a instalacion/laboratorio, el humano debe devolver una frase explicita como:

AUTORIZO_OPENCLAW_READONLY_LAB_001_NO_WRITE_NO_SECRETS_NO_TELEGRAM_NO_EXECUTION_ACTIONS

## Alcance autorizado futuro si se aprueba
- Preparar entorno aislado.
- Usar solo paquete read-only.
- Sin credenciales.
- Sin Telegram real.
- Sin escritura.
- Sin ejecucion de comandos desde OpenClaw.
- Sin repo completo.
- Sin acceso a .env.

## NO autorizado
- Acciones externas.
- Skills externas.
- Escritura en filesystem.
- Comandos shell.
- Docker/DB/Git.
- Telegram real.
- APIs externas.
- Secretos.
