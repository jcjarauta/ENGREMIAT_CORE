# MEMORY_CONTRACT

## Objetivo
Definir reglas de escritura segura para la memoria visual local.

## Escritura permitida
Los scripts pueden crear o actualizar notas dentro de `ENGREMIAT_MEMORY/`, reportes dentro de `reports/dev-visual-memory/` y registros en artifact-registry.

## Escritura no permitida por defecto
- No borrar historial.
- No sobrescribir evidencias originales sin nuevo reporte.
- No ejecutar red externa.
- No usar Git remoto.
- No aplicar cambios sensibles sin gate humano.

## Formato minimo de evidencia
Toda evidencia debe incluir objetivo, etapa, bloque, paso, ruta, estado, fecha y proximo paso.

## Politica de historial
Si una nota cambia de forma relevante, se debe registrar en reportes o manifests antes de cierre.
