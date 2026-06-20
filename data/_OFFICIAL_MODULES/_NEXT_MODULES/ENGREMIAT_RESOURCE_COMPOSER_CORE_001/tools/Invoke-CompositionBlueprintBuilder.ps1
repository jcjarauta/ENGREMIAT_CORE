param([string]$CompatibilityJson)
@{output_type="COMPOSITION_BLUEPRINT";resources=@("RESOURCE_A");build_package_ready=$false}|ConvertTo-Json -Depth 10
