# OPENCLAW BOUNDARIES POLICY

## Principio
OpenClaw no debe recibir permisos de accion hasta que ENGREMIAT tenga contratos, gates humanos, evidencias y limites tecnicos claros.

## Permitido ahora
- Documentar arquitectura.
- Definir casos de uso.
- Preparar laboratorio read-only.
- Leer documentos preparados manualmente.
- Proponer siguientes acciones sin ejecutarlas.

## Prohibido ahora
- Ejecutar comandos.
- Modificar archivos.
- Usar credenciales.
- Enviar mensajes externos.
- Sincronizar Obsidian con Open WebUI.
- Controlar Telegram real.
- Acceder a API externas.
- Actuar sobre Git, Docker, DB, navegador o sistema operativo.

## Gates futuros
Toda accion futura debe declarar: accion, riesgo, entrada, salida, rollback, evidencia, autorizacion humana y modo de ejecucion.

## Regla
READ_ONLY primero. GATED_ACTION despues. Nunca AUTONOMOUS_UNGOVERNED_AGENT.
