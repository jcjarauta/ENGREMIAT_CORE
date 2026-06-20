# E16 · Manual worker handoff

## Objetivo

Enviar una card del Kanban local a un worker y capturar la respuesta para que Engremiat pueda analizarla.

## Prompt outbox

```text
C:\ENGREMIAT_CORE\data\obsidian-system-bridge-001\worker-handoff\outbox\CARD-003.worker-prompt.md
```

## Inbox respuesta

```text
C:\ENGREMIAT_CORE\data\obsidian-system-bridge-001\worker-handoff\inbox\CARD-003.worker-response.md
```

## Pasos humanos

1. Abre el prompt outbox.
2. Copia todo el contenido.
3. Pégalo en el worker elegido: Cline, Cline CLI, ChatGPT worker u otro.
4. No autorices ejecución de comandos ni escritura de archivos.
5. Copia la respuesta del worker.
6. Pégala en el inbox response.
7. Devuelve aquí: WORKER_RESPONSE_CAPTURED.

## Siguiente

E17 leerá el inbox, validará marcadores y generará evidencia.
