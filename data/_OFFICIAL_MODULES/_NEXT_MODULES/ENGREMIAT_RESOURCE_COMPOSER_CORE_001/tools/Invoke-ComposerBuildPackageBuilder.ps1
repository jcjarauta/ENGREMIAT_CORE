param([string]$BlueprintPath="$PSScriptRoot\..\..\..\..\..\reports\resource-composer-core-001\composition-blueprint-output.json",[string]$OutPath="$PSScriptRoot\..\..\..\..\..\reports\resource-composer-core-001\build-package-output.json")
$ErrorActionPreference='Stop'
$blueprint=@{}
if(Test-Path $BlueprintPath){$blueprint=Get-Content -Raw $BlueprintPath|ConvertFrom-Json}
$out=[ordered]@{output_type='BUILD_PACKAGE';package_id='BUILD-PACKAGE-DRYRUN-001';source_blueprint='composition-blueprint-output.json';resources=@('RESOURCE_A');actions=@(@{action='ASSEMBLE';mode='DRY_RUN';executes=$false});execution_policy='HUMAN_GATE_REQUIRED_BEFORE_REAL_EXECUTION';gate_required=$true;status='DRY_RUN_READY'}
$out|ConvertTo-Json -Depth 20|Set-Content -Encoding UTF8 $OutPath
$out|ConvertTo-Json -Depth 20
