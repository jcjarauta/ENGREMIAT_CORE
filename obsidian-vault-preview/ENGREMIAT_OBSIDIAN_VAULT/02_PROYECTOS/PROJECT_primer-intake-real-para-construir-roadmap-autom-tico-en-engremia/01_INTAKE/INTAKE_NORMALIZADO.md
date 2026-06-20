---
type: intake
project_id: "
PROJECT_PRIMER_INTAKE_REAL_PARA_CONSTRUIR_ROADMAP_AUTOM_TICO_EN_ENGREMIA
"
intake_id: INTAKE-REAL-001
status: done
source: human_intake
source_path: "
C:\ENGREMIAT_CORE\data\real-intake-importer\real-human-intake.accepted.latest.json
"
created_at: "
2026-06-19T10:50:43
"
tags:
  - engremiat/intake
  - status/done
---
# Intake normalizado

## Necesidad humana
Necesitamos una forma sencilla de introducir una idea humana de proyecto y convertirla en una estructura ordenada de desarrollo, sin depender de navegador, memoria dispersa ni prompts largos repetidos.

## Resultado deseado
Obtener un intake exportable en JSON y Markdown que pueda alimentar una propuesta de roadmap revisable por el humano antes de preparar cualquier worker o automatización.

## Restricciones
```text
Solo local. Sin backend. Sin red. Sin worker real. Sin Git. Sin ejecución automática. Exportación manual. Debe ser comprensible para humano y útil para generar roadmap.
```

## Recursos disponibles
```text
C:\ENGREMIAT_CORE Dashboard local de intake real Paquete cerrado ENGREMIAT_PROJECT_BUILDER_TO_WORKER_LOOP_001 Ollama local disponible para fases futuras Cline/Kanban disponible para organización futura PowerShell como operador local
```

## Criterios de éxito
```text
La UI abre correctamente. El formulario permite rellenar todos los campos. El botón Generar intake produce JSON válido. El JSON contiene safety.local_only=true. El JSON contiene worker_execution=false. El JSON contiene execute_now=false. El Markdown descargado resume correctamente el proyecto. El resultado permite pasar a una etapa E02 de roadmap preview.
```

## Enlaces
- Proyecto: [[../00_INDEX/PROJECT_INDEX]]
- Roadmap: [[../02_ROADMAP/ROADMAP_IA_LOCAL]]
