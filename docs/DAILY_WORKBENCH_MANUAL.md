# DAILY WORKBENCH MANUAL

Objective: 
ENGREMIAT_HUMAN_USABLE_DAILY_WORKBENCH_086_095
Stage: E93

## Proposito
La mesa diaria humana es la entrada unica para revisar trabajo, inbox, decisiones, evidencias, previews, bloqueos y siguiente accion segura.

## Principios
- El humano decide.
- ENGREMIAT prepara, registra y evidencia.
- La mesa no ejecuta acciones reales.
- No hay apply libre.
- No hay worker autonomo.
- No hay Kanban real write.
- No hay git_write salvo autorizacion explicita.

## Dashboards principales
- dashboard/index.html
- dashboard/daily-workbench/index.html
- dashboard/unified-human-inbox/index.html
- dashboard/evidence-browser/index.html
- dashboard/friction-reduction/index.html

## Archivos clave
- data/daily-workbench-086/daily-workbench-model.json
- data/unified-human-inbox-087/unified-human-inbox-items.jsonl
- data/decision-shortcuts-088/decision-shortcuts-contract.json
- data/evidence-browser-089/evidence-browser-index.json
- data/preview-apply-gate-090/preview-to-apply-authorization-gate.json
- data/friction-reduction-091/friction-reduction-plan.json
- data/dashboard-index-092/dashboard-index-v2-map.json

## Comandos utiles
- .\tools\eng-decision-shortcuts.ps1 -Decision DEFER -Reason "motivo" -TargetId "ID"

## Flujo diario
1. Abrir dashboard/index.html.
2. Revisar Daily Workbench.
3. Revisar Unified Human Inbox.
4. Revisar Evidence Browser.
5. Registrar decision con shortcut si procede.
6. Mantener preview/apply bloqueado salvo autorizacion futura explicita.

## Flags requeridos
apply_executed=false; auto_apply=false; remote_execution=false; git_write=false; external_network=false; worker_executed=false; kanban_real_write=false
