# MANUAL HUMANO-MAQUINA · ENGREMIAT_RESOURCE_LIBRARY_STANDARD_001

Objetivo: definir la biblioteca de recursos reutilizables de ENGREMIAT para almacenar, validar, versionar, buscar y componer piezas reutilizables.

Principio: todo output util puede convertirse en recurso reutilizable si tiene manifest, version, evidencia, calidad y gate.

Tipos de recurso: RESOURCE_MODULE, RESOURCE_TEMPLATE, RESOURCE_DOCUMENT, RESOURCE_PROCESS, RESOURCE_DATASET, RESOURCE_METHOD, RESOURCE_BUSINESS_PLAN, RESOURCE_GRANT_APPLICATION, RESOURCE_MANUAL, RESOURCE_DASHBOARD, RESOURCE_WORKFLOW.

Flujo: PROJECT -> TASK -> OUTPUT -> EVIDENCE -> RESOURCE -> LIBRARY_OR_ARCHIVE.

Rutas clave: contracts/resource-library-contract.json, schemas/resource-manifest.schema.json, schemas/resource-composition-blueprint.schema.json, library/index/resource-library-index.json, tools/Invoke-ResourceLibraryIndexBuilder.ps1, tools/Invoke-ResourceLibraryValidator.ps1.

Uso humano: crear recurso candidato, validar manifest, calcular calidad, indexar, buscar por capacidades, componer blueprint y pasar gate antes de oficializar.

Siguiente recomendado: ENGREMIAT_RESOURCE_COMPOSER_OLLAMA_READY_001.
