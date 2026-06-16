$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
function EnsureDir([string]$Path){if($Path -and !(Test-Path -LiteralPath $Path)){New-Item -ItemType Directory -Path $Path -Force|Out-Null}}
function WriteJsonFile([string]$Path,$Object){EnsureDir (Split-Path -Parent $Path);$Object|ConvertTo-Json -Depth 100|Set-Content -LiteralPath $Path -Encoding UTF8}
try{
$SourcePath=[string]$args[0];$OutPath=[string]$args[1];if([string]::IsNullOrWhiteSpace($SourcePath)){$SourcePath="data/plan-to-worker/input/samples/plan-input.sample.tsv"};if([string]::IsNullOrWhiteSpace($OutPath)){$OutPath="data/plan-to-worker/input/imported-input.json"};if(!(Test-Path -LiteralPath $SourcePath -PathType Leaf)){throw ("Falta entrada: "+$SourcePath)}
$ext=[System.IO.Path]::GetExtension($SourcePath).ToLowerInvariant();$format="UNKNOWN";$records=@();$raw=$null
$text=[System.IO.File]::ReadAllText((Resolve-Path -LiteralPath $SourcePath),[System.Text.Encoding]::UTF8)
$lines=@($text -replace "`r`n","`n" -replace "`r","`n" -split "`n"|Where-Object{$_ -ne ""})
if($ext -eq ".json"){$format="JSON";$raw=$text|ConvertFrom-Json;if($raw.items){$records=@($raw.items)}elseif($raw.payload.items){$records=@($raw.payload.items)}else{$records=@($raw)}}elseif($ext -eq ".tsv"){$format="TSV";$records=@($text|ConvertFrom-Csv -Delimiter ([char]9))}elseif($ext -eq ".csv"){$format="CSV";$records=@($text|ConvertFrom-Csv)}else{throw ("Formato no soportado: "+$ext)}
if($records.Count -lt 1){throw "La entrada no contiene registros"}
$out=[ordered]@{objective_id="ENGREMIAT_PLAN_TO_WORKER_APP_CONSOLIDATION_002";stage="E02";source_path=$SourcePath;source_format=$format;records_count=$records.Count;records=$records;metadata=[ordered]@{imported_at=(Get-Date).ToString("s");importer="Import-PlanInput.ps1";external_network=$false;git_write=$false;worker_real_execution=$false};decision="GO";next="E03_SALIDA_CANONICA_NORMALIZADA"}
WriteJsonFile $OutPath $out
Write-Host ("OK import_plan_input=True format="+$format+" records="+$records.Count+" out="+$OutPath)
}catch{Write-Host ("ERR import_plan_input=False message="+$_.Exception.Message) -ForegroundColor Red;throw}
