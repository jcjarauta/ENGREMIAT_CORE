param([int]$Port=8771)
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()

function SendJson($ctx,$obj){
  $json=($obj|ConvertTo-Json -Depth 60)
  $b=[Text.Encoding]::UTF8.GetBytes($json)
  $ctx.Response.StatusCode=200
  $ctx.Response.ContentType="application/json; charset=utf-8"
  $ctx.Response.Headers.Add("Access-Control-Allow-Origin","*")
  $ctx.Response.Headers.Add("Access-Control-Allow-Methods","GET,POST,OPTIONS")
  $ctx.Response.Headers.Add("Access-Control-Allow-Headers","Content-Type")
  $ctx.Response.OutputStream.Write($b,0,$b.Length)
  $ctx.Response.Close()
}
function SendText($ctx,$txt){
  $b=[Text.Encoding]::UTF8.GetBytes($txt)
  $ctx.Response.StatusCode=200
  $ctx.Response.ContentType="text/plain; charset=utf-8"
  $ctx.Response.Headers.Add("Access-Control-Allow-Origin","*")
  $ctx.Response.OutputStream.Write($b,0,$b.Length)
  $ctx.Response.Close()
}
function ReadProp($txt,$key,$def=""){
  if($txt -match "(?m)^\s*$([regex]::Escape($key)):\s*(.+?)\s*$"){
    return (($matches[1] -replace '^"|"$','').Trim())
  }
  return $def
}
function GetCards($root){
  $cardsDir=Join-Path $root "obsidian/ENGREMIAT_OBSIDIAN_KANBAN_LAB/12_MARKDOWN_KANBAN_TEST/cards"
  $cards=@()
  foreach($f in @(Get-ChildItem -LiteralPath $cardsDir -Filter "CARD-*.md" -File|Sort-Object Name)){
    $txt=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8
    $id=ReadProp $txt "id" $f.BaseName
    $st=(ReadProp $txt "status" "BACKLOG").ToUpper()
    $col=(ReadProp $txt "recommended_column" $st).ToUpper()
    $cards+=[ordered]@{
      id=$id
      title=ReadProp $txt "title" $f.BaseName
      status=$st
      recommended_column=$col
      priority=(ReadProp $txt "priority" "MEDIUM").ToUpper()
      kanban_decision=(ReadProp $txt "kanban_decision" "PENDING").ToUpper()
      human_reviewed=(ReadProp $txt "human_reviewed" "false").ToLower()
      last_cycle_id=ReadProp $txt "last_cycle_id" ""
      last_transition_id=ReadProp $txt "last_transition_id" ""
      path=$f.FullName
    }
  }
  return $cards
}
function FindLatest($dir,$cardId,$suffix){
  $x=@(Get-ChildItem -LiteralPath $dir -Filter ("*"+$cardId+"*"+$suffix) -File -ErrorAction SilentlyContinue|Sort-Object LastWriteTime -Descending|Select-Object -First 1)
  if($x.Count -gt 0){return $x[0].FullName}
  return ""
}

$root=(Get-Location).Path
$prefix="http://127.0.0.1:$Port/"
$listener=[System.Net.HttpListener]::new()
$listener.Prefixes.Add($prefix)
$listener.Start()
Write-Host "ENGREMIAT_OBSIDIAN_TO_WORKER_BRIDGE_READY $prefix" -ForegroundColor Green

while($listener.IsListening){
  $ctx=$listener.GetContext()
  try{
    $path=$ctx.Request.Url.AbsolutePath.ToLower()
    if($ctx.Request.HttpMethod -eq "OPTIONS"){SendText $ctx "OK";continue}
    if($path -eq "/health"){
      SendJson $ctx ([ordered]@{status="OK";bridge="obsidian-to-worker-real-exercise";port=$Port;root=$root})
      continue
    }
    if($path -eq "/cards" -or $path -eq "/refresh"){
      $cards=GetCards $root
      SendJson $ctx ([ordered]@{status="PASS";cards=$cards;count=$cards.Count;refreshed_at=(Get-Date).ToString("s")})
      continue
    }
    if($path -eq "/run-mock"){
      $cardId=$ctx.Request.QueryString["cardId"]
      if([string]::IsNullOrWhiteSpace($cardId)){throw "MISSING_cardId"}
      $dispatcher=Join-Path $root "tools/local-kanban-worker-loop/Invoke-LocalKanbanWorkerLoop.ps1"
      $before=Get-Date
      $out=& powershell -NoProfile -ExecutionPolicy Bypass -File $dispatcher -CardId $cardId -Transport mock 2>&1
      if($LASTEXITCODE -ne 0){throw ("DISPATCH_FAILED "+($out -join "`n"))}
      $respDir=Join-Path $root "data/local-kanban-worker-loop-001/responses"
      $evDir=Join-Path $root "data/local-kanban-worker-loop-001/evidence"
      $resp=FindLatest $respDir $cardId ".worker-response.md"
      $ev=FindLatest $evDir $cardId ".evidence.md"
      $cards=GetCards $root
      $card=@($cards|Where-Object{$_.id -eq $cardId}|Select-Object -First 1)
      $from="UNKNOWN"
      if($card.Count -gt 0){$from=$card[0].recommended_column}
      $to=$from
      if($from -eq "NEXT"){$to="DOING"}elseif($from -eq "DOING"){$to="REVIEW"}elseif($from -eq "REVIEW"){$to="DONE"}
      SendJson $ctx ([ordered]@{
        status="PASS"
        card_id=$cardId
        transport="mock"
        started_at=$before.ToString("s")
        ended_at=(Get-Date).ToString("s")
        response=$resp
        evidence=$ev
        proposal=[ordered]@{from=$from;to=$to;requires_human_gate=($to -ne $from);note="Propuesta visual; no aplica cambios en card"}
        dispatcher_output=($out -join "`n")
      })
      continue
    }
    SendJson $ctx ([ordered]@{status="WARN";message="unknown endpoint";path=$path})
  }catch{
    SendJson $ctx ([ordered]@{status="ERR";message=$_.Exception.Message})
  }
}
