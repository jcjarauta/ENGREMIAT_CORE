# DEV_SYSTEM_GUIDE

## Propósito
ENGREMIAT_DEV_SYSTEM_001 es una infraestructura ligera de desarrollo asistido para ejecutar la hoja etapa-bloque-paso con menos fricción humana.

## Regla principal
El humano decide. El sistema prepara, ejecuta, valida, registra y resume.

## Componentes
- DEV_ARTIFACT_REGISTRY: registra rutas de artefactos.
- DEV_CONTEXT_SNAPSHOT: permite retomar contexto.
- DEV_RUNNER: detecta fila activa y ejecuta paquetes seguros.
- DEV_GATE_CENTER: centraliza autorizaciones humanas.
- DEV_READINESS_CHECKER: mide preparación real.
- DEV_ERROR_MEMORY: evita repetir errores.
- DEV_DOC_SYNC: regenera documentación viva.
- DEV_DASHBOARD: muestra NOW/NEXT/BLOCKED/GATES/ARTIFACTS/ERRORS/READINESS.
- DEV_COMMAND_HUB: unifica comandos en eng.ps1.

## Comandos previstos
```powershell
.\eng.ps1 status
.\eng.ps1 next
.\eng.ps1 run-safe
.\eng.ps1 artifacts
.\eng.ps1 context
.\eng.ps1 gates
.\eng.ps1 readiness
.\eng.ps1 errors
.\eng.ps1 docs
.\eng.ps1 dashboard
```

## Normas activas
- LOCAL_FIRST
- EVIDENCE_FIRST
- NO_REMOTE_BY_DEFAULT
- NO_EXTERNAL_NETWORK_BY_DEFAULT
- NO_SECRETS
- NO_REAL_ACTION_WITHOUT_GATE
- FAIL_CLOSED
- ARTIFACTS_REGISTERED_OR_NOT_VALIDATED

## Cierre de bloque
Un bloque no puede pasar a VALIDATED si falta contrato, política, guía o reporte de validación.
