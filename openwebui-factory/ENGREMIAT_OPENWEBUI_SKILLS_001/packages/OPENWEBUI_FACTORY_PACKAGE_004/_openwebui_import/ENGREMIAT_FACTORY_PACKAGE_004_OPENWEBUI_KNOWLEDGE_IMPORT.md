# ENGREMIAT_FACTORY_PACKAGE_004_OPENWEBUI_KNOWLEDGE_IMPORT

purpose: final manual-stage import with explicit gate_required rule and B12/B13 roadmap.
package: OPENWEBUI_FACTORY_PACKAGE_004
generated_at: 2026-06-18T16:17:42
source_root: C:\ENGREMIAT_CORE\openwebui-factory\ENGREMIAT_OPENWEBUI_SKILLS_001\packages\OPENWEBUI_FACTORY_PACKAGE_004
files_count: 19

## IMPORT INSTRUCTIONS
Create a NEW OpenWebUI Knowledge collection named ENGREMIAT_FACTORY_PACKAGE_004. Import only this single Markdown file. Do not import folders.

---

## SOURCE_FILE: docs\ENGREMIAT_GATE_REQUIRED_RULE.md

```md
# ENGREMIAT_GATE_REQUIRED_RULE

## Regla obligatoria
gate_required debe calcularse siempre. Nunca responder "no se menciona" si existen flags de seguridad.

## Fórmula
gate_required=true si cualquiera de estos campos es true: real_write, api_called, openwebui_write, git, browser, clipboard, worker_execute, external_network.

gate_required=false si todos esos campos son false o si la evidencia declara explícitamente operación LOCAL_ONLY sin escritura real.

## Para STATE_CAPSULE
Si STATE_CAPSULE contiene real_write=false api_called=false openwebui_write=false git=false, entonces gate_required=False.

## Si faltan flags
Si faltan flags y la acción podría escribir o ejecutar, responder gate_required=UNKNOWN y decision=WARN_REQUEST_EVIDENCE.

```

---

## SOURCE_FILE: docs\ENGREMIAT_OPENWEBUI_OBSIDIAN_STAGE_CLOSE_CRITERIA.md

```md
# ENGREMIAT_OPENWEBUI_OBSIDIAN_STAGE_CLOSE_CRITERIA

## Criterio de cierre
La etapa puede cerrarse cuando Package 004 responda correctamente a: estado con cápsula, estado sin cápsula, gate explícito y roadmap B12/B13.

## PASS mínimo
- Con STATE_CAPSULE: status=PASS, estado_actual correcto, último bloque correcto, siguiente paso correcto, riesgos correctos, gate_required=False.
- Sin STATE_CAPSULE: status=WARN, pide evidencia y no inventa.
- Gate: calcula False cuando no hay escritura real.
- Roadmap: después de B12 propone B13_IMPORT_PACKAGE_004_AND_FINAL_MANUAL_VALIDATION.

## Decisión tras cierre
Solo tras B13 se valora añadir nuevas funcionalidades.

```

---

## SOURCE_FILE: docs\ENGREMIAT_ROADMAP_B12_CLOSE_STAGE.md

```md
# ENGREMIAT_ROADMAP_B12_CLOSE_STAGE

## Contexto
Después de B08, B09, B10 y B11 PASS, y PACKAGE_003 probado con WARN útil, el siguiente paso es B12.

## B12
B12_REFINE_GATE_AND_ROADMAP_CLOSE_OPENWEBUI_OBSIDIAN_STAGE.

## Objetivo B12
Cerrar la base manual OpenWebUI + Obsidian antes de añadir funcionalidades nuevas.

## Resultado esperado
- Package 004 generado.
- gate_required explícito.
- roadmap-next sabe definir B12.
- Knowledge importable como Markdown único.
- Evidencia manual lista.

## Siguiente después de B12
B13_IMPORT_PACKAGE_004_AND_FINAL_MANUAL_VALIDATION.

## Regla
No añadir API, workers, Telegram, Kanban ni sincronización Obsidian hasta B13 PASS o WARN seguro.

```

---

## SOURCE_FILE: docs\ENGREMIAT_STATE_CAPSULE_PROTOCOL.md

```md
# ENGREMIAT_STATE_CAPSULE_PROTOCOL

## Objetivo
Evitar que OpenWebUI invente estado cuando el RAG no contiene evidencia suficiente.

## Formato requerido
```text
ENGREMIAT_STATE_CAPSULE_BEGIN
objective=
last_closed_block=
last_status=PASS/WARN/FAIL/PENDING
current_step=
next_expected=
evidence_path=
known_risks=
real_write=false
api_called=false
openwebui_write=false
git=false
ENGREMIAT_STATE_CAPSULE_END
```

## Regla de respuesta
Si falta STATE_CAPSULE o evidencia equivalente, responder WARN y pedir evidencia. No inventar estado, roadmap ni cierre.

## Salida obligatoria
status=PASS/WARN/FAIL
estado_actual=
ultimo_bloque_cerrado=
siguiente_paso=
riesgos=
gate_required=

```

---

## SOURCE_FILE: evidence\MANUAL_TEST_RESULT_PACKAGE_002_CLOSED.md

```md
# MANUAL_TEST_RESULT_PACKAGE_002_CLOSED

status=WARN_IMPROVABLE_BUT_USEFUL

## Resultado observado
- engremiat-roadmap-next: PASS.
- engremiat-validar-evidencia: PASS.
- engremiat-estado-operativo: WARN seguro cuando falta evidencia explícita.

## Diagnóstico
PACKAGE_002 es útil, pero necesita STATE_CAPSULE para que OpenWebUI reciba estado mínimo pegable.

## Decisión
Crear PACKAGE_003 con STATE_CAPSULE, prompts reforzados y Markdown único importable.

```

---

## SOURCE_FILE: evidence\MANUAL_TEST_RESULT_PACKAGE_002_FILLED.md

```md
# MANUAL_TEST_RESULT_PACKAGE_002_FILLED

status=PENDING

## Resultado OpenWebUI

## Desviaciones

## Evidencia

## Decision


```

---

## SOURCE_FILE: evidence\MANUAL_TEST_RESULT_PACKAGE_003_CLOSED.md

```md
# MANUAL_TEST_RESULT_PACKAGE_003_CLOSED

status=WARN_USEFUL_REQUIRES_REFINEMENT

## Resultado observado
- Test 1 STATE_CAPSULE: PASS parcial. Devuelve estado, último bloque, next y riesgos, pero gate_required queda como no mencionado.
- Test 2 sin cápsula: PASS. Devuelve WARN y pide evidencia sin inventar.
- Test 3 gate: PASS. Devuelve gate_required=False.
- Test 4 roadmap: WARN. Propone B12, pero sin definición suficiente.

## Diagnóstico
PACKAGE_003 valida el patrón STATE_CAPSULE, pero necesita regla explícita para gate_required y definición concreta de B12.

## Decisión
Crear PACKAGE_004 para cerrar base manual OpenWebUI + Obsidian antes de nuevas funcionalidades.

```

---

## SOURCE_FILE: evidence\MANUAL_TEST_RESULT_PACKAGE_003_FILLED.md

```md
# MANUAL_TEST_RESULT_PACKAGE_003_FILLED

status=PENDING

## Resultado OpenWebUI

## Desviaciones

## Evidencia

## Decision


```

---

## SOURCE_FILE: evidence\MANUAL_TEST_RESULT_PACKAGE_004_FILLED.md

```md
# MANUAL_TEST_RESULT_PACKAGE_004_FILLED

status=PENDING

## Collection usada
ENGREMIAT_FACTORY_PACKAGE_004

## Test 1 - Estado con cápsula

## Test 2 - Estado sin cápsula

## Test 3 - Gate explícito

## Test 4 - Roadmap B12/B13

## Desviaciones

## Decision


```

---

## SOURCE_FILE: HUMAN_IMPORT_AND_TEST_CHECKLIST.md

```md
# HUMAN_IMPORT_PACKAGE_002_AND_TEST

## 1. Importar en OpenWebUI
- Abrir OpenWebUI local.
- Importar/añadir la Skill/Knowledge del paquete 002 desde esta carpeta o ZIP.
- Confirmar que aparece como recurso disponible para el modelo.

## 2. Ejecutar prompts de validación
- Abrir tests/VALIDATION_PROMPTS_PACKAGE_002.md.
- Ejecutar los prompts en orden.
- Guardar la respuesta manual en evidence/MANUAL_TEST_RESULT_PACKAGE_002_FILLED.md.

## 3. Criterio PASS
- Resume estado actual usando evidencias.
- Detecta último bloque cerrado.
- Propone siguiente paso correcto.
- Enumera riesgos reales.
- No inventa roadmap fuera de evidencias.

## 4. Resultado que debes devolver a ChatGPT
Pega: PASS/WARN/FAIL + respuesta observada + desviaciones + evidencia/resumen.

```

---

## SOURCE_FILE: knowledge-fast\ENGREMIAT_FACTORY_FAST_OPERATING_CONTEXT.md

```md
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

```

---

## SOURCE_FILE: manifest\package-002-manifest.json

```json
{
    "package_id":  "OPENWEBUI_FACTORY_PACKAGE_002",
    "created_at":  "2026-06-18T15:32:30",
    "source":  "manual_test_package_001",
    "reason":  "refine_after_warn_fail",
    "api_real_write":  false,
    "openwebui_write":  false,
    "skills_count":  3,
    "knowledge_fast_count":  1,
    "next":  "HUMAN_IMPORT_PACKAGE_002_AND_TEST"
}

```

---

## SOURCE_FILE: manual\MANUAL_IMPORT_PACKAGE_002.md

```md
# MANUAL IMPORT PACKAGE 002

## Objetivo
Reemplazar la prueba package 001 por un paquete mas canonico y menos ambiguo.

## Importar Knowledge
Crear/actualizar ENGREMIAT_FACTORY_TEST_FAST con knowledge-fast/ENGREMIAT_FACTORY_FAST_OPERATING_CONTEXT.md.

## Crear Skills
Crear o actualizar las 3 Skills de package 002.

## Probar
Usar tests/VALIDATION_PROMPTS_PACKAGE_002.md.

## No hacer
No API real. No Tools. No Functions. No OpenClaw. No Telegram real.

```

---

## SOURCE_FILE: skills\engremiat-estado-operativo.md

```md
---
name: engremiat-estado-operativo
description: Resume estado actual ENGREMIAT, ultimo bloque cerrado, siguiente paso y riesgos usando reglas canonicas.
---

# Skill ENGREMIAT Estado Operativo

## Cuándo usar
Cuando el usuario pida estado actual, ultimo bloque, siguiente paso, readiness o riesgos.

## Procedimiento
1. Buscar en Knowledge el bloque cerrado mas reciente.
2. Si aparecen B04/B05/B06/B07, interpretar que estamos en OpenWebUI Skills Factory.
3. Responder siempre con: estado actual, ultimo bloque cerrado, siguiente paso, riesgos y decision.
4. Si falta evidencia, declarar WARN y pedir resultado manual.

## Salida obligatoria
estado_actual=...
ultimo_bloque_cerrado=...
siguiente_paso=...
riesgos=...
decision=PASS/WARN/FAIL

## Reglas
No inventar API real. No proponer OpenClaw. No conectar Telegram. Si no hay PASS manual, no recomendar API write.

```

---

## SOURCE_FILE: skills\engremiat-roadmap-next.md

```md
---
name: engremiat-roadmap-next
description: Lee roadmap, bloque actual y NEXT para proponer el siguiente paso seguro.
---

# Skill ENGREMIAT Roadmap NEXT

## Cuándo usar
Cuando el usuario pregunte que hacer despues de B04, B05, B06 o B07.

## Regla NEXT
Si B04 PASS y B05 PASS y B06 PASS pero B07 indica PENDING/WARN, el siguiente paso es B08_REFINE_SKILL_AND_KNOWLEDGE_TEMPLATES_FROM_MANUAL_TEST.
Si B07 PASS manual claro, el siguiente paso es API_DRY_RUN_CONSOLIDATION_NO_WRITE.
Si B07 FAIL o WARN, refinar templates antes de API.

## Salida obligatoria
bloque_actual=...
decision=...
next=...
motivo=...
gate_required=...

```

---

## SOURCE_FILE: skills\engremiat-validar-evidencia.md

```md
---
name: engremiat-validar-evidencia
description: Valida logs ENGREMIAT y extrae status, evidencia, next y gate_required.
---

# Skill ENGREMIAT Validar Evidencia

## Cuándo usar
Cuando el usuario pegue un log o salida de PowerShell ENGREMIAT.

## Procedimiento
1. Extraer status.
2. Extraer next.
3. Extraer report/evidence paths.
4. Decidir gate_required.
5. Si api_real_write=True, openwebui_write=True, telegram_real=True, openclaw_executed=True o install=True, gate_required=True.
6. Si es LOCAL_ONLY, docs/report/dashboard/package sin API real, gate_required=False.

## Salida obligatoria
status=PASS/WARN/FAIL/PENDING
evidence=...
next=...
gate_required=True/False
reason=...

```

---

## SOURCE_FILE: tests\VALIDATION_PROMPTS_PACKAGE_002.md

```md
# VALIDATION PROMPTS - PACKAGE 002

## Test 1
Usa engremiat-estado-operativo y responde: estado actual, ultimo bloque cerrado, siguiente paso y riesgos.

## Test 2
Usa engremiat-roadmap-next. Estamos despues de B04/B05/B06 y B07 salio PENDING/WARN. Que debo hacer?

## Test 3
Usa engremiat-validar-evidencia. Valida: OK status=PASS next=B06 report=C:\ENGREMIAT_CORE\test.json api_real_write=False openwebui_write=False. Devuelve status, evidencia, next y gate_required.

## PASS esperado
Test1 debe mencionar B08. Test2 debe responder B08_REFINE_SKILL_AND_KNOWLEDGE_TEMPLATES_FROM_MANUAL_TEST. Test3 debe devolver gate_required=False.

```

---

## SOURCE_FILE: tests\VALIDATION_PROMPTS_PACKAGE_003.md

```md
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

```

---

## SOURCE_FILE: tests\VALIDATION_PROMPTS_PACKAGE_004.md

```md
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

```
