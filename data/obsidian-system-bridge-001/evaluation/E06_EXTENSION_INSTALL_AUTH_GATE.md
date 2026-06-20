# E06 · Extension install authorization gate

## Estado

- VS Code abierto en E05: PASS.
- Extensiones Kanban Markdown detectadas: 0.
- Para continuar hay que instalar una extensión compatible.

## Seguridad

authorization_required=True
authorization_status=PENDING_EXPLICIT_HUMAN_AUTHORIZATION
requires_human_authorization=True
network_required=True
modifies_vscode_extensions=True
write_to_cline=False
browser=False
git=False

## Extensión candidata principal

```text
jeddak.md-kanban
```

## Comando si autorizas instalación por terminal

```powershell
code --install-extension jeddak.md-kanban
```

## Alternativa manual

Abrir Extensions en VS Code y buscar:

```text
MD Kanban
```

Después abrir:

```text
C:\ENGREMIAT_CORE\obsidian\ENGREMIAT_OBSIDIAN_KANBAN_LAB\12_MARKDOWN_KANBAN_TEST\ENGREMIAT_MARKDOWN_KANBAN_TEST.kanban.md
```

Y ejecutar en la paleta de comandos algo similar a:

```text
Kanban: Open Kanban Board
```

## Decisión humana requerida

Para instalar desde terminal responde exactamente:

```text
AUTORIZO_INSTALAR_EXTENSION_KANBAN_MARKDOWN
```

Si prefieres instalarla manualmente desde VS Code, hazlo y devuelve:

```text
EXTENSION_INSTALADA_MANUALMENTE
```
