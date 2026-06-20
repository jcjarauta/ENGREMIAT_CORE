---
type: roadmap
project_id: "
PROJECT_PRIMER_INTAKE_REAL_PARA_CONSTRUIR_ROADMAP_AUTOM_TICO_EN_ENGREMIA
"
roadmap_id: ROADMAP-OLLAMA-001
status: review
model: "
qwen3:14b
"
decision: WAIT_HUMAN_REVIEW
source_path: "
C:\ENGREMIAT_CORE\data\real-roadmap-generator-ollama-preview\ollama-roadmap-preview.latest.json
"
tags:
  - engremiat/roadmap
  - status/review
---
# Roadmap IA local

## Modelo
`
qwen3:14b
`

## Resumen generado
```text
**RESUMEN**   Crear un roadmap preview basado en un intake humano estructurado, validado localmente sin dependencias externas. El resultado debe ser exportable en JSON/Markdown, con banderas de seguridad explícitas y preparado para pasar a etapa E02.    ---  **ETAPAS**   1. **Diseño del formulario de intake**      - Campos obligatorios: `project_name`, `human_need`, `desired_result`, `constraints`, `success_criteria`, `safety`.      - Validación local: Verificar que `safety.local_only=true`, `worker_execution=false`, `execute_now=false`.      - Exportar a JSON con estructura `real-human-intake.v1`.    2. **Generación de preview Markdown**      - Resumir `human_need` y `desired_result` en formato legible.      - Incluir banderas de seguridad y restricciones en un apartado "Notas de seguridad".      - Exportar manualmente como `.md` con nombre derivado de `package_id`.    3. **Validación humana**      - Revisar que JSON y Markdown reflejen los datos originales.      - Confirmar ausencia de referencias a backend, red, Git o ejecución automática.    ---  **RIESGOS**   - **Falta de claridad en campos**: Si `human_need` o `desired_result` son ambiguos, el roadmap preview podría ser inútil.   - **Errores en exportación**: Si el JSON no incluye `safety.local_only=true`, se viola el constraint.   - **Dependencia no declarada**: Incluir accidentalmente referencias a Ollama o PowerShell en el preview.    ---  **EVIDENCIAS**   - Archivo JSON válido con:     ```json     {"safety": {"local_only": true, "worker_execution": false, "execute_now": false}}     ```   - Archivo Markdown con:     ```markdown     ## Notas de seguridad     - Solo operación local.     - No se permite ejecución automática.     ```   - Confirmación manual de que no hay menciones a backend, red o Git.    ---  **GATE_HUMANO**   - ✅ Revisar que el JSON y Markdown cumplan con `success_criteria`.   - ✅ Verificar que no haya referencias a ejecución, red o Git.   - ✅ Aprobar paso a **E02_GENERATE_ROADMAP_FROM_REAL_INTAKE_PREVIEW**.    ---  **SIGUIENTE_PASO**   - Usar el JSON exportado como entrada para **E02_GENERATE_ROADMAP_FROM_REAL_INTAKE_PREVIEW**, asegurando que el roadmap preview respete las banderas de seguridad y no incluya etapas inválidas (ej: "worker real", "Git", "backend").
```

## Enlaces
- Intake: [[../01_INTAKE/INTAKE_NORMALIZADO]]
- Tareas: [[../03_TAREAS/TASKS_INDEX]]
- Gate roadmap: [[../04_GATES_DECISIONES/GATE_ROADMAP_APPROVAL]]
