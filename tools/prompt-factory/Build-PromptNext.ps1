param([string]$ContextPath="data/prompt-factory/out/prompt-context.json",[string]$OutPath="data/prompt-factory/out/PROMPT_NEXT.md")
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.Encoding]::UTF8
function EnsureDir([string]$p){if($p -and !(Test-Path -LiteralPath $p)){New-Item -ItemType Directory -Path $p -Force|Out-Null}}
if(!(Test-Path -LiteralPath $ContextPath -PathType Leaf)){throw "prompt-context no encontrado: $ContextPath"}
$ctx=Get-Content -LiteralPath $ContextPath -Raw -Encoding UTF8|ConvertFrom-Json
$s=$ctx.next_step
$lines=@()
$lines += "# PROMPT_NEXT - ENGREMIAT WORKER TASK"
$lines += ""
$lines += "## ROL"
$lines += "Actúa como worker local controlado para ENGREMIAT usando Cline/Ollama. Trabaja SOLO sobre el paso indicado y devuelve salida verificable."
$lines += ""
$lines += "## OBJETIVO ACTIVO"
$lines += "- objective_id: "+$s.objective_id
$lines += "- stage_id: "+$s.stage_id
$lines += "- block_id: "+$s.block_id
$lines += "- step_id: "+$s.step_id
$lines += "- step_name: "+$s.step_name
$lines += ""
$lines += "## DESCRIPCIÓN DEL PASO"
$lines += [string]$s.step_description
$lines += ""
$lines += "## DEPENDENCIA VALIDADA"
$lines += "- dependency: "+$s.dependency
$lines += ""
$lines += "## ARTEFACTO ESPERADO"
$lines += "- artifact: "+$s.artifact
$lines += "- format: "+$s.format
$lines += ""
$lines += "## CONTEXTO REAL"
$lines += "- active_objective: "+$ctx.active_objective
$lines += "- active_stage: "+$ctx.active_stage
$lines += "- active_step: "+$ctx.active_step
$lines += "- memory_status: .\eng.ps1 memory-status"
$lines += "- memory_sync: .\eng.ps1 memory-sync"
$lines += "- dashboard: ENGREMIAT_MEMORY/dashboard/memory/index.html"
$lines += ""
$lines += "## LÍMITES DE SEGURIDAD"
$lines += "- external_network=False"
$lines += "- git_write=False"
$lines += "- commit=False"
$lines += "- push=False"
$lines += "- fetch=False"
$lines += "- merge=False"
$lines += "- browser=False"
$lines += "- clipboard=False"
$lines += "- apply_sensible=False sin gate humano explícito"
$lines += "- Si falta evidencia o no puedes validar, responde NO_GO."
$lines += ""
$lines += "## ARCHIVOS PERMITIDOS"
$lines += "- data/prompt-factory/**"
$lines += "- tools/prompt-factory/**"
$lines += "- reports/prompt-factory/**"
$lines += "- docs/prompt-factory/**"
$lines += ""
$lines += "## ARCHIVOS PROHIBIDOS"
$lines += "- .git/**"
$lines += "- node_modules/**"
$lines += "- backend/node_modules/**"
$lines += "- cualquier secreto, token o credencial"
$lines += "- cambios fuera del objetivo actual sin autorización humana"
$lines += ""
$lines += "## VALIDACIÓN OBLIGATORIA"
$lines += "- crear o actualizar el artefacto esperado"
$lines += "- generar reporte JSON local"
$lines += "- no usar red externa"
$lines += "- no escribir git"
$lines += "- explicar pruebas ejecutadas"
$lines += "- si algo falla, devolver NO_GO con causa y evidencia faltante"
$lines += ""
$lines += "## FORMATO DE SALIDA WORKEROUTPUT"
$lines += "Devuelve una respuesta con estos campos:"
$lines += "```json"
$lines += "{"
$lines += '  "worker_id": "cline_or_ollama",'
$lines += '  "task_id": "' + $s.step_id + '",'
$lines += '  "decision": "GO|NO_GO|REQUEST_CHANGES|BLOCKED",'
$lines += '  "summary": "...",'
$lines += '  "files_touched": [],'
$lines += '  "tests_executed": [],'
$lines += '  "risks": [],'
$lines += '  "evidence": [],'
$lines += '  "validation_report": "...",'
$lines += '  "external_network": false,'
$lines += '  "git_write": false,'
$lines += '  "next": "..."'
$lines += "}"
$lines += "```"
$lines += ""
$lines += "## CRITERIO GO / NO_GO"
$lines += "GO solo si el artefacto existe, la validación local pasa y la evidencia queda registrada. NO_GO si no puedes demostrarlo."
$lines += ""
$lines += "## NEXT"
$lines += "Después de completar este paso, deja indicado el siguiente paso lógico y la evidencia generada."
EnsureDir (Split-Path -Parent $OutPath);Set-Content -LiteralPath $OutPath -Value $lines -Encoding UTF8
Write-Host ("OK build_prompt_next=True step="+$s.step_id+" output="+$OutPath)
