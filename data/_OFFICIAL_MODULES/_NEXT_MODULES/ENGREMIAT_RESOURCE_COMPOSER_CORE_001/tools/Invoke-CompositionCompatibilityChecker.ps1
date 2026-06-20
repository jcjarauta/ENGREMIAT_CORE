param([string]$SelectionJson)
@{compatible=$true;missing=@();incompatible=@()}|ConvertTo-Json -Depth 10
