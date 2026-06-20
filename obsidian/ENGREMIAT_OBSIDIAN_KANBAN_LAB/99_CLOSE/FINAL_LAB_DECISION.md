---
object_type: final_lab_decision
lab_id: ENGREMIAT_OBSIDIAN_KANBAN_LAB_001
status: CLOSED
readiness: 100
final_decision: ADJUST
next_recommended_objective: ENGREMIAT_OBSIDIAN_SYSTEM_BRIDGE_001
tags: [engremiat_lab, final_decision, bridge]
---

# Decisión final · Obsidian Kanban Lab

## Veredicto

El laboratorio demuestra que Obsidian sí aporta valor como capa previa a Kanban, pero no como sustituto de Kanban ni como UI controlada directamente por Cline.

## Qué funciona

```text
Humano edita Obsidian
→ Obsidian guarda YAML
→ Engremiat lee decisión
→ Engremiat genera export/prompt
→ Engremiat devuelve evidencia a Obsidian
```

## Qué no funciona todavía

```text
Prompt a Cline
→ manipulación directa de UI Kanban
```

Cline respondió `KANBAN_UI_NOT_AVAILABLE`, por lo que no podemos depender de esa vía.

## Decisión estratégica

ADJUST.

No descartamos Obsidian. Ajustamos el diseño: Obsidian debe ser el espacio de decisión y trazabilidad; Kanban debe ser el espacio operativo visible; la conexión debe hacerse por export/import controlado o por mecanismo específico, no por prompt genérico a Cline.

## Siguiente objetivo recomendado

ENGREMIAT_OBSIDIAN_SYSTEM_BRIDGE_001

## Alcance del siguiente objetivo

1. Definir contrato estable de objetos Obsidian.
2. Leer notas Markdown/YAML directamente, evitando TSV frágiles.
3. Detectar decisiones humanas `GO`, `ADJUST`, `STOP`.
4. Generar paquete Kanban manual/importable.
5. Registrar retorno/evidencia en Obsidian.
6. Mantener Cline como worker de razonamiento/desarrollo, no como controlador UI Kanban.

## Regla aprendida

No usar Cline para manipular UI Kanban si no hay herramienta explícita de UI. Usar paquetes, export y revisión humana.
