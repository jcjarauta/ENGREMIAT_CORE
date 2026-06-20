# NEXT OBJECTIVE · ENGREMIAT_LOCAL_KANBAN_EXECUTION_CYCLE_001

## Objetivo

Convertir las piezas ya validadas en un ciclo operativo completo para una tarjeta.

## Entrada

Una card local generada desde Obsidian/Markdown/YAML con decisión GO y human_reviewed=true.

## Salida

Una card actualizada con transición de estado aplicada con backup, evidencia y dashboard refrescado.

## Flujo

```text
card → worker → response/evidence → transition proposal → human gate → card update → dashboard refresh
```

## Primer paso recomendado

E01_DEFINE_CARD_EXECUTION_CYCLE_CONTRACT

## Política

No depender de Cline/Kanban. El worker principal actual es Ollama local gated y mock para pruebas rápidas.
