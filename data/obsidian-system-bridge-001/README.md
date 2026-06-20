# ENGREMIAT_OBSIDIAN_SYSTEM_BRIDGE_001

## Objetivo

Crear el puente mínimo estable entre objetos editables en Obsidian y el sistema Engremiat.

## Decisión de diseño

No dependemos de TSV como fuente principal. La fuente canónica será Markdown con YAML frontmatter.

## Flujo

```text
Obsidian Markdown/YAML
→ Engremiat Reader
→ Decisions JSON
→ Manual/importable Kanban package
→ Evidence back to Obsidian
```

## E01

Contrato de objeto creado.

## Siguiente

E02_BUILD_MARKDOWN_YAML_READER_DRY_RUN
