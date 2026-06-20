# MODULE_OPERATIONAL_BLUEPRINT

## Decision
Un modulo ENGREMIAT no copia la plantilla maestra. Un modulo es una unidad operativa con identidad, tarjetas, gates, evidencias, workers y relaciones.

## Estructura limpia
MODULE_<slug>/BOVEDA_MODULO contiene control, home, tarjetas, proceso, gates, evidencias, resultados, workers y relaciones.

## Centro operativo
La tarjeta es el atomo de trabajo. Cada modulo nace con cards.tsv y module-cards.json.

## Integracion proyecto
Al crear un modulo se actualizan MODULES_INDEX, TASKS_INDEX y SYSTEM_GROUPING_MODEL del proyecto.

## Siguiente
E21B implementa a = añadir modulo desde la pantalla MODULOS DEL PROYECTO.
