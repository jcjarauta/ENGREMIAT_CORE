PLAN_INTAKE_MANUAL

What this stage does:
- Presents a standardized way to enter plans into ENGREMIAT.
- Uses a readonly phase first, then controlled write with human approval.

How to use it:
1. Prepare the plan contract.
2. Generate the human preview.
3. Validate the preview and contract.
4. Build the plan-to-launcher request.
5. Confirm human approval.
6. Hand off to the reusable launcher.
7. Review the dashboard and close report.

Key files:
- data/plan-intake-188/plan-intake-contract.json
- data/plan-intake-189/plan-preview.md
- reports/plan-intake-189/plan-validation-report.json
- data/plan-intake-190/plan-to-launcher.json
- data/plan-intake-190/plan-human-approval.json
- data/plan-intake-190/plan-launcher-handoff.json
- dashboard/plan-intake-dashboard/index.html

Human commands:
- SIGUIENTE: continue.
- PREPARA: prepare next script.
- a: review last script.
- p / ç: continue.
