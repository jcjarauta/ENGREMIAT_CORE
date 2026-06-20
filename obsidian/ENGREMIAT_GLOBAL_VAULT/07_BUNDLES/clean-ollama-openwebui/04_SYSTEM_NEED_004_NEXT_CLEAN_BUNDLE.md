---
type: clean_import_bundle
bundle_id: SYSTEM_NEED_004_NEXT_CLEAN_BUNDLE
target_adapter: OLLAMA_OPENWEBUI
status: ACTIVE
analysis_only: true
tags: [bundle/clean, system_need_004, ollama]
---
# SYSTEM_NEED_004_NEXT_CLEAN_BUNDLE

## Tarjeta activa

SYSTEM_NEED_004 · Bundles limpios para Ollama

## Objetivo

Separar el contexto global en bundles tematicos pequenos para que Ollama y OpenWebUI consulten sin ruido.

## Resultado esperado

- Bundles limpios por capa.
- Orden de importacion.
- Prompt de consulta seguro.
- Evidencia local PASS.

## Primera accion segura

Revisar estos bundles en OpenWebUI/Ollama y pedir analisis de suficiencia de contexto, no ejecucion.

## No hacer todavia

- No automatizar importacion.
- No usar API externa.
- No tocar Git.
- No ejecutar workers.
- No modificar registry sin gate.
