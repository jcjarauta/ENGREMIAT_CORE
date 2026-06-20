# E05 - GUIA MANUAL DE IMPORTACION EN OPEN WEBUI

## Objetivo
Crear la Knowledge Base ENGREMIAT_CORE en Open WebUI e importar el paquete documental inicial limpio.

## URL
http://localhost:3000

## Carpeta a importar
C:\ENGREMIAT_CORE\openwebui-knowledge\ENGREMIAT_CORE\_import_ready

## Documentos iniciales
1. 00_README_CONTEXT.md
2. 01_CURRENT_STATUS.md
3. 02_ROADMAP.md
4. 03_DEVELOPMENT_RULES.md
5. 04_SOURCE_CANDIDATES_INDEX.md
6. 05_OPENWEBUI_IMPORT_PLAN.md

## Pasos humanos
1. Abrir Open WebUI.
2. Entrar con el usuario administrador ya creado.
3. Ir a Workspace / Knowledge / Knowledge Bases, segun aparezca en la interfaz.
4. Crear una Knowledge Base llamada ENGREMIAT_CORE.
5. Subir los 6 documentos de la carpeta _import_ready.
6. Esperar a que Open WebUI complete indexacion/procesado.
7. Crear o abrir un chat con qwen3:14b.
8. Adjuntar/activar la Knowledge Base ENGREMIAT_CORE en el chat.
9. Ejecutar las preguntas de validacion del archivo 06_RAG_VALIDATION_TESTS.md.

## Politica
No subir todavia los 120 candidatos del shortlist. Primero validar RAG con el paquete minimo.

## Resultado esperado
Knowledge Base visible, indexada y usable desde chat.
