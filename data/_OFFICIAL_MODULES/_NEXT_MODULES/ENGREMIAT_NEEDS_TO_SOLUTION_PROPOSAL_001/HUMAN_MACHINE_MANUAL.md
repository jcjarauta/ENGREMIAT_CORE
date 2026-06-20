# MANUAL HUMANO-MAQUINA · ENGREMIAT_NEEDS_TO_SOLUTION_PROPOSAL_001

Objetivo: detectar necesidades internas de ENGREMIAT y convertirlas en propuestas gobernadas antes del composer.

Principio: el sistema observa estado local, detecta gaps, propone soluciones y el humano decide. No ejecuta.

Flujo: OBSERVE_LOCAL_STATE -> DETECT_SIGNALS -> CALCULATE_GAPS -> CREATE_NEEDS -> PRIORITIZE_NEEDS -> PROPOSE_SOLUTIONS -> HUMAN_REVIEW.

Archivos clave: module.json, contracts/needs-to-solution-contract.json, contracts/strategic-dependencies-map.json, schemas/need.schema.json, schemas/need-type-taxonomy.json, schemas/system-signal.schema.json, schemas/gap-analysis-model.json, schemas/system-state-snapshot.schema.json, schemas/system-health-dimensions.json, rules/need-detection-rules.json, rules/solution-proposal-rules.json, tools/Invoke-EngremiatNeedsDetector.ps1, tools/Invoke-SolutionProposalEngine.ps1, tools/Invoke-NeedsToSolutionValidator.ps1.

Uso humano: ejecutar detector, revisar needs-detection-report.json, ejecutar motor de propuestas, revisar solution-proposal-report.json, validar con gate humano y decidir siguiente modulo.

Siguiente recomendado: ENGREMIAT_RESOURCE_COMPOSER_OLLAMA_READY_001.
