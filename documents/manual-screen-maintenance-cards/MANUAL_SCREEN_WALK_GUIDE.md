# Recorrido manual de pantallas y tarjetas de mantenimiento

## Objetivo
Navegar manualmente por las pantallas principales y convertir cada fallo en una tarjeta de mantenimiento con evidencia.

## Regla
No reparar durante el recorrido. Primero capturar evidencia. Después priorizar y reparar una frontera técnica cada vez.

## Pantallas a recorrer
- S01_MASTER_LAUNCHER :: ENGREMIAT.ps1 :: esperado: Launcher humano estable; opciones 1..5 y b/q; no menu profundo experimental
- S02_INICIO :: ENGREMIAT.ps1 -> [1] Inicio operador :: esperado: Pantalla INICIO; opciones Proyectos, Memoria, Control, Launchers, Operador y workers, Tarjetas, Ayuda
- S03_PROYECTOS :: INICIO -> [1] Proyectos :: esperado: Listado/proyectos y navegacion atras clara
- S04_MEMORIA_DOCS :: INICIO -> [2] Memoria y documentacion :: esperado: Acceso a memoria/documentacion sin romper flujo
- S05_CONTROL_ESTADO :: INICIO -> [3] Control y estado :: esperado: Estado compacto/health sin acciones peligrosas
- S06_LAUNCHERS_CONFIG :: INICIO -> [4] Launchers y configuracion :: esperado: Gestion de launchers/versiones/configuracion
- S07_OPERADOR_WORKERS :: INICIO -> [5] Operador y workers :: esperado: Worker real pausado o acceso controlado; no romper terminal
- S08_TARJETAS :: INICIO -> [6] Tarjetas :: esperado: Tarjetas o mantenimiento accesible
- S09_OPERATOR_VERSIONED :: launcher versionado operador :: esperado: Operador versionado con opciones visibles y adapter [10] si aplica
- S10_SCREEN_NORMALIZER_ADAPTER :: operador -> [10] :: esperado: SAFE_READONLY_NO_DANGER; ACCIONES REALES: ninguna

## Cómo registrar un fallo
Ejecuta este mismo bloque y usa la opción interactiva de tarjeta al final, o crea una tarjeta manual copiando la plantilla.

## Archivos
- queue: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\MAINTENANCE_QUEUE.json
- cards: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\cards
- evidence: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\evidence
- template: 
C:\ENGREMIAT_CORE\documents\manual-screen-maintenance-cards\MAINTENANCE_CARD_TEMPLATE.md
