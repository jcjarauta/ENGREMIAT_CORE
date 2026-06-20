# E04 · Prueba con extensión Kanban Markdown

## Objetivo

Comprobar si un tablero Kanban basado en Markdown puede sustituir el paso manual hacia Cline/Kanban.

## Estado

- Engremiat ya generó el tablero `.kanban.md`.
- No se detectó extensión compatible instalada.
- No se escribe en Cline/Kanban.
- La prueba es local y reversible.

## Archivo a abrir

```text
C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\ENGREMIAT_MARKDOWN_KANBAN_TEST.kanban.md
```

## Opción recomendada

Instalar en VS Code/Cursor una extensión compatible con `.kanban.md`, por ejemplo:

- `jeddak.md-kanban` / MD Kanban.
- `wguilherme.kanban-md` / Kanban.md.
- Otra extensión que abra Markdown como Kanban.

## Prueba humana

1. Abre VS Code o Cursor en:

```text
C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST
```

2. Instala una extensión Kanban Markdown compatible.

3. Abre la paleta de comandos.

4. Ejecuta algo equivalente a:

```text
Kanban: Open Kanban Board
```

5. Selecciona:

```text
C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\ENGREMIAT_MARKDOWN_KANBAN_TEST.kanban.md
```

## Resultado esperado

Debe verse un tablero con columnas:

- BACKLOG
- NEXT
- DOING
- DONE

## Decisión a devolver

- `MARKDOWN_KANBAN_GO`: se ve como tablero.
- `FORMAT_ADJUST_REQUIRED`: la extensión abre, pero el formato necesita ajuste.
- `EXTENSION_NOT_WORKING`: no se visualiza como tablero.
