# MANUAL HUMANO-MAQUINA · ENGREMIAT_TOOL_ADAPTER_GATE_001

Objetivo: definir gates por capacidad para montar sistemas configurables por cliente sin acoplar ENGREMIAT a herramientas concretas.

Principio: las capacidades gobiernan; las herramientas heredan permisos mediante mapeo.

Capacidades: READ, WRITE, EXECUTE, INFER, PLAN, CLASSIFY, CREATE_PROJECT, CREATE_TASK, CLOSE_TASK, CREATE_RESOURCE, OFFICIALIZE_RESOURCE, PUBLISH_RESOURCE, IMPORT_EXTERNAL, EXPORT_EXTERNAL, AGENT_EXECUTE, SCRIPT_RUN.

Reglas: ninguna herramienta real actua libremente; toda accion se expresa como capability_request; toda capability tiene permiso, riesgo, evidencia esperada y gate; autorizaciones criticas caducan; acciones destructivas requieren rollback o bloqueo.

Siguiente recomendado: ENGREMIAT_RESOURCE_LIBRARY_STANDARD_001.
