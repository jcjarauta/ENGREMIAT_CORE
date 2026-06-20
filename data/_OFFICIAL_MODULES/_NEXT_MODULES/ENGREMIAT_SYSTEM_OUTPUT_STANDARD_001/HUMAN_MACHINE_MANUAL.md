# MANUAL HUMANO-MAQUINA · ENGREMIAT_SYSTEM_OUTPUT_STANDARD_001

Objetivo: normalizar los outputs canonicos de ENGREMIAT antes del composer core, evitando texto libre como salida final y desacoplando cualquier modelo IA.

Principio: ENGREMIAT produce outputs normalizados; modelos y humanos pueden ayudar, pero deben devolver contratos compatibles.

Outputs principales: PROPOSAL, DECISION, TASK_PLAN, RESOURCE_QUERY, RESOURCE_SELECTION, COMPOSITION_BLUEPRINT, BUILD_PACKAGE, EVIDENCE_REPORT, GATE_REQUEST, CLIENT_ASSEMBLY_PLAN, DOCUMENTATION_PACKAGE, MODEL_RESPONSE_NORMALIZED.

Regla: todo output final debe estar envuelto en output_envelope con output_id, output_type, source, status, payload, evidence, gate y created_at.

Archivos clave: contracts/system-output-contract.json, contracts/output-dependencies-map.json, contracts/output-evidence-policy.json, contracts/output-gate-policy.json, contracts/model-output-adapter-contract.json, schemas/output-envelope.schema.json, schemas/proposal-output.schema.json, schemas/decision-output.schema.json, schemas/task-plan-output.schema.json, schemas/resource-query-output.schema.json, schemas/composition-blueprint-output.schema.json, schemas/build-package-output.schema.json, rules/output-validation-rules.json, rules/output-transform-rules.json, tools/Invoke-SystemOutputRouterDryRun.ps1, tools/Invoke-SystemOutputValidator.ps1.

Uso humano: revisar output, validar envelope, comprobar evidence y gate, enrutar con router dry-run y aprobar solo mediante gate humano cuando el output sea accionable.

Siguiente recomendado: ENGREMIAT_RESOURCE_COMPOSER_CORE_001.
