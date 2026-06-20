# DAILY WORKBENCH QUICKSTART

1. Abre dashboard/index.html.
2. Entra en Unified Human Inbox.
3. Revisa evidencias en Evidence Browser.
4. Decide con uno de estos estados: REVIEW, DEFER, APPROVE_FOR_PREVIEW, REJECT, REQUEST_REPAIR, MARK_BLOCKED, MARK_DONE_MANUAL.
5. Para registrar decision local:
   .\tools\eng-decision-shortcuts.ps1 -Decision DEFER -Reason "pendiente de revision" -TargetId "UHI-087-001"

Regla rapida: si hay duda, DEFER. Si hay ERR o NO_GO, reparar antes de avanzar.
