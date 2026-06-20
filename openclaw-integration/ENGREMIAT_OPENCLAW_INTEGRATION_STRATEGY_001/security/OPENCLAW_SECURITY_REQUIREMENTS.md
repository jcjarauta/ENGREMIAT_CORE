# OPENCLAW SECURITY REQUIREMENTS - ENGREMIAT

## Principio
OpenClaw debe tratarse como runtime agente sensible porque puede combinar LLM, herramientas, skills, canales y acciones locales.

## Riesgos principales
- Ejecucion de comandos o herramientas.
- Skills de terceros no auditadas.
- Acceso amplio a archivos locales.
- Credenciales persistentes.
- Prompt injection.
- Acciones desde canales externos.
- Deriva de permisos.
- Sincronizacion accidental con informacion sensible.

## Requisitos de seguridad
1. Aislamiento: no ejecutar en entorno principal con acceso completo.
2. Read-only first: primera prueba sin escritura ni ejecucion.
3. No secrets: no tokens, no .env, no cuentas reales.
4. Volumen minimo: solo paquete curado.
5. Gate humano: cualquier accion requiere autorizacion explicita.
6. Logs: registrar entrada, salida, decision, riesgo y evidencia.
7. No skills externas: no instalar skills comunitarias sin auditoria.
8. No Telegram real al inicio: simular entradas antes.
9. Rollback documentado.
10. Parada inmediata ante comportamiento no esperado.

## Politica de terceros
Toda skill o extension externa debe considerarse no confiable hasta ser auditada.

## Estado actual
openclaw_install_allowed=False
openclaw_execution_allowed=False
read_only_lab_allowed=PREP_ONLY
