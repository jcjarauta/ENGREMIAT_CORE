---
name: engremiat-readonly-intake
description: Convert OpenWebUI/OpenClaw conversations into ENGREMIAT readonly intake JSON packets without executing actions.
---

# ENGREMIAT Readonly Intake Skill

## Purpose
Convert a conversation, thread summary, user request, assistant proposal, blocker, evidence note or project idea into a JSON packet that can be dropped into ENGREMIAT readonly inbox.

## ENGREMIAT inbox target
docs/openwebui-openclaw-readonly-adapter/inbox

## Mandatory rules
- Do not execute commands.
- Do not modify repositories.
- Do not write to native Kanban.
- Do not write to Obsidian vault.
- Do not browse.
- Do not call external APIs.
- Do not start agents.
- Produce one JSON packet only.
- Require human review.
- Set execution_allowed=false.
- Set native_kanban_write=disabled.
- Set obsidian_real_write=disabled.

## Output JSON fields
- thread_id
- source
- via
- title
- user_intent
- assistant_summary
- proposed_kind
- priority
- risk
- target_consumers

## Allowed proposed_kind
- need
- capability
- project
- evidence
- blocker
- decision
- memory

## Allowed risk
- LOW
- MEDIUM
- HIGH

## Default routing
OpenWebUI or chat conversation -> OpenClaw skill -> JSON packet -> ENGREMIAT readonly inbox -> detected-input -> recurrent card -> Obsidian candidate -> human review.

## Response format
Return only valid JSON compatible with the output contract. No markdown fence. No commentary.
