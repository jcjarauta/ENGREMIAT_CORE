# ENGREMIAT - Arbol operativo de decision

## Objetivo
Ordenar el sistema antes de seguir ampliando comandos.

## Contextos
1. Global: sin proyecto activo.
2. Proyecto: proyecto elegido.
3. Modulo: modulo elegido.
4. Smoke/worker: simulacion previa a ejecucion real.

## Regla principal
Los comandos visibles dependen del contexto activo. No mostrar comandos de modulo si no hay proyecto elegido. No mostrar worker real hasta gate fuerte.

## Flujo recomendado
nuevo-proyecto -> abrir-proyecto -> revisar-proyecto -> nuevo-modulo -> abrir-modulo -> contrato -> tareas -> evidencias -> gates -> preparar-smoke.

## Estado persistente necesario
Crear `data/operator-state/active-context.json` para dejar de depender del ultimo proyecto del escritorio.

## Siguiente
E02_CREATE_ACTIVE_CONTEXT_STATE
