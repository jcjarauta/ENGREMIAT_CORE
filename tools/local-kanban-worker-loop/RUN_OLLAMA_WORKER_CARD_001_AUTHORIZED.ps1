param([switch]$IUnderstandThisRunsLocalAI)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
if(-not $IUnderstandThisRunsLocalAI){throw "AUTHORIZATION_FLAG_REQUIRED: rerun with -IUnderstandThisRunsLocalAI after explicit human authorization"}
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\local-kanban-worker-loop\Invoke-LocalKanbanWorkerLoop.ps1 -CardId CARD-001 -Transport ollama -AuthorizeRealWorker
