Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$MasterVault=if($args.Count -gt 0){[string]$args[0]}else{""}
$ProjectHome=if($args.Count -gt 1){[string]$args[1]}else{""}
$ModuleVault=if($args.Count -gt 2){[string]$args[2]}else{""}
$Title=if($args.Count -gt 3){[string]$args[3]}else{"Proyecto ENGREMIAT"}
function L($m,$c="Gray"){Write-Host $m -ForegroundColor $c}
function D($p){if(!(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Force -Path $p|Out-Null}}
function W($p,[string[]]$a){$d=Split-Path $p -Parent;D $d;$a|Set-Content -LiteralPath $p -Encoding UTF8}
function J($p,$o){$d=Split-Path $p -Parent;D $d;$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
function VaultLink($vault,$file){$r=[string]$file;$prefix=[string]$vault;if($r.StartsWith($prefix,[System.StringComparison]::OrdinalIgnoreCase)){$r=$r.Substring($prefix.Length)};$r=$r.TrimStart([char[]]@('\','/'));$r=$r -replace '\\','/';$r=$r -replace '\.md$','';return '[['+$r+']]'}
if([string]::IsNullOrWhiteSpace($MasterVault)){throw "master_vault_arg_empty"}
if(!(Test-Path -LiteralPath $MasterVault)){throw "master_vault_not_found $MasterVault"}
D (Join-Path $MasterVault "00_HOME");D (Join-Path $MasterVault "00_VISION_GLOBAL");D (Join-Path $MasterVault "03_MODULOS");D (Join-Path $MasterVault "09_INDICE");D (Join-Path $MasterVault "08_CANVAS")
$moduleUri='';if(![string]::IsNullOrWhiteSpace($ModuleVault) -and (Test-Path -LiteralPath $ModuleVault)){$moduleUri='obsidian://open?path='+[uri]::EscapeDataString($ModuleVault)}
$allMd=@(Get-ChildItem -LiteralPath $MasterVault -Recurse -File -Filter "*.md" -ErrorAction SilentlyContinue|Where-Object{$_.FullName -notlike "*\.obsidian\*"}|Sort-Object FullName)
$knownNames=@("BOVEDA_ENGREMIAT_MASTER_STATUS","FIRST_OFFICIAL_MODULE_REQUEST","WORK_SURFACE_INDEX","10_SUPERFICIES_TRABAJO_INDEX","08_PLANTILLAS_INDEX","09_ARCHIVO_INDEX")
$knownFiles=@();foreach($n in $knownNames){$f=$allMd|Where-Object{$_.BaseName -eq $n}|Select-Object -First 1;if($f){$knownFiles+=$f}}
$hub=Join-Path $MasterVault "00_HOME\MASTER_HUB.md"
$lines=@("# Hub maestro - $Title","","Conecta vision global, indices heredados y bovedas de modulo para reducir huerfanos.","","## Entrada","- [[../HOME]]","- [[../09_INDICE/INDICE_MAESTRO]]","","## Vision global","- [[../00_VISION_GLOBAL/VISION_GLOBAL]]","- [[../00_VISION_GLOBAL/PROJECT_STATUS]]","","## Modulos","- [[../03_MODULOS/MODULES_INDEX]]")
if($moduleUri){$lines+=("- [Abrir boveda MODULE_inicio]($moduleUri)")}
$lines+=@("","## Indices heredados detectados")
if(@($knownFiles).Count -gt 0){foreach($f in $knownFiles){$lines+=("- "+(VaultLink $MasterVault $f.FullName))}}else{$lines+=("- No detectados.")}
$lines+=@("","## Documentos conectados")
foreach($f in $allMd){if($f.FullName -ne $hub){$lines+=("- "+(VaultLink $MasterVault $f.FullName))}}
W $hub $lines
W (Join-Path $MasterVault "09_INDICE\INDICE_MAESTRO.md") @("# Indice maestro","","## Hub","- [[../00_HOME/MASTER_HUB]]","","## Vision","- [[../00_VISION_GLOBAL/VISION_GLOBAL]]","- [[../00_VISION_GLOBAL/PROJECT_STATUS]]","","## Modulos","- [[../03_MODULOS/MODULES_INDEX]]")
W (Join-Path $MasterVault "00_VISION_GLOBAL\VISION_GLOBAL.md") @("# Vision global del proyecto","","## Hub maestro","- [[../00_HOME/MASTER_HUB]]","","## Modulos","- [[../03_MODULOS/MODULES_INDEX]]","","## Estado","- [[PROJECT_STATUS]]")
if(!(Test-Path -LiteralPath (Join-Path $MasterVault "00_VISION_GLOBAL\PROJECT_STATUS.md"))){W (Join-Path $MasterVault "00_VISION_GLOBAL\PROJECT_STATUS.md") @("# Estado global","","- Estado: pending_human_review","- Hub: [[../00_HOME/MASTER_HUB]]")}
$modulesLines=@("# Indice de modulos","","La boveda maestra mantiene vision y enlaces; el detalle vive en bovedas de modulo.","","## MODULE_inicio")
if($ModuleVault){$modulesLines+=("- Ruta boveda: $ModuleVault")}
if($moduleUri){$modulesLines+=("- [Abrir boveda MODULE_inicio]($moduleUri)")}
$modulesLines+=@("","## Volver","- [[../00_HOME/MASTER_HUB]]")
W (Join-Path $MasterVault "03_MODULOS\MODULES_INDEX.md") $modulesLines
W (Join-Path $MasterVault "03_MODULOS\MODULE_inicio_CARD.md") @("# MODULE_inicio","","Tarjeta de enlace desde boveda maestra hacia boveda de detalle del modulo.","","## Boveda",$ModuleVault,"","## Abrir",$(if($moduleUri){"[Abrir boveda MODULE_inicio]($moduleUri)"}else{"Modulo no detectado"}),"","## Hub","- [[../00_HOME/MASTER_HUB]]")
$homeFile=Join-Path $MasterVault "HOME.md";if(Test-Path -LiteralPath $homeFile){$h=Get-Content -LiteralPath $homeFile -Raw -Encoding UTF8;if(!$h.Contains("[[00_HOME/MASTER_HUB]]")){($h.TrimEnd()+"`r`n`r`n## Navegacion maestra`r`n- [[00_HOME/MASTER_HUB]]`r`n- [[09_INDICE/INDICE_MAESTRO]]`r`n- [[03_MODULOS/MODULES_INDEX]]`r`n")|Set-Content -LiteralPath $homeFile -Encoding UTF8}}else{W $homeFile @("# $Title","","- [[00_HOME/MASTER_HUB]]","- [[09_INDICE/INDICE_MAESTRO]]","- [[03_MODULOS/MODULES_INDEX]]")}
$canvas=@{nodes=@(@{id="home";type="file";file="HOME.md";x=0;y=0;width=360;height=220},@{id="hub";type="file";file="00_HOME/MASTER_HUB.md";x=420;y=0;width=360;height=220},@{id="vision";type="file";file="00_VISION_GLOBAL/VISION_GLOBAL.md";x=840;y=-160;width=360;height=220},@{id="index";type="file";file="09_INDICE/INDICE_MAESTRO.md";x=840;y=160;width=360;height=220},@{id="modules";type="file";file="03_MODULOS/MODULES_INDEX.md";x=1260;y=0;width=360;height=220},@{id="module_card";type="file";file="03_MODULOS/MODULE_inicio_CARD.md";x=1680;y=0;width=360;height=220});edges=@(@{id="e1";fromNode="home";fromSide="right";toNode="hub";toSide="left"},@{id="e2";fromNode="hub";fromSide="right";toNode="vision";toSide="left"},@{id="e3";fromNode="hub";fromSide="right";toNode="index";toSide="left"},@{id="e4";fromNode="hub";fromSide="right";toNode="modules";toSide="left"},@{id="e5";fromNode="modules";fromSide="right";toNode="module_card";toSide="left"})}
J (Join-Path $MasterVault "08_CANVAS\PROJECT_MASTER.canvas") $canvas
L "OK master_vault_links_normalized=True hub=$hub module_vault=$ModuleVault" Green

