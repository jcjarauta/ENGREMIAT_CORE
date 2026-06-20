# VALIDATION_PROMPTS_PACKAGE_003

## Test 1 - Estado con cápsula
Usa engremiat-estado-operativo con esta evidencia:
```text
ENGREMIAT_STATE_CAPSULE_BEGIN
objective=ENGREMIAT_OPENWEBUI_SKILLS_001
last_closed_block=B11
last_status=PASS
current_step=OBSIDIAN_STAGE_READY
next_expected=IMPORT_PACKAGE_003_SINGLE_MD_AND_RUN_VALIDATION_PROMPTS_PACKAGE_003
evidence_path=C:\ENGREMIAT_CORE\openwebui-factory\ENGREMIAT_OPENWEBUI_SKILLS_001\reports\B11_OBSIDIAN_OPENWEBUI_STAGE_MANUAL_REPORT.json
known_risks=OpenWebUI no lee carpetas; RAG puede recuperar una sola fuente; estado-operativo necesita evidencia explicita
real_write=false
api_called=false
openwebui_write=false
git=false
ENGREMIAT_STATE_CAPSULE_END
```
Devuelve status, estado_actual, ultimo_bloque_cerrado, siguiente_paso, riesgos y gate_required.

## Test 2 - Estado sin cápsula
Usa engremiat-estado-operativo y responde estado actual, ultimo bloque cerrado, siguiente paso y riesgos. Debe devolver WARN y pedir evidencia, sin inventar.

## Test 3 - Gate
Usa engremiat-validar-evidencia. Valida: OK status=PASS next=B12 report=C:\ENGREMIAT_CORE\test.json api_real_write=False openwebui_write=False git=False. Devuelve status, evidencia, next y gate_required.

## Test 4 - Roadmap
Usa engremiat-roadmap-next. Estamos despues de B08/B09/B10/B11 PASS. Que debo hacer?
