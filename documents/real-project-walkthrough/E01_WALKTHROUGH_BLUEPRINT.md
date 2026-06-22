# E01 Walkthrough Blueprint

## Objetivo
Construir el primer proyecto real de Engremiat usando elementos reales del sistema, detectando carencias mientras se recorre el operador.

## Proyecto real objetivo
`
ENGREMIAT_PROJECT_operador-real-001
`

## Regla del recorrido
Cada fallo encontrado se convierte en tarjeta o carencia. Cada paso correcto se convierte en contrato estable. No se da por cerrada la normalizacion de menus; se corrige progresivamente durante el recorrido.

## Modulos iniciales
- MODULE_01_recorrido_integral_y_carencias
- MODULE_02_navegacion_y_pantallas
- MODULE_03_proyectos_modulos_tarjetas
- MODULE_04_decisiones_gates_evidencias
- MODULE_05_workers_y_ejecucion_asistida
- MODULE_06_dashboard_memoria_y_cierre

## Tarjetas iniciales
- T01 Crear o seleccionar proyecto real desde INICIO > Proyectos
- T02 Crear modulos base del proyecto
- T03 Crear tarjetas reales de mejora
- T04 Probar navegacion y comandos comunes
- T05 Detectar pantallas con leyenda visual pero sin router real
- T06 Ejecutar una mejora pequena real
- T07 Registrar evidencias y carencias
- T08 Valorar siguiente ciclo

## Recorrido minimo
1. INICIO
2. INICIO > Proyectos
3. Crear/seleccionar proyecto real
4. Entrar al proyecto
5. Crear modulos
6. Crear tarjetas
7. Probar navegacion, ayuda, mantenimiento, volver y refrescar
8. Ejecutar una mejora pequena real
9. Registrar evidencia y siguiente objetivo

## Criterios de carencia
- Falta opcion volver/salir/refrescar.
- La leyenda dice m/? pero el comando no funciona.
- No se entiende la ruta o el proyecto activo.
- No se puede crear modulo/tarjeta desde pantalla esperada.
- No queda evidencia clara.
- El humano no sabe cual es el siguiente paso.

## Primer paso manual
Abrir INICIO > Proyectos y comprobar si existe opcion para crear proyecto nuevo o seleccionar proyecto.

## Resultado esperado del usuario
Devolver pantalla actual o indicar: `E02_READY_INICIO_PROYECTOS pantalla=<texto>`
