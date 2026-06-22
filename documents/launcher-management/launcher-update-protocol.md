# Launcher Update Protocol

Estado: PASS

Entrada humana estable: `C:\ENGREMIAT_CORE\ENGREMIAT.ps1`

Principio: el humano ejecuta siempre el launcher estable; los launchers internos se pueden actualizar solo con backup, parse, registry y health.

## Reglas
1. No cambiar el nombre del launcher humano estable sin migracion explicita.
2. Crear backup antes de modificar launchers internos.
3. Ejecutar ParseOk despues de modificar.
4. Actualizar registry si cambia ruta, nombre o rol.
5. Ejecutar health antes de validacion humana.
6. Crear reporte PASS/FAIL.
7. No ejecutar workers reales desde este protocolo.
8. No usar git, red ni APIs externas en esta fase.

## Secuencia
1. BACKUP launcher objetivo.
2. APPLY cambio local.
3. PARSEOK launcher objetivo.
4. UPDATE_REGISTRY si aplica.
5. HEALTH all launchers.
6. HUMAN_VALIDATION si cambia UX.
7. REPORT close.

Next: E87D_CREATE_LAUNCHER_UPDATE_HELPER_DRY_RUN
