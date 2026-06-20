$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_INTERNAL_PRIORITY_ENGINE_001'
$root='C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_INTERNAL_PRIORITY_ENGINE_001'
$report='C:\ENGREMIAT_CORE\reports\internal-priority-engine-001'
$required=@("$report\priority-signals-report.json","$report\priority-ranking-output.json","$report\top-priority-recommendations.json","$report\priority-ranking.tsv","$report\priority-summary.md","$report\dashboard\index.html")
$missing=@($required|?{!(Test-Path $_)})
$parse=@();Get-ChildItem "$root\tools\*.ps1"|%{$e=$null;[System.Management.Automation.Language.Parser]::ParseFile($_.FullName,[ref]$null,[ref]$e)|Out-Null;if($e.Count -gt 0){$parse+=$_.Name}}
$ranking=if(Test-Path "$report\priority-ranking-output.json"){Get-Content -Raw "$report\priority-ranking-output.json"|ConvertFrom-Json}else{$null}
$items=@($ranking.ranking)
$bad=@($items|?{![string]$_.card_id -or $null -eq $_.priority_score -or @($_.reasons).Count -eq 0})
$status=if($missing.Count -eq 0 -and $parse.Count -eq 0 -and $items.Count -gt 0 -and $bad.Count -eq 0){'PASS'}else{'ERR'}
$out=[ordered]@{package_id=$package;stage='E06';status=$status;missing=$missing;parse_errors=$parse;ranked_cards=$items.Count;bad_items=$bad.Count;readonly=$true;external_write=$false;readiness=86;next='E07_MANUAL_AND_CLOSE'}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\priority-engine-validation-report.json"
if($status -ne 'PASS'){throw ($out|ConvertTo-Json -Depth 100)}
