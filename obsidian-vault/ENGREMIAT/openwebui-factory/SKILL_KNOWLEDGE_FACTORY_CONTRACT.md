# SKILL AND KNOWLEDGE FACTORY CONTRACT

## Proyecto
ENGREMIAT_OPENWEBUI_SKILLS_001

## Objetivo
Crear una fabrica local para simplificar la creacion de Skills y nuevo conocimiento para Open WebUI, usando Obsidian como fuente ordenada y evitando el proceso manual repetitivo siempre que sea seguro.

## Principio
Obsidian es la fuente de captura y curacion. La fabrica transforma notas clasificadas en paquetes exportables. Open WebUI recibe Skills y Knowledge validados.

## Modos
MODE_1_LOCAL_EXPORT: generar archivos, manifiestos y checklist.
MODE_2_MANUAL_ASSISTED_IMPORT: preparar instrucciones y payloads para copiar/subir.
MODE_3_API_DRY_RUN: preparar request local sin enviarlo.
MODE_4_API_REAL_GATED: crear/actualizar en Open WebUI solo con autorizacion humana explicita.

## Estado inicial
current_mode=MODE_1_LOCAL_EXPORT
api_real_write=False
openwebui_write=False
skills_created_in_openwebui=False
knowledge_created_in_openwebui=False

## Regla
No saltar a API real hasta validar estructura, taxonomia, plantillas, manifiestos y dry-run.
