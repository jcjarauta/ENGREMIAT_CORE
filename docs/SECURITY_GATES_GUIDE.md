# SECURITY_GATES_GUIDE

Politica: DEFAULT_DENY.

Sin aprobacion humana explicita no se permite:
- lanzar tarea Cline
- ejecutar worker real
- aplicar cambios generados
- escribir en Git
- conectar con Ollama remoto
- hacer inferencia
- abrir firewall
- arrancar servicios.

Estados validos de decision humana:
- APPROVE
- REJECT
- DEFER

Estado por defecto: DEFER.

Para este objetivo, las acciones reales quedan preparadas pero no ejecutadas.
