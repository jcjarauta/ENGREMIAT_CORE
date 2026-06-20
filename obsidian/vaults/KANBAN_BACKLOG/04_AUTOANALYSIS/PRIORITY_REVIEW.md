# PRIORITY_REVIEW · 25 SYSTEM NEEDS

## Resumen

| metric | value |
|---|---|
| cards_total | 25 |
| automation_candidates | 24 |
| high_risk | 6 |
| quick_wins_low_risk | 10 |
| blocked |  |

## Por area

| area | count |
|---|---|
| core | 5 |
| adapters | 3 |
| kanban | 3 |
| cline | 2 |
| visual_memory | 2 |
| bundles | 2 |
| ollama | 2 |
| vaults | 2 |
| nodes | 1 |
| resources | 1 |
| openwebui | 1 |
| skills | 1 |

## Por riesgo

| risk | count |
|---|---|
| HIGH | 6 |
| LOW | 10 |
| MEDIUM | 9 |

## Por nivel de automatizacion

| automation_level | count |
|---|---|
| ASSISTED | 20 |
| BLOCKED | 1 |
| SEMI_AUTOMATED | 4 |

## Por adapter requerido

| adapter | count |
|---|---|
| OBSIDIAN | 11 |
| POWERSHELL | 7 |
| OPENWEBUI | 3 |
| OLLAMA | 1 |
| OPENCLAW_FUTURE | 1 |
| KANBAN | 1 |
| CLINE | 1 |

## Quick wins candidatos

| card_id | title | area | adapter | automation | risk |
|---|---|---|---|---|---|
| SYSTEM_NEED_001 | Arquitectura Obsidian visible | vaults | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_004 | Bundles limpios para Ollama | ollama | OPENWEBUI | ASSISTED | LOW |
| SYSTEM_NEED_005 | Registry de skills OpenWebUI | skills | OPENWEBUI | ASSISTED | LOW |
| SYSTEM_NEED_010 | OpenWebUI Knowledge Base | openwebui | OPENWEBUI | ASSISTED | LOW |
| SYSTEM_NEED_012 | Resource Library reusable | resources | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_016 | Evidence First universal | core | POWERSHELL | ASSISTED | LOW |
| SYSTEM_NEED_017 | Estado y NEXT global | core | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_018 | Taxonomia YAML y tags | vaults | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_020 | Dashboard humano Obsidian-Kanban | kanban | OBSIDIAN | ASSISTED | LOW |
| SYSTEM_NEED_025 | Cierre y handoff de contexto | bundles | OBSIDIAN | ASSISTED | LOW |

## Riesgo alto: revisar con gate antes de tocar

| card_id | title | adapter | automation |
|---|---|---|---|
| SYSTEM_NEED_006 | Governance de gates humanos | OBSIDIAN | ASSISTED |
| SYSTEM_NEED_007 | Worker adapters gobernados | OBSIDIAN | ASSISTED |
| SYSTEM_NEED_008 | Cline proposal-only | CLINE | SEMI_AUTOMATED |
| SYSTEM_NEED_021 | Control de un solo escritor | OBSIDIAN | ASSISTED |
| SYSTEM_NEED_022 | OpenClaw adapter futuro | OPENCLAW_FUTURE | BLOCKED |
| SYSTEM_NEED_023 | Controlled Apply reusable | POWERSHELL | SEMI_AUTOMATED |

## Decision recomendada

1. Empezar por quick wins LOW/MEDIUM con adapter OBSIDIAN, OPENWEBUI o POWERSHELL.
2. Mantener HIGH en revision humana/gate.
3. No ejecutar automatizacion real todavia.
4. Convertir esta revision en `REFRESH_PROPOSAL.md`.
