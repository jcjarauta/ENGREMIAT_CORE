param([string]$Library="$PSScriptRoot\..\samples\library.json")
$resources=@(@{resource_id="RESOURCE_A";score=92;reason="high_reuse"})
$resources|ConvertTo-Json -Depth 10
