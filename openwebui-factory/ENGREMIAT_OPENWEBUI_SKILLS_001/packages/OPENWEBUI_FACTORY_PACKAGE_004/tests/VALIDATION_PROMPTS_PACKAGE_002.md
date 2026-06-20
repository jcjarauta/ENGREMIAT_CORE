# VALIDATION PROMPTS - PACKAGE 002

## Test 1
Usa engremiat-estado-operativo y responde: estado actual, ultimo bloque cerrado, siguiente paso y riesgos.

## Test 2
Usa engremiat-roadmap-next. Estamos despues de B04/B05/B06 y B07 salio PENDING/WARN. Que debo hacer?

## Test 3
Usa engremiat-validar-evidencia. Valida: OK status=PASS next=B06 report=C:\ENGREMIAT_CORE\test.json api_real_write=False openwebui_write=False. Devuelve status, evidencia, next y gate_required.

## PASS esperado
Test1 debe mencionar B08. Test2 debe responder B08_REFINE_SKILL_AND_KNOWLEDGE_TEMPLATES_FROM_MANUAL_TEST. Test3 debe devolver gate_required=False.
