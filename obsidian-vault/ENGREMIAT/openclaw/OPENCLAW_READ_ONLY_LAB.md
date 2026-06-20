# READ ONLY LAB - OPENCLAW

## Objetivo
Preparar un laboratorio conceptual para evaluar OpenClaw sin escritura, sin ejecucion y sin credenciales.

## Caso de uso minimo
Leer estado ENGREMIAT preparado y proponer siguiente accion, sin ejecutar nada.

## Entrada permitida
- CURRENT_STATUS preparado.
- NEXT_ACTIONS preparado.
- Skill candidates documentales.
- Politica de limites.

## Salida esperada
- Resumen de estado.
- Riesgos.
- Siguiente accion recomendada.
- Preguntas al humano si falta informacion.

## Prohibiciones
No ejecutar comandos. No escribir archivos. No llamar APIs. No enviar mensajes. No modificar Knowledge Bases.

## Criterio PASS
PASS si OpenClaw ayuda a reducir friccion de lectura/decision sin aumentar riesgo.

## Criterio FAIL
FAIL si requiere demasiados permisos, es lento, opaco o induce acciones sin gate.
