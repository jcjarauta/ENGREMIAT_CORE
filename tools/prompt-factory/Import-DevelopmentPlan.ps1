param([string]$InputPath="data/prompt-factory/input/development-plan.sample.tsv",[string]$OutPath="data/prompt-factory/out/plan-normalized.json")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
function WriteJson([string]$p,$o){EnsureDir(Split-Path -Parent $p);$o|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $p -Encoding UTF8}
$cols=@("objective_id","stage_id","stage_name","stage_description","stage_deliverable","block_id","block_name","block_description","block_deliverable","step_id","step_name","step_description","step_deliverable","artifact","dependency","format","risk","automatable","priority","status","notes")
if(!(Test-Path -LiteralPath $InputPath -PathType Leaf)){throw "Plan input no encontrado: $InputPath"}
$rawLines=Get-Content -LiteralPath $InputPath -Encoding UTF8
$rows=@();$lineNumber=0;foreach($line in $rawLines){$lineNumber++;if([string]::IsNullOrWhiteSpace($line)){continue};$parts=@($line -split "`t",-1);if($parts.Count -lt 21){$csvParts=@($line -split ",",-1);if($csvParts.Count -ge 21){$parts=$csvParts}};if($parts.Count -lt 21){$padded=@();$padded+=$parts;while($padded.Count -lt 21){$padded+=""};$parts=$padded};$item=[ordered]@{};for($i=0;$i -lt $cols.Count;$i++){$item[$cols[$i]]=[string]$parts[$i]};if($item.objective_id -eq "objective_id"){continue};$item["line_number"]=$lineNumber;$item["source_path"]=$InputPath;$rows+=[pscustomobject]$item}
$stages=@();foreach($sg in @($rows|Group-Object stage_id)){$blocks=@();foreach($bg in @($sg.Group|Group-Object block_id)){$steps=@();foreach($s in @($bg.Group)){$steps+=[ordered]@{step_id=$s.step_id;step_name=$s.step_name;dependency=$s.dependency;artifact=$s.artifact;status=$s.status;risk=$s.risk;format=$s.format;priority=$s.priority}};$blocks+=[ordered]@{block_id=$bg.Name;block_name=$bg.Group[0].block_name;steps=$steps}};$stages+=[ordered]@{stage_id=$sg.Name;stage_name=$sg.Group[0].stage_name;blocks=$blocks}}
$normalized=[ordered]@{schema="development-plan-normalized.v1";input=$InputPath;rows_count=$rows.Count;objectives=@($rows|Group-Object objective_id|ForEach-Object{$_.Name});stages=$stages;steps=@($rows);generated_at=(Get-Date).ToString("s")}
WriteJson $OutPath $normalized
if($rows.Count -lt 1){Write-Host "ERR import_development_plan=False rows=0";exit 1}
Write-Host ("OK import_development_plan=True rows="+$rows.Count+" output="+$OutPath)
