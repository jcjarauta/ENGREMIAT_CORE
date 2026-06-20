# B05 MANUAL TEST GUIDE - OPENWEBUI FACTORY PACKAGE 001

## Objetivo
Probar el primer paquete factory en Open WebUI con la minima friccion humana posible y sin API real.

## Estado
package_ready=True
skills_count=
3
knowledge_fast_count=
6
api_real_write=False
openwebui_write=False
manual_test_required=True

## Prueba recomendada
1. Abrir Open WebUI en http://localhost:3000.
2. Crear o actualizar una Knowledge llamada ENGREMIAT_FACTORY_TEST_FAST.
3. Importar/subir los documentos de knowledge-fast.
4. Crear una sola Skill de prueba desde skills.
5. Ejecutar los prompts de tests/VALIDATION_PROMPTS.md.
6. Rellenar evidence/MANUAL_TEST_RESULT_TEMPLATE.md.

## Criterio PASS
La Skill reduce friccion, usa contexto ENGREMIAT, no inventa acciones externas, identifica NEXT correcto y permite validar logs/bloques.

## Criterio WARN
La respuesta es util pero incompleta, lenta o requiere mejorar la plantilla.

## Criterio FAIL
No usa contexto, inventa datos, propone OpenClaw/API/Telegram sin gate, o no mejora frente al chat normal.

## No hacer
No activar API real. No Tools. No Functions. No OpenClaw. No Telegram real.
