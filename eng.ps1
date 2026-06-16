# PLAN_TO_WORKER_COMMAND_HUB_WRAPPER
$ErrorActionPreference="Stop"
$cmd=[string]$args[0]
if($cmd -like "plan-*"){& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/plan-to-worker/Invoke-PlanToWorkerCommand.ps1" @args;exit $LASTEXITCODE}
& powershell -NoProfile -ExecutionPolicy Bypass -File "eng.ps1.before-plan-to-worker.bak" @args;exit $LASTEXITCODE
