# OBSIDIAN TAXONOMY - ENGREMIAT

## Objetivo
Ordenar Obsidian para que cada nota pueda convertirse con baja friccion en Knowledge, Skill, prompt, decision, manual, roadmap o evidencia.

## Propiedades canonicas YAML
type: tipo principal de nota.
status: estado de madurez.
domain: area funcional.
workflow_stage: etapa del flujo.
openwebui_target: destino en Open WebUI.
export_target: fast, full, segment, skill, none.
skill_candidate: true/false.
priority: low, medium, high.
risk: low, medium, high.
source: origen.
created: fecha.
updated: fecha.
related: enlaces internos.

## type permitido
capture, canonical, decision, roadmap, status, architecture, manual, prompt, contract, report, skill-candidate, skill, knowledge, telegram-ux, openclaw, factory

## status permitido
inbox, draft, classified, canonical, export-ready, imported, deprecated, archived

## domain permitido
core, openwebui, obsidian, openclaw, telegram, backend, workers, knowledge, skills, ux, security

## workflow_stage permitido
capture, classify, canonicalize, validate, export, import, test, close

## openwebui_target permitido
none, ENGREMIAT_CORE_FAST, ENGREMIAT_CORE, ENGREMIAT_STATUS, ENGREMIAT_ROADMAPS, ENGREMIAT_RULES, ENGREMIAT_ARCHITECTURE, ENGREMIAT_MANUALS, ENGREMIAT_PROMPTS, ENGREMIAT_REPORTS, ENGREMIAT_DECISIONS, SKILL

## Tags canonicos
- #engremiat/inbox
- #engremiat/status
- #engremiat/roadmap
- #engremiat/decision
- #engremiat/architecture
- #engremiat/manual
- #engremiat/prompt
- #engremiat/contract
- #engremiat/report
- #engremiat/skill-candidate
- #engremiat/skill
- #openwebui/knowledge
- #openwebui/skill
- #openwebui/fast
- #openwebui/full
- #openwebui/segment
- #obsidian/canonical
- #obsidian/export-ready
- #telegram/ux
- #openclaw/deferred

## Regla de tags
Usar pocos tags por nota: 1 tag de proyecto, 1 de tipo, 1 de destino y 1 de estado si hace falta.
