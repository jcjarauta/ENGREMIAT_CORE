# E08B mapa readonly de plantillas duplicadas

## Estado
No se ha modificado nada.

## Hallazgo principal
Hay dos plantillas maestras o fuentes maestras en lugares diferentes:

1. Plantilla activa actual:
C:\Users\pc\Desktop\ENGREMIAT_OPERATOR\ENGREMIAT_PROJECT_p3_20260619-224903\BOVEDA_PROYECTO\00_PLANTILLA_MAESTRA_OFICIAL

2. Maestro original rico dentro del proyecto:
C:\Users\pc\Desktop\ENGREMIAT_OPERATOR\ENGREMIAT_PROJECT_p3_20260619-224903\ARCHIVOS\PLANTILLAS\MAESTRO_ORIGINAL

Tambien existe la referencia de MODULE_inicio:
C:\Users\pc\Desktop\ENGREMIAT_OPERATOR\ENGREMIAT_PROJECT_p3_20260619-224903\MODULOS\MODULE_inicio\BOVEDA_MODULO\00_PLANTILLA_MAESTRA_REFERENCIA

## Lectura
La plantilla activa quedo demasiado limpia. El maestro original archivado conserva mucha mas informacion y debe tratarse como fuente rica para reconstruccion conservadora.

## Regla desde ahora
- No restaurar directo todavia.
- No usar la plantilla minima como verdad.
- No borrar MAESTRO_ORIGINAL.
- No tocar MODULE_inicio sin comparativa previa.

## Siguiente seguro
Crear comparativa rich_vs_active y decidir que partes del MAESTRO_ORIGINAL pasan a plantilla oficial, manteniendo contrato 00_CONTROL.

## Reportes
JSON: C:\ENGREMIAT_CORE\reports\template-improvement\e08b-template-map\e08b-duplicated-master-template-map.json
TSV: C:\ENGREMIAT_CORE\reports\template-improvement\e08b-template-map\e08b-template-candidates.tsv
