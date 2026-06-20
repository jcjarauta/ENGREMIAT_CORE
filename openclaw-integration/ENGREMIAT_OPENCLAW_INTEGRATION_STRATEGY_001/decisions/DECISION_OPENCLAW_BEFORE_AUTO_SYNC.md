# DECISION - OPENCLAW BEFORE AUTO SYNC

## Decision
Antes de sincronizar automaticamente Obsidian con Open WebUI, ENGREMIAT plantea la integracion de OpenClaw como capa de agente/gateway gobernada.

## Motivo
La sincronizacion automatica puede esperar. Primero hay que decidir que rol tendra OpenClaw, que podra leer, que no podra hacer y que gates humanos seran obligatorios.

## Estado
openclaw_strategy=True
auto_sync_deferred=True
read_only_first=True
gated_actions_later=True

## Consecuencia
El siguiente paso no es instalar OpenClaw todavia, sino cerrar mapa, inputs y caso de uso read-only.
