# KANBAN ROADMAP CARDS · PREVIEW

Proyecto: 
Primer intake real para construir roadmap automático en ENGREMIAT
Modelo: 
qwen3:14b

> Preview local. No escribe en Kanban/Cline.

## 
KB-001
 · 
Revisar roadmap generado por Ollama local

- Lane: 
READY_FOR_REVIEW
- Prioridad: 
ALTA
- Riesgo: 
LOW
- Gate humano: 
REVIEW_REQUIRED
- Estado: 
PENDING
- Descripción: 
Validar que la propuesta generada por qwen3:14b representa correctamente la intención humana y las restricciones del proyecto.
- Evidencia: 
ollama-roadmap-review-dashboard.html
- Siguiente acción: 
Aprobar, editar, rechazar o diferir roadmap

## 
KB-002
 · 
Convertir roadmap en etapas accionables

- Lane: 
BACKLOG
- Prioridad: 
ALTA
- Riesgo: 
MEDIUM
- Gate humano: 
REVIEW_REQUIRED
- Estado: 
PENDING
- Descripción: 
Separar la propuesta en etapas pequeñas con una frontera técnica por etapa, salida esperada y validación.
- Evidencia: 
kanban-roadmap-cards.preview.json
- Siguiente acción: 
Revisar granularidad de tarjetas

## 
KB-003
 · 
Preparar worker packet preview

- Lane: 
GATED_PREVIEW
- Prioridad: 
MEDIA
- Riesgo: 
MEDIUM
- Gate humano: 
AUTHORIZATION_REQUIRED
- Estado: 
NO_GO
- Descripción: 
Usar el roadmap aprobado como base para preparar un paquete de trabajo futuro sin ejecución real.
- Evidencia: 
worker packet preview
- Siguiente acción: 
Mantener bloqueado hasta autorización explícita

## 
KB-004
 · 
Dry-run de ejecución controlada

- Lane: 
GATED_PREVIEW
- Prioridad: 
MEDIA
- Riesgo: 
MEDIUM
- Gate humano: 
AUTHORIZATION_REQUIRED
- Estado: 
NO_GO
- Descripción: 
Simular ejecución de la propuesta y devolver NO_GO mientras no exista autorización humana explícita.
- Evidencia: 
dry-run dashboard
- Siguiente acción: 
Validar condiciones de GO futuras

## 
KB-005
 · 
Diseñar exportación real a Kanban/Cline

- Lane: 
BACKLOG
- Prioridad: 
MEDIA
- Riesgo: 
HIGH
- Gate humano: 
EXPLICIT_AUTHORIZATION_REQUIRED
- Estado: 
PENDING
- Descripción: 
Definir el puente futuro entre tarjetas preview y escritura real en Kanban/Cline, con gate humano y sin automatización de navegador por defecto.
- Evidencia: 
contrato de exportación
- Siguiente acción: 
Preparar laboratorio de escritura real separado

## 
KB-006
 · 
Mantener cadena segura sin ejecución

- Lane: 
DONE_PREVIEW
- Prioridad: 
ALTA
- Riesgo: 
LOW
- Gate humano: 
PASS
- Estado: 
DONE_PREVIEW
- Descripción: 
Confirmar que esta exportación solo produce archivos locales revisables y no escribe en Kanban real.
- Evidencia: 
JSON TSV Markdown HTML
- Siguiente acción: 
Revisión humana
