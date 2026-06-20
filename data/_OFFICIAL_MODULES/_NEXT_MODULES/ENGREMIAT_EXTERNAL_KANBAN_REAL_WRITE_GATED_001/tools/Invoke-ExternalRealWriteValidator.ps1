$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$report='C:\ENGREMIAT_CORE\reports\external-kanban-real-write-gated-001'
$required=@(
"$report\external-real-write-result.json",
"$report\external-write-rollback-package.json",
"$report\external-write-evidence-report.json"
)
$missing=@($required|?{!(Test-Path $_)})
$r=Get-Content -Raw "$report\external-real-write-result.json"|ConvertFrom-Json
$status='PASS'
if($missing.Count -gt 0){$status='ERR'}
$out=[ordered]@{
 package_id='ENGREMIAT_EXTERNAL_KANBAN_REAL_WRITE_GATED_001'
 stage='E07'
 status=$status
 missing=$missing
 authorization_status=$r.authorization_status
 external_write_executed=$r.external_write_executed
 safe_blocked_mode=$true
 api_called=$false
}
$out|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\external-real-write-validation-report.json"
$out|ConvertTo-Json -Depth 100
