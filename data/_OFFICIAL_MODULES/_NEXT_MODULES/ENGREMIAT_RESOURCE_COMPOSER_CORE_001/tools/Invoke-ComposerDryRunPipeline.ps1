$ErrorActionPreference='Stop'
$root=Split-Path -Parent $PSScriptRoot
$report='C:\ENGREMIAT_CORE\reports\resource-composer-core-001'
$selection=& powershell -NoProfile -File "$PSScriptRoot\Invoke-ResourceSelectionEngine.ps1"
$compat=& powershell -NoProfile -File "$PSScriptRoot\Invoke-CompositionCompatibilityChecker.ps1"
$blueprint=& powershell -NoProfile -File "$PSScriptRoot\Invoke-CompositionBlueprintBuilder.ps1"
$build=& powershell -NoProfile -File "$PSScriptRoot\Invoke-ComposerBuildPackageBuilder.ps1"
$out=[ordered]@{package_id='ENGREMIAT_RESOURCE_COMPOSER_CORE_001';pipeline='QUERY_SELECTION_COMPATIBILITY_BLUEPRINT_BUILD_PACKAGE';status='PASS';ai=$false;ollama=$false;network=$false;real_execution=$false;gate_required=$true;outputs=@('resource-selection-output.json','composition-compatibility-report.json','composition-blueprint-output.json','build-package-output.json')}
$out|ConvertTo-Json -Depth 20|Set-Content -Encoding UTF8 "$report\composer-dry-run-report.json"
$out|ConvertTo-Json -Depth 20
