# Card to Module Flow

Estado: PASS

Principio: la tarjeta es una propuesta accionable; el modulo es una capacidad estable. El sistema puede proponer tarjetas, pero no crear ni modificar modulos sin gate humano.

## Flujo canonico
1. Crear o recibir tarjeta.
2. Validar con validate-module-card.ps1.
3. Registrar en module-linked-card.index.json.
4. Clasificar: modulo existente, modulo pendiente, worker, documentacion, UX, control o data.
5. Si propone modulo nuevo, crear blueprint antes de tocar archivos reales.
6. Pedir gate humano.
7. Solo con APPROVED pasar a tarea, modulo o ejecucion futura.

## Reglas
- PROPOSED no ejecuta.
- WORKER no ejecuta worker real.
- MODULO crea blueprint primero.
- human_gate=SI por defecto.
- evidence es obligatoria para propuestas del sistema.

Next: E91D_CREATE_MODULE_CARD_FLOW_CHECKER