LAUNCHER_MANUAL

What it does:
- Reads a compact request.
- Writes summary, receipt and postcheck.
- Shows visible loading for long operations.
- Stays local-only and human-gated.

Human commands:
- SIGUIENTE: continue to the next logical step.
- PREPARA: prepare the next script.
- a: review the last script.
- p / ç: continue.

Key files:
- data/real-execution-launcher-186/real-execution-launcher.ps1
- data/real-execution-launcher-186/launcher-request-example.json
- data/real-execution-launcher-186/launcher-human-approval.json
- reports/real-execution-launcher-186/launcher-write-validation-report.json
- dashboard/launcher-dashboard/index.html

Usage pattern:
1. Review human approval.
2. Prepare or update a compact request.
3. Run the launcher in Plan or Run mode.
4. Check summary, receipt and postcheck.
5. Keep the cycle human-gated and local.
