# VALIDATION_PROMPTS_PACKAGE_003

## Test 1 - Estado con cápsula
Usa engremiat-estado-operativo con esta evidencia:
```text
ENGREMIAT_STATE_CAPSULE_BEGIN
objective=ENGREMIAT_OPENWEBUI_SKILLS_001
last_closed_block=B09
last_status=PASS
current_step=PACKAGE_002_IMPORTED_AND_TESTED
next_expected=B10_CLOSE_PACKAGE_002_TEST_AND_BUILD_PACKAGE_003
evidence_path=C:\ENGREMIAT_CORE\openwebui-factory\ENGREMIAT_OPENWEBUI_SKILLS_001\packages\OPENWEBUI_FACTORY_PACKAGE_002\evidence\MANUAL_TEST_RESULT_PACKAGE_002_FILLED.md
known_risks=OpenWebUI no lee carpetas; RAG recupera una fuente; estado-operativo necesita evidencia explicita
real_write=false
api_called=false
openwebui_write=false
git=false
ENGREMIAT_STATE_CAPSULE_END
```

## Test 2 - Estado sin cápsula
Usa engremiat-estado-operativo y responde estado actual, ultimo bloque cerrado, siguiente paso y riesgos. Debe devolver WARN y pedir evidencia, sin inventar.

## Test 3 - Gate
Usa engremiat-validar-evidencia. Valida: OK status=PASS next=B10 report=C:\ENGREMIAT_CORE\test.json api_real_write=False openwebui_write=False git=False. Devuelve status, evidencia, next y gate_required.
