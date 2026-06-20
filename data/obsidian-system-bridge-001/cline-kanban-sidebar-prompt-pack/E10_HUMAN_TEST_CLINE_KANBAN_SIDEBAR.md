# E10 · Test Cline Kanban sidebar prompt pack

## Objetivo

Probar si el sidebar chat de Cline Kanban puede crear tarjetas desde un prompt estructurado generado por Obsidian/Engremiat.

## Archivo principal

```text
C:\ENGREMIAT_CORE\data\obsidian-system-bridge-001\cline-kanban-sidebar-prompt-pack\CLINE_KANBAN_SIDEBAR_PROMPT_ONE_PASTE.md
```

## Prueba humana

1. Abre Cline Kanban.
2. Abre el sidebar chat del Kanban.
3. Copia y pega entero el archivo `CLINE_KANBAN_SIDEBAR_PROMPT_ONE_PASTE.md`.
4. Observa si crea tarjetas visibles.

## Resultado a devolver

- `KANBAN_SIDEBAR_GO`: crea tarjetas visibles.
- `KANBAN_SIDEBAR_PARTIAL`: entiende el prompt pero requiere pasos manuales.
- `KANBAN_SIDEBAR_CARD_CREATION_NOT_AVAILABLE`: no puede crear tarjetas.

## Seguridad

Este paquete no ejecuta comandos ni modifica Cline/Kanban por sí mismo. Es dry-run documental/prompt pack.
