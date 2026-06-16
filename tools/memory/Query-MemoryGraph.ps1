param([string]$Query="summary",[string]$Text="",[string]$NodesPath="ENGREMIAT_MEMORY/graph/export/nodes.jsonl",[string]$EdgesPath="ENGREMIAT_MEMORY/graph/export/edges.jsonl",[string]$OutPath="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function LJ($p){$a=@();if(Test-Path -LiteralPath $p -PathType Leaf){foreach($l in Get-Content -LiteralPath $p -Encoding UTF8){if([string]::IsNullOrWhiteSpace($l)){continue};try{$a+=($l|ConvertFrom-Json)}catch{}}};return @($a)}
function ED($p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WJ($p,$o){ED(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$nodes=LJ $NodesPath;$edges=LJ $EdgesPath;$result=[ordered]@{query=$Query;text=$Text;nodes_count=$nodes.Count;edges_count=$edges.Count;items=@();created_at=(Get-Date).ToString("s")}
if($Query -eq "summary"){$result.items=@([ordered]@{label="summary";nodes=$nodes.Count;edges=$edges.Count;types=@($nodes|Group-Object type|ForEach-Object{$_.Name+":"+$_.Count})})}
elseif($Query -eq "search"){$result.items=@($nodes|Where-Object{([string]$_.label+" "+[string]$_.path+" "+[string]$_.type) -match [regex]::Escape($Text)}|Select-Object -First 50)}
elseif($Query -eq "errors"){$result.items=@($nodes|Where-Object{$_.type -eq "Error" -or $_.path -match "ERRORS|errors|error"}|Select-Object -First 50)}
elseif($Query -eq "gates"){$result.items=@($nodes|Where-Object{$_.type -eq "Gate" -or $_.path -match "GATES|gates|gate"}|Select-Object -First 50)}
elseif($Query -eq "artifacts"){$result.items=@($nodes|Where-Object{$_.type -eq "Artifact" -or $_.path -match "artifact|ARTIFACT|registry"}|Select-Object -First 50)}
elseif($Query -eq "dependencies"){$result.items=@($edges|Where-Object{$_.type -in @("depends_on","contains","produces","validates")}|Select-Object -First 80)}
else{$result.items=@($nodes|Select-Object -First 30)}
if([string]::IsNullOrWhiteSpace($OutPath)){Write-Host ($result|ConvertTo-Json -Depth 50 -Compress)}else{WJ $OutPath $result;Write-Host ("OK memory_graph_query=True query="+$Query+" items="+@($result.items).Count+" output="+$OutPath)}
