# ENGREMIAT CORE - CONTEXTO MAESTRO PARA KNOWLEDGE BASE

## Identidad
ENGREMIAT es una plataforma local-first, modular y progresiva para construir una economia circular asistida por software, conocimiento estructurado, nodos humanos, nodos maquina, workers, tareas, proyectos, evidencias y sistemas de decision controlada.

## Objetivo actual
Construir la primera Knowledge Base operativa de ENGREMIAT sobre Open WebUI local para que qwen3:14b mediante Ollama pueda consultar documentacion, manuales, contratos, roadmaps, prompts y estado del proyecto desde una base documental unica.

## Estado validado
La infraestructura local esta operativa: Docker Desktop, PostgreSQL 17 en contenedor, base de datos engremiat, backend NestJS con build OK, conexion PostgreSQL OK, smoke test DB OK, Ollama operativo, qwen3:14b instalado, Open WebUI accesible en http://localhost:3000, usuario administrador creado, modelo visible, chat validado y GPU utilizada correctamente por Ollama.

## Readiness
docker_ready=True
postgres_ready=True
backend_ready=True
ollama_ready=True
openwebui_ready=True
knowledge_base_ready=False

## Filosofia activa
Local First. Sin dependencias cloud obligatorias. Una frontera tecnica por bloque. Validar antes de avanzar. Construir capacidades reutilizables. Reducir friccion humano-maquina. Priorizar activos permanentes frente a automatizaciones prematuras. Crear primero memoria estructurada antes de crear agentes complejos.

## Arquitectura conceptual
Open WebUI actua como interfaz humana y capa de consulta RAG. Ollama aporta inferencia local. qwen3:14b es el modelo local principal. PostgreSQL y NestJS forman la base tecnica backend inicial. La Knowledge Base es la memoria documental consultable. Skills y agentes se desarrollaran despues, cuando la memoria sea estable.

## Politica de conocimiento
No importar basura historica masiva. Primero pocos documentos limpios. Despues ampliar por categorias verificadas. El objetivo de esta Knowledge Base es responder correctamente a preguntas basicas sobre vision, roadmap, estado, arquitectura, reglas y siguientes pasos.

## Siguiente paso
Importar manualmente en Open WebUI los documentos de la carpeta _import_ready y validar RAG con preguntas de control.

## Siguiente objetivo previsto
ENGREMIAT_OPENWEBUI_SKILLS_001
La Knowledge Base crea memoria consultable; el objetivo siguiente convertira procedimientos ENGREMIAT en Skills reutilizables dentro de Open WebUI.
