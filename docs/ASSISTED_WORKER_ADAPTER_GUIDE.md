# ASSISTED_WORKER_ADAPTER_GUIDE

## Propósito
ENGREMIAT_DEV_ASSISTED_WORKER_ADAPTER_001 permite usar ENGREMIAT_OLLAMA/Cline como accesorio gobernado de desarrollo.

## Regla central
Cline/Ollama puede proponer. DEV_SYSTEM registra. El humano aprueba. El runner aplica solo con evidencia y gate.

## Flujo
1. DEV_SYSTEM detecta fila activa.
2. DEV_SYSTEM prepara AgentTaskPackage.
3. Se genera prompt normalizado para Cline/Ollama.
4. Cline/Ollama devuelve propuesta, evidencias y riesgos.
5. DEV_SYSTEM importa resultado como propuesta.
6. El humano revisa y decide.
7. Solo con gate aprobado se prepara apply controlado.

## Prohibido por defecto
- Git remoto.
- Lectura de secretos.
- Red externa.
- Aplicar cambios sin review.
- Cerrar pasos sin evidencia registrada.
- Decidir el siguiente MVP.

## Modos
- PREPARED_ONLY: solo prepara paquetes.
- MANUAL_HANDOFF: el humano copia/pega el prompt.
- PROPOSAL_ONLY: el worker propone, no aplica.
- LOCAL_AUTHORIZED: solo con gate humano explícito.

## Resultado esperado
Adapter seguro, accesorio, trazable y desconectable.
