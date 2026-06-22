# MANUAL ARQUITECTURA V0

## Arquitectura actual
ENGREMIAT se organiza alrededor de evidencias, runtime canonico, launcher, adaptadores y observador.

## Cadena de accion segura
propuesta -> preview -> gate humano -> autorizacion explicita -> unlock -> plan -> runner -> ejecucion local -> evidencia

## Capa observer
inventario -> diagnostico -> manual -> mejoras -> tareas -> propuestas canonicas

## Reglas
- Readonly primero.
- Reports son evidencia.
- Estado mutable solo en rutas canonicas controladas.
- Acciones sensibles siempre con autorizacion explicita.
