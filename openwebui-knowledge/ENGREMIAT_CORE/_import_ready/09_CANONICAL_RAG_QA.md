# 09 CANONICAL RAG QA - ENGREMIAT CORE

Este documento contiene las respuestas canonicas para validar la Knowledge Base ENGREMIAT_CORE en Open WebUI. Debe usarse como fuente prioritaria para las preguntas basicas de validacion RAG.

## Pregunta 1: Que es ENGREMIAT?

ENGREMIAT es una plataforma local-first, modular y progresiva para construir una economia circular asistida por software, conocimiento estructurado, nodos humanos, nodos maquina, workers, tareas, proyectos, evidencias y sistemas de decision controlada. Su objetivo es reducir friccion humano-maquina y crear capacidades reutilizables para coordinar trabajo, recursos, conocimiento y automatizacion de forma segura.

## Pregunta 2: Cual es el estado actual de la infraestructura?

El estado actual de la infraestructura es operativo. Docker Desktop esta instalado y funcionando. PostgreSQL 17 esta operativo en un contenedor Docker. La base de datos engremiat existe y es accesible. El backend NestJS esta creado en C:\ENGREMIAT_CORE\backend con build TypeScript OK, conexion PostgreSQL OK y smoke test DB OK. Ollama esta operativo. El modelo qwen3:14b esta instalado, visible en Open WebUI y responde correctamente. Open WebUI esta instalado mediante Docker y accesible en http://localhost:3000. El chat ha sido validado y Ollama usa correctamente la GPU.

## Pregunta 3: Cual es el roadmap de ENGREMIAT_OPENWEBUI_KNOWLEDGE_BASE_001?

El roadmap de ENGREMIAT_OPENWEBUI_KNOWLEDGE_BASE_001 tiene siete etapas: E01 Diseno de estructura documental; E02 Consolidacion documental; E03 Construccion de contexto maestro; E04 Construccion de estado operativo; E05 Importacion en Open WebUI; E06 Validacion RAG; E07 Cierre y readiness report. En el estado actual, E01, E02, E03, E04 y E05 estan completadas; E06 esta en validacion con reparaciones RAG; E07 queda pendiente hasta confirmar que al menos 4 de 5 pruebas RAG responden correctamente.

## Pregunta 4: Que reglas de desarrollo estan activas?

Las reglas de desarrollo activas son: Local First; sin dependencias cloud obligatorias; una frontera tecnica por bloque; validar antes de avanzar; construir capacidades reutilizables; reducir friccion humano-maquina; priorizar activos permanentes frente a automatizaciones prematuras; crear primero memoria estructurada antes de agentes complejos; segmentar el trabajo en etapas; cada etapa debe tener evidencias verificables; no automatizar fases que todavia no han sido utilizadas manualmente; mantener arquitectura modular; evitar dependencias innecesarias; priorizar documentacion reutilizable; no mover ni eliminar originales sin gate humano; mantener compatibilidad futura con Open WebUI, Ollama, Knowledge Bases, Skills, Workspaces, agentes locales y ENGREMIAT OS.

## Pregunta 5: Cual es el siguiente objetivo previsto despues de la Knowledge Base?

El siguiente objetivo previsto despues de la Knowledge Base es ENGREMIAT_OPENWEBUI_SKILLS_001. Ese objetivo transformara procedimientos, normas, metodologias y flujos repetibles de ENGREMIAT en Skills reutilizables dentro de Open WebUI.

## Criterio de validacion

La Knowledge Base se considera lista si Open WebUI responde correctamente al menos 4 de estas 5 preguntas usando fuentes documentales de ENGREMIAT_CORE.
