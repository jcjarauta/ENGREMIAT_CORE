$ErrorActionPreference='Stop'
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$package='ENGREMIAT_KANBAN_EXTERNAL_WRITE_ADAPTER_001'
$report='C:\ENGREMIAT_CORE\reports\kanban-external-write-adapter-001'
$payload=Get-Content -Raw "$report\external-kanban-payload.json"|ConvertFrom-Json
$actions=@();foreach($p in @($payload.payload)){$actions+=[ordered]@{operation='PREPARE_EXTERNAL_CARD';executes=$false;card_id=$p.card_id;target_options=@('GOOGLE_SHEETS_MANUAL_TSV','CLINE_KANBAN_MANUAL_PROMPT')}}
[ordered]@{package_id=$package;status='PASS';mode='DRY_RUN';actions_count=$actions.Count;external_api_write=$false;actions=$actions}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\external-write-plan.json"
[ordered]@{package_id=$package;status='PASS';tool='Invoke-ExternalKanbanWriteDryRun';actions_simulated=$actions.Count;api_called=$false;sheets_write=$false;cline_write=$false;external_write_executed=$false}|ConvertTo-Json -Depth 100|Set-Content -Encoding UTF8 "$report\external-write-dry-run-report.json"
