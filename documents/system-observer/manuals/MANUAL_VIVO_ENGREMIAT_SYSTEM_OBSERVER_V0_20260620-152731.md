# MANUAL VIVO ENGREMIAT - System Observer v0

## 1. Que es este sistema
ENGREMIAT es un sistema local-first de desarrollo, observacion, decision humana y ejecucion controlada. En esta etapa dispone de runtime canonico de acciones, adaptador readonly de launcher y observador inicial.

## 2. Estado actual observado
- Madurez global: 69 / STABLE_ENOUGH
- JSON detectados: 4294
- Markdown detectados: 2823
- PowerShell detectados: 502
- Reports JSON detectados: 1656
- Modo del observador: READONLY_NO_MUTATION

## 3. Componentes consolidados
- Runtime canonico de acciones: contrato, preview, gate, autorizacion, unlock, plan, runner, ejecucion local y cierre con evidencia.
- Integracion UI runtime: adaptador readonly, marcador en launcher real, rutas readonly validadas y comandos sensibles bloqueados.
- System Observer: contrato, 12 dimensiones, politica de seguridad, inventario minimo y diagnostico v0.

## 4. Como se usa ahora
1. Ejecutar bloques del observador desde la raiz C:\ENGREMIAT_CORE.
2. Leer inventario y diagnosticos generados en documents/system-observer.
3. Usar el manual vivo como resumen operativo regenerable.
4. Convertir mejoras en tareas en las siguientes fases.
5. No ejecutar mejoras automaticamente: cualquier accion real debe pasar por gate humano y runtime canonico.

## 5. Dimensiones diagnosticas
- Arquitectura [architecture]: score 93 / STRONG. Mejora recomendada: usar runtime canonico para convertir mejoras en acciones gobernadas
- Software [software]: score 62 / STABLE_ENOUGH. Mejora recomendada: ampliar evidencias de la dimension
- Hardware [hardware]: score 55 / WEAK. Mejora recomendada: crear inventario hardware por nodo main/legacy/raspberry/mobile
- Humanos [humans]: score 68 / STABLE_ENOUGH. Mejora recomendada: medir friccion humana por numero de pasos, Enter/clicks y gates
- Financiacion [financing]: score 42 / WEAK. Mejora recomendada: crear presupuesto operativo, costes por hardware/software/humano y necesidades de financiacion
- Documentacion [documentation]: score 78 / STABLE_ENOUGH. Mejora recomendada: generar manual vivo desde evidencias cerradas
- Seguridad y limites [security]: score 88 / STRONG. Mejora recomendada: convertir politicas en validador automatico por objetivo
- UX operador [ux]: score 78 / STABLE_ENOUGH. Mejora recomendada: insertar ruta interactiva real runtime/acciones en menu principal
- Workers e IA [workers]: score 58 / WEAK. Mejora recomendada: usar IA local solo como worker interpretativo despues de diagnostico determinista
- Crecimiento y deuda [growth]: score 56 / WEAK. Mejora recomendada: crear limpieza, indices latest y compactacion de evidencias
- Gobernanza [governance]: score 76 / STABLE_ENOUGH. Mejora recomendada: crear tablero de decisiones y prioridades desde reports
- Operacion diaria [operations]: score 74 / STABLE_ENOUGH. Mejora recomendada: crear comando diario observer: estado, diagnostico, manual, tareas

## 6. Riesgos principales
- volumen alto de scripts PowerShell; riesgo de duplicacion y deuda tecnica
- diagnostico hardware aun superficial; falta leer perfiles y limites por nodo
- aun no existe metrica automatica de carga humana
- dimension financiera sin evidencias estructuradas todavia
- mucho markdown sin manual vivo consolidado puede dispersar conocimiento
- hook actual es marcador, no navegacion profunda final
- workers/Ollama/Cline no integrados al observer todavia
- crecimiento documental alto; riesgo de ruido, duplicados y dificultad de busqueda

## 7. Oportunidades principales
- usar runtime canonico para convertir mejoras en acciones gobernadas
- crear inventario hardware por nodo main/legacy/raspberry/mobile
- medir friccion humana por numero de pasos, Enter/clicks y gates
- crear presupuesto operativo, costes por hardware/software/humano y necesidades de financiacion
- generar manual vivo desde evidencias cerradas
- convertir politicas en validador automatico por objetivo
- insertar ruta interactiva real runtime/acciones en menu principal
- usar IA local solo como worker interpretativo despues de diagnostico determinista
- crear limpieza, indices latest y compactacion de evidencias
- crear tablero de decisiones y prioridades desde reports
- crear comando diario observer: estado, diagnostico, manual, tareas

## 8. Limites de seguridad
- El observador no modifica archivos criticos fuera de documents/system-observer y reports/system-observer.
- No ejecuta workers.
- No abre navegador.
- No usa red.
- No hace git.
- No aprueba decisiones.
- No realiza acciones financieras.

## 9. Siguiente evolucion
- E05: generar propuestas de mejora v0.
- E06: clasificar propuestas como tareas accionables.
- E07: exportar tareas a TSV para Sheets/Kanban.
- E08: preparar conversion de tareas en acciones canonicas con gate humano.

## 10. Fuentes usadas
- Contrato: C:\ENGREMIAT_CORE\documents\system-observer\contracts\system-observer-contract.latest.json
- Inventario: C:\ENGREMIAT_CORE\documents\system-observer\inventory\system-observer-readonly-inventory.latest.json
- Diagnostico: C:\ENGREMIAT_CORE\documents\system-observer\diagnostics\system-observer-diagnostic-v0.latest.json
