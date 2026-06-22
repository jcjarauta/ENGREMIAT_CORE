# E40 Manual sample test command legend

## Objetivo
Validar manualmente que la leyenda comun no ha roto navegacion ni comandos.

## Leyenda esperada
`[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar`

## Muestra sugerida
- C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-context.ps1
- C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-library-import.ps1
- C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-module-artifact.ps1
- C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARD-DETAIL-VIEW-NORMALIZED.ps1
- C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-CARDS-VIEW-NORMALIZED.ps1
- C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER.ps1
- C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
- C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1

## Prueba en cada pantalla
1. Abrir pantalla.
2. Confirmar que se ve la leyenda comun.
3. Pulsar Enter vacio: debe refrescar/redibujar.
4. Pulsar `?`: si la pantalla tiene ayuda/router, debe abrir ayuda; si no, no debe romper flujo.
5. Pulsar `m`: debe abrir mantenimiento si la pantalla tiene router; si no, no debe romper flujo.
6. Pulsar `b` y `q`: deben volver/salir segun corresponda.
7. Probar una opcion numerica normal si existe.

## Resultado que debes devolver
`E40_OK muestra leyenda/comandos funciona`

o

`E40_FAIL pantalla=<ruta o nombre> comando=<comando> resultado=<qué muestra>`

## Si E40_OK
Siguiente: E41_PREPARE_SCOPED_GIT_CLOSE_NO_ADD_DOT
