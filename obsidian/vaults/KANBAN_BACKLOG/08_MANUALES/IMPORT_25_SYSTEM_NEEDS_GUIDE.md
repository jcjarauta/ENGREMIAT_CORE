# IMPORTAR 25 TARJETAS FUNCIONALES

## Instruccion

1. Abre el TSV: `obsidian/vaults/KANBAN_BACKLOG/03_CARDS/imports/system-needs-25-import-template.tsv`.
2. Sustituye los campos PENDIENTE_* por las 25 tarjetas seleccionadas.
3. Mantén `card_id` como `SYSTEM_NEED_001` a `SYSTEM_NEED_025`.
4. No ejecutes automatizacion real todavía.
5. Cuando esté completo, devuelve el TSV o pide el siguiente bloque para materializar las tarjetas.

## Columnas

```text
card_id	title	description	system_area	priority	risk	automation_level	required_adapter	required_node	related_skill	input	output	validation	evidence	next
```

## Reglas

- Kanban ordena; no ejecuta.
- Autoanalysis propone; el humano decide.
- `automation_level` clasifica posibilidad futura, no autoriza automatizacion.
- `required_adapter` puede ser OBSIDIAN, OPENWEBUI, OLLAMA, CLINE, POWERSHELL, KANBAN, OPENCLAW_FUTURE o MANUAL.
- `risk` debe ser LOW, MEDIUM o HIGH cuando se conozca.
