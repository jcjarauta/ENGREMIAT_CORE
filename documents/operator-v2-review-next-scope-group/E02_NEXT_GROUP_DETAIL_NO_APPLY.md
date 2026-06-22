# E02 Next Group Detail No Apply

Estado: PASS
Apply changes: NO
Delete files: NO
Commit: NO
Push: NO
Source: 
C:\ENGREMIAT_CORE\reports\operator-v2-review-next-scope-group\e01-select-inspect-next-scope-group-no-apply-20260622-073122.json

## Selected module
ENGREMIAT.cmd

## Details

### ENGREMIAT.cmd
- Exists: True
- Is directory: False
- Size: 129
- Modified: 2026-06-20T13:16:13
- Classification: WINDOWS_LAUNCHER_SCRIPT
- Recommendation: INSPECT_AND_COMPARE_WITH_CANONICAL_LAUNCHER_BEFORE_SCOPED_COMMIT

```text
@echo off
cd /d C:\ENGREMIAT_CORE
powershell.exe -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\ENGREMIAT.ps1"

```

## Decision
REVIEW_CMD_LAUNCHER_BEFORE_TRACKING_OR_IGNORE

## Siguiente
E03_DECIDE_NEXT_GROUP_ACTION_NO_APPLY
