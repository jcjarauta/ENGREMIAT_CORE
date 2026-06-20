# KNOWLEDGE SEGMENTATION STRATEGY

## Objetivo
Reducir latencia y mejorar precision separando Knowledge Bases o documentos por tipo de informacion.

## Segmentos propuestos
1. ENGREMIAT_CORE_FAST: contexto esencial diario.
2. ENGREMIAT_STATUS: estado operativo, readiness y siguientes pasos.
3. ENGREMIAT_ROADMAPS: etapas, bloques, TSV y planes.
4. ENGREMIAT_RULES: normas de desarrollo, gates y metodologia.
5. ENGREMIAT_ARCHITECTURE: arquitectura, modulos, nodos y workers.
6. ENGREMIAT_MANUALS: manuales humano-maquina.
7. ENGREMIAT_PROMPTS: prompts de continuidad y trabajo asistido.
8. ENGREMIAT_REPORTS_FULL: reports e historico para consulta profunda.

## Regla de uso
Para uso diario, consultar primero ENGREMIAT_CORE_FAST o el segmento especifico. Evitar adjuntar toda la documentacion si la pregunta es concreta.

## Telegram futuro
Telegram debe funcionar como capa de experiencia: seleccionar tipo de consulta, activar segmento correcto, reducir contexto enviado al modelo y devolver respuestas mas rapidas y guiadas.
