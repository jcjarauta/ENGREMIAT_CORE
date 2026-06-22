# Worker Heartbeat Writer Minimal Contract

Proposito: definir el emisor minimo de heartbeat local para publicar estado vivo sin depender de Obsidian, red, APIs externas ni ejecucion remota.

Salidas locales:
documents/worker-sync/worker-heartbeat-latest.json
documents/worker-sync/worker-events.jsonl
documents/worker-sync/project-signal-latest.json

Estados admitidos: IDLE, QUEUED, RUNNING, WAITING_HUMAN, BLOCKED, DONE, ERROR

Reglas:
RUNNING sin blocked_reason se muestra como OK en Proyectos.
blocked_reason no vacio fuerza BLOCK.
project-signal-latest.json es la vista resumida para terminal.
Obsidian solo visualiza Markdown/YAML; no es dependencia runtime.
El writer no ejecuta tareas: solo publica señal.

Siguiente paso: E71_CREATE_WORKER_HEARTBEAT_WRITER_MINIMAL_DRY_RUN
