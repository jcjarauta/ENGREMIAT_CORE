# Reusable Operational Template

## Purpose
[Describe the concrete operational task and why it matters.]

## When to use
[Describe when a human should use this template.]

## Inputs
- Objective: [write objective]
- Expected artifact: [write output path/type]
- Human-editable input: [write source input]
- Safety limits: local-only, no network, no git write, no destructive action
- Validation criteria: [write checks]

## Operational steps
1. Define the operational task and reusable output.
2. Capture local editable input.
3. Build proposal, expected evidence and preview.
4. Require explicit human authorization.
5. Apply only the approved local artifact creation.
6. Run postcheck and non-destructive rollback drill.
7. Register evidence and observed value.
8. Refresh human dashboard.
9. Run regression before close.
10. Close with manifest and next objective.

## Validation
The result is valid when the output exists, is human-readable, is reusable, includes safety limits, and has postcheck plus regression evidence.

## Safety
No network. No git write. No external execution. No destructive action. Rollback must be limited to artifacts created by the current stage.

## Source artifact excerpt
```
# Operational Reusable Artifact

## Purpose
Provide a reusable human-machine protocol for preparing and executing small operational ENGREMIAT tasks with explicit authorization, evidence and rollback discipline.

## When to use
Use this artifact when a future task must move beyond a summary document and produce a reusable project artifact while remaining local-only, reversible and human-governed.

## Inputs
- Concrete operational objective.
- Expected reusable artifact.
- Human-editable input draft.
- Safety limits.
- Validation criteria.
- Next action.

## Operational steps
1. Define the operational task and its reusable output.
2. Capture local editable input.
3. Build proposal, expected evidence and preview.
4. Require human authorization with explicit phrase.
5. Apply only the approved local artifact creation.
6. Run postcheck and non-destructive rollback drill.
7. Register evidence and observed value.
8. Refresh human dashboard.
9. Run regression before close.
10. Close with manifest and next objective.

## Validation
The artifact is valid if it is Markdown, human-readable, reusable, local-only, reversible, and includes purpose, usage conditions, inputs, steps, validation and n
```

## Next action
Use this template to prepare a controlled launch packet before starting the next operational task.
