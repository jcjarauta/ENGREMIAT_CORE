# MVP OPERATIVE MANUAL

## Proposito
ENGREMIAT queda usable como sistema local-first de desarrollo asistido gobernado.

## Flujo operativo
1. Preparar tarea worker.
2. Generar prompt.
3. Importar respuesta worker.
4. Revisar con gate humano.
5. Preparar apply preview.
6. Bloquear apply real si no hay autorizacion.
7. Visualizar dashboard.
8. Cerrar con evidencias.

## Regla principal
El humano decide. La maquina prepara, valida, registra y propone.

## Seguridad
- apply_executed=false por defecto
- auto_apply=false
- remote_execution=false
- git_write=false sin autorizacion explicita
- no avanzar con NO_GO
- no aplicar cambios reales sin APPROVE humano
