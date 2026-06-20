# OPENCLAW INTEGRATION MAP - ENGREMIAT

## Objetivo
Mapear como OpenClaw podria integrarse en ENGREMIAT sin instalarlo ni ejecutarlo todavia. Este mapa define relaciones, entradas permitidas y limites.

## Capas actuales
1. Obsidian: taller humano de conocimiento, captura, clasificacion, grafo y skill-candidates.
2. Open WebUI: consulta RAG local, Knowledge Bases ENGREMIAT_CORE y ENGREMIAT_CORE_FAST.
3. Ollama/qwen3:14b: inferencia local.
4. Backend ENGREMIAT: base tecnica NestJS/PostgreSQL para estado futuro, tareas y evidencias.
5. Telegram futuro: interfaz de experiencia guiada.
6. OpenClaw futuro: capa agente/gateway gobernada.

## Relacion propuesta
Obsidian prepara conocimiento. Open WebUI consulta conocimiento. OpenClaw podria leer un paquete controlado y proponer acciones. Telegram podria pedir intencion y mostrar resultados. Backend podria registrar estado y evidencias.

## Regla de integracion
OpenClaw no debe tener acceso directo a todo. Debe recibir paquetes pequenos, preparados y read-only.

## Modo actual
mode=STRATEGY_ONLY
read_only_lab_ready=True
openclaw_installed=False
openclaw_executed=False
write_permissions=False
external_actions=False
