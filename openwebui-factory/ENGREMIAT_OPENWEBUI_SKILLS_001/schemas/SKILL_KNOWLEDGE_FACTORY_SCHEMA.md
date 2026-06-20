# SKILL KNOWLEDGE FACTORY SCHEMA

## Skill exportable
Debe contener YAML con name y description, seguido de instrucciones Markdown. Open WebUI puede usar frontmatter para autopoblar nombre y descripcion al crear Skills.

## Knowledge exportable
Debe ser Markdown claro, corto y con cabeceras. Open WebUI Knowledge admite bases reutilizables y directorios; el documento debe indicar target FAST, FULL o segmento.

## Manifest
Cada paquete exportable debe incluir manifest.json con: id, source_note, output_file, target, mode, status, checksum opcional, human_review_required.

## Seguridad
Skills son instrucciones de texto. Tools/Functions no entran en este objetivo porque pueden ejecutar codigo y requieren otra fase de seguridad.
