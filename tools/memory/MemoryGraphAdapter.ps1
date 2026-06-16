param([string]$Command="status",[string]$Query="summary",[string]$Text="")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
if($Command -eq "status"){Write-Host "OK memory_graph_adapter_status=LOCAL_QUERYABLE mode=NO_GO_INGEST external_network=False database=False";exit 0}
if($Command -eq "export"){if(Test-Path -LiteralPath "tools/memory/Export-MemoryGraphJsonl.ps1"){& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/memory/Export-MemoryGraphJsonl.ps1";exit $LASTEXITCODE};Write-Host "NO_GO export_tool_missing=True";exit 1}
if($Command -eq "query"){& powershell -NoProfile -ExecutionPolicy Bypass -File "tools/memory/Query-MemoryGraph.ps1" -Query $Query -Text $Text;exit $LASTEXITCODE}
if($Command -eq "ingest"){Write-Host "NO_GO memory_graph_adapter_ingest=False reason=Graphiti_Memgraph_Neo4j_not_enabled authorization_required=True external_network=False database=False";exit 1}
Write-Host "Uso: .\tools\memory\MemoryGraphAdapter.ps1 status|export|query|ingest";exit 0
