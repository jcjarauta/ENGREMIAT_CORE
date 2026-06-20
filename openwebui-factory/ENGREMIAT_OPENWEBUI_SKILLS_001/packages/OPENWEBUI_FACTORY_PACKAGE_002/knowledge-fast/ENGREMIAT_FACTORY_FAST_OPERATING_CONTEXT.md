# ENGREMIAT FACTORY FAST OPERATING CONTEXT

## Estado actual
ENGREMIAT tiene Open WebUI funcionando con Ollama qwen3:14b, Knowledge Base FAST validada, Obsidian vault operativo, estrategia OpenClaw cerrada sin instalar y factory local OpenWebUI en desarrollo.

## Ultimos bloques cerrados
B01_DEFINE_SKILL_KNOWLEDGE_FACTORY_CONTRACT=PASS
B02_CREATE_LOCAL_FACTORY_GENERATOR=PASS tras repair PARAM_FIRST
B03_VALIDATE_FACTORY_EXPORTS_AND_PREPARE_IMPORT_BRIDGE=PASS
B04_CREATE_FIRST_FACTORY_PACKAGE_SKILLS_AND_FAST_KNOWLEDGE=PASS
B05_PACKAGE_MANUAL_TEST_AND_API_DRYRUN_REFINEMENT=PASS
B06_CREATE_ASSISTED_IMPORT_TEST_DASHBOARD=PASS tras repair ALIAS_SAFE_HTMLENC
B07_VALIDATE_MANUAL_RESULTS_OR_REFINE_FACTORY=PENDING/WARN por prueba manual incompleta o mejorable

## Resultado de prueba manual package 001
TEST_1_ESTADO=WARN
TEST_2_ROADMAP=FAIL
TEST_3_EVIDENCIA=WARN

## Siguiente paso correcto
B08_REFINE_SKILL_AND_KNOWLEDGE_TEMPLATES_FROM_MANUAL_TEST

## Riesgos activos
- Knowledge FAST insuficiente para responder sobre B04/B05.
- Skills demasiado dependientes del RAG y poco normativas.
- Falta regla explícita para decidir gate en logs.
- No activar API real hasta tener PASS manual claro.

## Reglas
api_real_write=False
openwebui_write=False
openclaw_installed=False
telegram_real=False
manual_assisted_import=True

## Decision
Crear PACKAGE_002 con contexto operativo canonico, Skill de estado mas normativa, Skill de roadmap con regla NEXT y Skill de evidencia con decision gate.
