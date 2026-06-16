VISUAL_PERSISTENCE_OPTIONAL_TOOLS

Estado: Graphviz y SQLite son herramientas opcionales.

Si faltan:
- No bloquean el core.
- No bloquean Cline/Ollama.
- No sustituyen JSON todavía.

Uso futuro:
- Graphviz: exportar graph.json a DOT/SVG.
- SQLite: persistencia local ligera cuando el JSON empiece a quedarse corto.

Instalación solo con gate humano:
- tools/toolchain/Install-GraphvizGate.ps1 --execute
- tools/toolchain/Install-SqliteGate.ps1 --execute
