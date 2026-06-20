# ENGREMIAT CORE FAST CONTEXT

## Proposito
Este documento es el perfil rapido de la Knowledge Base ENGREMIAT_CORE_FAST. Resume solo el contexto esencial para reducir latencia en Open WebUI y responder preguntas basicas sin recuperar muchos documentos.

## Que es ENGREMIAT
ENGREMIAT es una plataforma local-first, modular y progresiva para construir una economia circular asistida por software, conocimiento estructurado, nodos humanos, nodos maquina, workers, tareas, proyectos, evidencias y sistemas de decision controlada. Su objetivo es reducir friccion humano-maquina y crear capacidades reutilizables para coordinar trabajo, recursos, conocimiento y automatizacion de forma segura.

## Estado actual de infraestructura
docker_ready=True
postgres_ready=True
backend_ready=True
ollama_ready=True
qwen3_14b_ready=True
openwebui_ready=True
gpu_ollama_ready=True
knowledge_base_ready=False
latency_status=WARN

Infraestructura validada: Docker Desktop operativo; PostgreSQL 17 en contenedor Docker; base de datos engremiat creada y accesible; backend NestJS en C:\ENGREMIAT_CORE\backend con build TypeScript OK, conexion PostgreSQL OK y smoke test DB OK; Ollama operativo; modelo qwen3:14b instalado y visible en Open WebUI; Open WebUI accesible en http://localhost:3000; chat validado; GPU usada correctamente por Ollama.

## Roadmap de ENGREMIAT_OPENWEBUI_KNOWLEDGE_BASE_001
E01 Diseno de estructura documental: completado.
E02 Consolidacion documental: completado con inventario y shortlist.
E03 Construccion de contexto maestro: completado.
E04 Construccion de estado operativo: completado.
E05 Importacion en Open WebUI: completado manualmente.
E06 Validacion RAG: en WARN controlado por calidad irregular y latencia alta.
E07 Cierre: pendiente hasta validar una experiencia RAG rapida y util.

## Reglas activas de desarrollo
1. Local First.
2. Sin dependencias cloud obligatorias.
3. Una frontera tecnica por bloque.
4. Validar antes de avanzar.
5. Construir capacidades reutilizables.
6. Reducir friccion humano-maquina.
7. Priorizar activos permanentes frente a automatizaciones prematuras.
8. Crear primero memoria estructurada antes de agentes complejos.
9. Segmentar el trabajo en etapas.
10. Cada etapa debe tener evidencias verificables.
11. No automatizar fases que todavia no han sido usadas manualmente.
12. Mantener arquitectura modular.
13. Evitar dependencias innecesarias.
14. Priorizar documentacion reutilizable.
15. No mover ni eliminar originales sin gate humano.
16. Mantener compatibilidad futura con Open WebUI, Ollama, Knowledge Bases, Skills, Workspaces, agentes locales y ENGREMIAT OS.

## Politica de Knowledge Base
ENGREMIAT_CORE_FULL o ENGREMIAT_CORE mantiene documentacion amplia. ENGREMIAT_CORE_FAST debe contener solo contexto esencial para uso diario rapido. El objetivo es responder con menos fuentes, menos latencia y menos dispersion.

## Siguiente objetivo previsto
El siguiente objetivo previsto despues de la Knowledge Base es ENGREMIAT_OPENWEBUI_SKILLS_001. Ese objetivo transformara procedimientos, normas, metodologias y flujos repetibles de ENGREMIAT en Skills reutilizables dentro de Open WebUI.

## Preguntas de validacion rapida
1. Que es ENGREMIAT?
2. Cual es el estado actual de la infraestructura?
3. Cual es el roadmap de ENGREMIAT_OPENWEBUI_KNOWLEDGE_BASE_001?
4. Que reglas de desarrollo estan activas?
5. Cual es el siguiente objetivo previsto despues de la Knowledge Base?

## Criterio de cierre
La Knowledge Base rapida se considera valida si responde correctamente 4 de 5 preguntas con menor latencia percibida que ENGREMIAT_CORE.
