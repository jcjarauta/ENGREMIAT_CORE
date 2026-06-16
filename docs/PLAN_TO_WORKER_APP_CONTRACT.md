# PLAN_TO_WORKER_APP_CONTRACT

Objetivo: ENGREMIAT_PLAN_TO_WORKER_APP_001 convierte planes Sheets/TSV/CSV/XLSX/JSON en paquetes de trabajo gobernados para Cline/Ollama.

Limites: sin red externa, sin worker real por defecto, sin apply automatico, sin commit, sin push, sin fetch, sin merge, sin lectura de secretos.

Entradas: plan exportado, estado local, registry/reportes/memoria si existen y decision humana cuando haya gate.

Salidas: plan normalizado, siguiente paso, WorkerPackage, WORKER_PROMPT.md, evidencias y reportes JSON.

Flujo: humano mantiene Sheets, app importa, normaliza, valida, selecciona siguiente paso, genera contexto y prompt, worker propone solo con decision humana, humano revisa evidencia antes de aplicar.

Definicion de hecho E01: contrato, limites, schemas, validador y smoke creados y validados localmente.
