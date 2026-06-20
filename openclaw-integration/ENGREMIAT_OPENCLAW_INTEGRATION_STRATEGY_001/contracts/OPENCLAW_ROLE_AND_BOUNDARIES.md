# OPENCLAW ROLE AND BOUNDARIES - ENGREMIAT

## Proyecto
ENGREMIAT_OPENCLAW_INTEGRATION_STRATEGY_001

## Decision inicial
OpenClaw se plantea como capa futura de agente/gateway gobernado dentro de ENGREMIAT, no como agente autonomo sin control.

## Rol propuesto
OpenClaw puede actuar como una capa intermedia para conectar interfaces conversacionales, agentes locales y herramientas, pero en ENGREMIAT debe entrar primero en modo estrategia, contrato y laboratorio READ_ONLY.

## Encaje con piezas actuales
- Obsidian: taller humano de conocimiento.
- Open WebUI: consulta RAG local con Knowledge Bases FAST/FULL.
- Ollama/qwen3:14b: inferencia local.
- OpenClaw: futura capa de agente/gateway gobernado.
- Telegram: futura capa UX guiada.
- Backend ENGREMIAT: futura capa de estado, tareas, contratos y evidencias.

## Modos permitidos por fases
1. STRATEGY_ONLY: documentar rol y limites.
2. READ_ONLY_LAB: leer contexto preparado, sin escribir ni ejecutar.
3. GATED_ACTION_LAB: preparar acciones con gate humano explicito.
4. CONTROLLED_EXECUTION: solo tras evidencias, contratos y rollback.

## Decision actual
current_mode=STRATEGY_ONLY
next_mode_candidate=READ_ONLY_LAB
autonomous_execution=False
write_permissions=False
external_actions=False
