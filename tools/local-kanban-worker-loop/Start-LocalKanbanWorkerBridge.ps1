param([int]$Port=8766)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$root=(Get-Location).Path
$dispatcher=Join-Path $root "tools/local-kanban-worker-loop/Invoke-LocalKanbanWorkerLoop.ps1"
if(-not(Test-Path -LiteralPath $dispatcher -PathType Leaf)){throw "MISSING_DISPATCHER_$dispatcher"}
$listener=[System.Net.HttpListener]::new()
$prefix="http://127.0.0.1:$Port/"
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "ENGREMIAT_WORKER_BRIDGE_RUNNING url=$prefix transports=mock,ollama_gated ctrl_c_to_stop" -ForegroundColor Green
while($listener.IsListening){
  $ctx=$listener.GetContext()
  try{
    $path=$ctx.Request.Url.AbsolutePath
    $card=$ctx.Request.QueryString["card_id"]
    $transport=$ctx.Request.QueryString["transport"]
    $auth=$ctx.Request.QueryString["auth"]
    if([string]::IsNullOrWhiteSpace($card)){$card="CARD-001"}
    if([string]::IsNullOrWhiteSpace($transport)){$transport="mock"}
    $ctx.Response.Headers.Add("Access-Control-Allow-Origin","*")
    $ctx.Response.ContentType="application/json; charset=utf-8"
    if($path -eq "/health"){
      $body=@{ok=$true;bridge="engremiat-local-kanban-worker-bridge";port=$Port;transports=@("mock","ollama_gated")}|ConvertTo-Json -Compress
    }elseif($path -eq "/run"){
      if($transport -eq "ollama"){
        if($auth -ne "AUTORIZO_OLLAMA_WORKER_TRANSPORT_REAL_CARD_001_PROPOSAL_ONLY"){throw "OLLAMA_AUTH_PHRASE_REQUIRED"}
        $out=& powershell -NoProfile -ExecutionPolicy Bypass -File $dispatcher -CardId $card -Transport ollama -AuthorizeRealWorker 2>&1
      }else{
        $out=& powershell -NoProfile -ExecutionPolicy Bypass -File $dispatcher -CardId $card -Transport mock 2>&1
      }
      $ok=($LASTEXITCODE -eq 0 -or $null -eq $LASTEXITCODE)
      $body=@{ok=$ok;card_id=$card;transport=$transport;output=($out -join "`n")}|ConvertTo-Json -Depth 10 -Compress
    }else{
      $ctx.Response.StatusCode=404
      $body=@{ok=$false;error="not_found";path=$path}|ConvertTo-Json -Compress
    }
  }catch{
    $ctx.Response.StatusCode=500
    $body=@{ok=$false;error=$_.Exception.Message}|ConvertTo-Json -Compress
  }
  $bytes=[Text.Encoding]::UTF8.GetBytes($body)
  $ctx.Response.OutputStream.Write($bytes,0,$bytes.Length)
  $ctx.Response.Close()
}
