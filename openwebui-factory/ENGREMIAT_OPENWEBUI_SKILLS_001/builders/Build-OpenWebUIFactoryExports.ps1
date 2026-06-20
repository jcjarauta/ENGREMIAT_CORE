param([string]$Root="C:\ENGREMIAT_CORE")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function Ensure($p){if(!(Test-Path $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteText($p,[string[]]$v){$d=Split-Path $p -Parent;if($d){Ensure $d};Set-Content -Path $p -Value $v -Encoding UTF8}
function Slug($s){$x=([string]$s).ToLowerInvariant();$x=$x -replace "[^a-z0-9]+","-";$x=$x.Trim("-");if(!$x){$x="item"};return $x}
function ReadTitle($path){$lines=Get-Content $path -Encoding UTF8 -ErrorAction SilentlyContinue;foreach($l in $lines){if($l -match "^#\s+(.+)$"){return $Matches[1].Trim()}};return [IO.Path]::GetFileNameWithoutExtension($path)}
$Vault=Join-Path $Root "obsidian-vault\ENGREMIAT"
$Factory=Join-Path $Root "openwebui-factory\ENGREMIAT_OPENWEBUI_SKILLS_001"
$Exports=Join-Path $Factory "exports"
$ManifestDir=Join-Path $Exports "manifests"
foreach($d in @("skills","knowledge-fast","knowledge-full","segments","segments\status","segments\roadmaps","segments\rules","segments\architecture","segments\manuals","segments\prompts","segments\reports","segments\decisions","manifests")){Ensure (Join-Path $Exports $d)}
$skillDir=Join-Path $Vault "skills-candidates"
$skills=@()
if(Test-Path $skillDir){$skills=@(Get-ChildItem -Path $skillDir -Filter "*.md" -File -ErrorAction SilentlyContinue)}
$skillExports=@()
foreach($f in $skills){$title=ReadTitle $f.FullName;$slug=Slug $title;$out=Join-Path $Exports ("skills\"+$slug+".md");$body=@(Get-Content $f.FullName -Encoding UTF8);$skill=@("---","name: "+$slug,"description: Skill documental ENGREMIAT generada desde Obsidian para "+$title,"---","","# "+$title,"","## Origen","Fuente Obsidian: "+$f.FullName,"","## Instrucciones Skill") + $body;WriteText $out $skill;$skillExports+=[pscustomobject]@{type="skill";source=$f.FullName;output=$out;name=$slug;title=$title}}
$knowledgeSources=@()
foreach($path in @("architecture","decisions","manuals","prompts","status","roadmaps","openwebui")){$p=Join-Path $Vault $path;if(Test-Path $p){$knowledgeSources+=@(Get-ChildItem -Path $p -Filter "*.md" -File -Recurse -ErrorAction SilentlyContinue|Where-Object{$_.FullName -notmatch "\\reports\\"})}}
$knowledgeExports=@()
foreach($f in $knowledgeSources){$txt=Get-Content $f.FullName -Raw -Encoding UTF8;if($txt -match "export-ready|openwebui_target|openwebui|Knowledge|knowledge|canonic|canonica"){$title=ReadTitle $f.FullName;$slug=Slug $title;$target="knowledge-full";if($txt -match "ENGREMIAT_CORE_FAST|export_target:\s*fast|openwebui/fast"){$target="knowledge-fast"}elseif($txt -match "roadmap|ROADMAP|roadmaps"){$target="segments\roadmaps"}elseif($txt -match "decision|Decision|DECISION"){$target="segments\decisions"}elseif($txt -match "architecture|arquitectura|Architecture"){$target="segments\architecture"};$out=Join-Path $Exports ($target+"\"+$slug+".md");$doc=@("# "+$title,"","Origen Obsidian: "+$f.FullName,"","Destino sugerido: "+$target,"","---","") + @($txt -split "`r?`n");WriteText $out $doc;$knowledgeExports+=[pscustomobject]@{type="knowledge";source=$f.FullName;output=$out;target=$target;title=$title}}}
$manifest=[pscustomobject]@{generated_at=(Get-Date).ToString("s");mode="LOCAL_EXPORT_ONLY";api_real_write=$false;openwebui_write=$false;skills_count=$skillExports.Count;knowledge_count=$knowledgeExports.Count;skills=$skillExports;knowledge=$knowledgeExports}
$manifestPath=Join-Path $ManifestDir "openwebui-factory-manifest.v1.json"
$manifest|ConvertTo-Json -Depth 8|Set-Content $manifestPath -Encoding UTF8
$summary=@("# OpenWebUI Factory Export Summary","","mode=LOCAL_EXPORT_ONLY","api_real_write=False","openwebui_write=False","skills_count="+$skillExports.Count,"knowledge_count="+$knowledgeExports.Count,"manifest="+$manifestPath,"","## Siguiente","Validar exports locales antes de preparar import bridge.")
WriteText (Join-Path $ManifestDir "openwebui-factory-summary.md") $summary
Write-Host "OK factory exports generated skills=$($skillExports.Count) knowledge=$($knowledgeExports.Count)"
Write-Host "MANIFEST=$manifestPath"
