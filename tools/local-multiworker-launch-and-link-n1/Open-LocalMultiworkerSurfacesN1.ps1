$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function J($o,[string]$p){$d=Split-Path $p -Parent;if($d){New-Item -ItemType Directory -Force -Path $d|Out-Null};$o|ConvertTo-Json -Depth 100|Set-Content -Path $p -Encoding UTF8}
$Mode='preview'
if($args.Count -ge 2 -and $args[0] -eq '-Mode'){$Mode=[string]$args[1]}elseif($args.Count -ge 1){$Mode=[string]$args[0]}
if($Mode -notin @('preview','open')){throw "Modo no valido: $Mode"}
$base='data/local-multiworker-launch-and-link-n1'
$reports='reports/local-multiworker-launch-and-link-n1'
$dash='dashboard/local-multiworker-launch-and-link-n1/index.html'
New-Item -ItemType Directory -Force -Path $reports | Out-Null
$index=Get-Content "$base/human-surfaces-index.json" -Raw|ConvertFrom-Json
$policy=Get-Content "$base/human-surfaces-policy.json" -Raw|ConvertFrom-Json
$authorizedOpen=($Mode -eq 'open' -and $policy.auto_open_allowed -eq $true)
$browserOpened=$false
if($authorizedOpen){Start-Process -FilePath (Resolve-Path $dash).Path;$browserOpened=$true}
$result=[ordered]@{objective='ENGREMIAT_LOCAL_MULTIWORKER_LAUNCH_AND_LINK_009A_N1';stage='E03';launcher='Open-LocalMultiworkerSurfacesN1.ps1';mode=$Mode;authorized_open=$authorizedOpen;browser_opened=$browserOpened;dashboard=$dash;surfaces=@($index.surfaces|ForEach-Object{[ordered]@{surface_id=$_.surface_id;path=$_.path;exists=$_.exists;open_mode=$_.open_mode}});cline_executed=$false;ollama_executed=$false;remote_execution=$false;git_write=$false;apply_executed=$false;decision=($(if($browserOpened){'OPENED_AUTHORIZED_SURFACE'}else{'PREVIEW_ONLY_NO_BROWSER_OPENED'}))}
J $result "$reports/e03-launcher-preview-result.json"
Write-Host ("OK objective="+$result.objective+" stage=E03 launcher_mode="+$Mode+" browser_opened="+$browserOpened+" cline_executed=False ollama_executed=False remote_execution=False git_write=False decision="+$result.decision) -ForegroundColor Green
