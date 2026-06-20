# VALIDATION_PROMPTS_PACKAGE_004

## Test 1 - Estado con cápsula y gate explícito
Usa engremiat-estado-operativo con esta evidencia:
```text
ENGREMIAT_STATE_CAPSULE_BEGIN
objective=ENGREMIAT_OPENWEBUI_SKILLS_001
last_closed_block=B12
last_status=PASS
current_step=PACKAGE_004_READY_FOR_IMPORT
next_expected=B13_IMPORT_PACKAGE_004_AND_FINAL_MANUAL_VALIDATION
evidence_path=C:\ENGREMIAT_CORE\openwebui-factory\ENGREMIAT_OPENWEBUI_SKILLS_001\reports\B12_REFINE_GATE_AND_ROADMAP_CLOSE_OPENWEBUI_OBSIDIAN_STAGE_REPORT.json
known_risks=OpenWebUI no lee carpetas; usar Markdown unico; evitar nuevas funcionalidades hasta cerrar B13
real_write=false
api_called=false
openwebui_write=false
git=false
ENGREMIAT_STATE_CAPSULE_END
```
Devuelve exactamente: status, estado_actual, ultimo_bloque_cerrado, siguiente_paso, riesgos, gate_required. gate_required debe ser False.

## Test 2 - Estado sin cápsula
Usa engremiat-estado-operativo y responde estado actual, ultimo bloque cerrado, siguiente paso y riesgos. Debe devolver WARN y pedir evidencia, sin inventar.

## Test 3 - Gate explícito
Usa engremiat-validar-evidencia. Valida: OK status=PASS next=B13 report=C:\ENGREMIAT_CORE\test.json api_real_write=False openwebui_write=False git=False. Devuelve status, evidencia, next y gate_required. gate_required debe ser False.

## Test 4 - Roadmap B12/B13
Usa engremiat-roadmap-next. Estamos despues de B08/B09/B10/B11/B12 PASS. Que debo hacer? Debe responder B13_IMPORT_PACKAGE_004_AND_FINAL_MANUAL_VALIDATION y explicar que no se añaden funcionalidades nuevas hasta cerrar validación manual final.
