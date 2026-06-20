# OBSIDIAN TO OPENWEBUI BRIDGE  Origen Obsidian: C:\ENGREMIAT_CORE\obsidian-vault\ENGREMIAT\openwebui\OBSIDIAN_TO_OPENWEBUI_BRIDGE.md  Destino sugerido: knowledge-fast  --- 
# OBSIDIAN TO OPENWEBUI BRIDGE

## Objetivo
Definir un puente manual y seguro entre Obsidian y Open WebUI. Obsidian sera el taller de captura y curacion. Open WebUI recibira solo documentos limpios, cortos y segmentados.

## Politica actual
manual_export_only=True
openwebui_api=False
auto_sync=False
delete_originals=False
move_originals=False

## Flujo
1. Capturar informacion en inbox.
2. Clasificar con CLASSIFICATION_MATRIX.
3. Convertir en documento canonico si es reutilizable.
4. Elegir destino: FAST, FULL o segmento.
5. Copiar manualmente el documento export-ready a Open WebUI.
6. Validar RAG con preguntas concretas.

## Destinos
export-fast: documentos esenciales para ENGREMIAT_CORE_FAST.
export-full: documentos amplios para ENGREMIAT_CORE.
segments/status: estado y readiness.
segments/roadmaps: planes y TSV.
segments/rules: normas y metodologia.
segments/architecture: arquitectura, nodos, workers y modulos.
segments/manuals: guias humano-maquina.
segments/prompts: prompts de continuidad.
segments/reports: evidencias y cierres.
segments/decisions: decisiones vivas.

## Enlaces de navegacion
- [[00_INDEX]]
- [[KNOWLEDGE_GRAPH_HUB]]

