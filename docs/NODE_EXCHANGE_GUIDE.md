# NODE_EXCHANGE_GUIDE

Objetivo: preparar intercambio OLD-PC <-> MAIN-PC sin exigir red activa.

Modelo actual:
- OLD-PC mantiene inbox/outbox/receipts/staging local.
- MAIN-PC puede estar apagado.
- El intercambio real puede hacerse manualmente al principio.
- Carpeta compartida queda para una fase posterior con gate humano.

Rutas OLD-PC:
- data/node-link/inbox
- data/node-link/outbox
- data/node-link/receipts
- data/node-link/staging

Flujo manual inicial:
1. OLD-PC crea paquete en outbox.
2. Cuando MAIN-PC este encendido, se copia el paquete manualmente o por canal aprobado.
3. MAIN-PC devuelve evidencia/receipt.
4. OLD-PC guarda receipt en data/node-link/receipts.

Bloqueado en esta etapa:
- abrir firewall
- crear carpeta compartida Windows
- ejecutar remoto
- usar Ollama remoto
- usar git remoto
