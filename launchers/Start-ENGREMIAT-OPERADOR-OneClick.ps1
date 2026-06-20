$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function W([string]$m,[string]$c="Gray"){Write-Host $m -ForegroundColor $c}
function B([string]$t,[object[]]$l,[string]$c="Cyan"){W "";W "==== $t ====" $c;foreach($x in $l){W ([string]$x) $c}}
function EnsureDir([string]$p){[System.IO.Directory]::CreateDirectory($p)|Out-Null}
try{
  $root="C:\ENGREMIAT_CORE"
  $reports=Join-Path $root "reports\desktop-launcher"
  EnsureDir $reports
  Set-Location $root
  B "ENGREMIAT OPERADOR" @("launcher=one_click_desktop_v4","root=$root","status=detectando_operador") "Cyan"
  $rows=@()
  $fixed=@(
    "C:\ENGREMIAT_CORE\tools\operator-navigation-model\Start-OperatorNavigationModel.ps1",
    "C:\ENGREMIAT_CORE\tools\operator-navigation-model\Start-Operator.ps1",
    "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-DesktopTerminalOperator.ps1",
    "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-TerminalOperator.ps1",
    "C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-Operator.ps1",
    "C:\ENGREMIAT_CORE\tools\terminal-operator\Start-TerminalOperator.ps1",
    "C:\ENGREMIAT_CORE\up-engremiat.ps1"
  )
  foreach($p in $fixed){if(Test-Path -LiteralPath $p){$rows+=[pscustomobject]@{Score=1000;Path=$p;Reason="fixed"}}}
  $files=@(Get-ChildItem -LiteralPath $root -Recurse -File -Include *.ps1,*.cmd,*.bat -ErrorAction SilentlyContinue | Where-Object { $_.FullName -notlike "*\reports\*" -and $_.FullName -notlike "*\backups\*" -and $_.FullName -notlike "*\node_modules\*" -and $_.FullName -notlike "*\.git\*" })
  foreach($f in $files){
    $score=0;$reason=@();$name=$f.Name.ToLowerInvariant();$path=$f.FullName.ToLowerInvariant()
    if($name.Contains("operator") -or $name.Contains("operador")){$score+=20;$reason+="name"}
    if($path.Contains("operator-navigation") -or $path.Contains("desktop-terminal") -or $path.Contains("terminal-operator")){$score+=40;$reason+="path"}
    $txt=""
    try{$txt=Get-Content -LiteralPath $f.FullName -Raw -Encoding UTF8 -ErrorAction Stop}catch{try{$txt=Get-Content -LiteralPath $f.FullName -Raw -ErrorAction Stop}catch{$txt=""}}
    if($txt.Contains("ENGREMIAT TERMINAL OPERATOR")){$score+=300;$reason+="title"}
    if($txt.Contains("eng-new-project-safe-robocopy")){$score+=200;$reason+="new_project"}
    if($txt.Contains("operator-state.v1.json")){$score+=150;$reason+="state"}
    if($txt.Contains("Abrir proyecto")){$score+=90;$reason+="abrir"}
    if($txt.Contains("Nuevo proyecto")){$score+=90;$reason+="nuevo"}
    if($txt.Contains("Ver proyectos")){$score+=90;$reason+="ver"}
    if($score -gt 0){$rows+=[pscustomobject]@{Score=$score;Path=$f.FullName;Reason=($reason -join ",")}}
  }
  $ranked=@($rows | Sort-Object Score -Descending,Path | Select-Object -First 20)
  $tsv=Join-Path $reports ("operator-entrypoint-candidates-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".tsv")
  $lines=New-Object System.Collections.Generic.List[string]
  $lines.Add("score`tpath`treason")
  foreach($r in $ranked){$lines.Add(([string]$r.Score)+"`t"+$r.Path+"`t"+$r.Reason)}
  Set-Content -LiteralPath $tsv -Encoding UTF8 -Value $lines
  if($ranked.Count -eq 0){B "NO_GO" @("No se encontro entrypoint.","Reporte=$tsv") "Yellow";Read-Host "Enter para salir";exit 1}
  $top=$ranked[0]
  if($top.Score -lt 250){
    B "SELECTOR" @("Candidato no totalmente seguro. Elige numero:","Reporte=$tsv") "Yellow"
    for($i=0;$i -lt $ranked.Count;$i++){W ("[" + ($i+1) + "] score=" + $ranked[$i].Score + " " + $ranked[$i].Path + " :: " + $ranked[$i].Reason) "Yellow"}
    $sel=Read-Host "Numero a iniciar"
    $n=0
    if([int]::TryParse($sel,[ref]$n) -and $n -ge 1 -and $n -le $ranked.Count){$top=$ranked[($n-1)]}else{throw "seleccion_invalida=$sel"}
  }
  B "OK" @("entrypoint=$($top.Path)","score=$($top.Score)","reason=$($top.Reason)","reporte=$tsv","accion=iniciando") "Green"
  if($top.Path.ToLowerInvariant().EndsWith(".ps1")){& powershell -NoProfile -ExecutionPolicy Bypass -File $top.Path}else{& $top.Path}
}catch{
  B "ERR" @("status=FAIL",$_.Exception.Message) "Red"
  Read-Host "Enter para salir"
  exit 1
}
