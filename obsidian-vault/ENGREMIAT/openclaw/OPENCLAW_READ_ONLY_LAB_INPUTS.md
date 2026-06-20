# READ ONLY LAB INPUTS - OPENCLAW

## Objetivo
Definir los documentos que OpenClaw podria leer en un laboratorio read-only.

## Entradas permitidas
- CURRENT_STATUS.md
- NEXT_ACTIONS.md
- OPENCLAW_ROLE_AND_BOUNDARIES.md
- OPENCLAW_BOUNDARIES_POLICY.md
- OPENCLAW_READ_ONLY_LAB.md
- OPENCLAW_USE_CASE_001_READ_STATUS_AND_PROPOSE_NEXT_ACTION.md
- OBSIDIAN_KNOWLEDGE_VAULT_READINESS_REPORT.md
- KNOWLEDGE_BASE_READINESS_REPORT.md
- SKILL_CANDIDATE_001_RESUMIR_ESTADO_ENGREMIAT.md
- SKILL_CANDIDATE_002_LEER_ROADMAP_SIGUIENTE_PASO.md
- SKILL_CANDIDATE_003_VALIDAR_BLOQUE_EVIDENCIA.md

## Entradas prohibidas
- Credenciales.
- Archivos .env.
- Tokens.
- Bases de datos directas.
- Carpetas completas sin filtro.
- Repositorio entero.
- Historial masivo sin curar.

## Paquete minimo recomendado
Para primera prueba conceptual solo usar: CURRENT_STATUS, NEXT_ACTIONS, ROLE, POLICY y USE_CASE_001.

## Salida esperada
Un resumen de estado y una propuesta de siguiente accion, sin ejecutar nada.
