$ErrorActionPreference='Stop'
$ProgressPreference='SilentlyContinue'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_LAUNCHER_CANONICAL_ACTION_RUNTIME_001'
$stage='RUNTIME_NOOP_BLOCKED_BY_DEFAULT'
function W($m,$c='Gray'){Write-Host $m -ForegroundColor $c}
W "ENGREMIAT_PACKAGE_BEGIN package=$package stage=$stage" Cyan
W "NO_GO canonical_action_runtime_noop=True authorization_required=True real_execution=False worker=False browser=False network=False git=False reason=RUNTIME_SKELETON_ONLY" Yellow
W "ENGREMIAT_PACKAGE_END package=$package status=NO_GO reason=RUNTIME_SKELETON_ONLY" Yellow
exit 0
