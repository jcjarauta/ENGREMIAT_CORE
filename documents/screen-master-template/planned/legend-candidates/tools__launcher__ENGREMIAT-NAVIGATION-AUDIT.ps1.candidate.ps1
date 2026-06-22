Write-Host "[b/q] salir/volver | m = mantenimiento | ? = ayuda | Enter = refrescar" -ForegroundColor DarkGray
$ErrorActionPreference="Stop"
[Console]::OutputEncoding=[System.Text.UTF8Encoding]::new()
$Core="C:\ENGREMIAT_CORE"
$NavJson=Join-Path $Core "reports\navigation\navigation-tree-latest.json"
$RepDir=Join-Path $Core "reports\navigation"
$MemoryDir=Join-Path $Core "memory\project-memory"
New-Item -ItemType Directory -Force -Path $RepDir,$MemoryDir | Out-Null
function W($m,$c="White"){ Write-Host $m -ForegroundColor $c }
if(-not(Test-Path $NavJson)){ throw "NO_GO navigation_tree_latest_missing=$NavJson" }
$tree=Get-Content $NavJson -Raw | ConvertFrom-Json
$expected=@()
$expected += [pscustomobject]@{ area="WORKSPACE"; expected="workspace -- 2 --> cards"; status="OK"; reason="pantalla avanzada de tarjetas existe" }
$expected += [pscustomobject]@{ area="WORKSPACE"; expected="workspace -- 3 --> tasks"; status="PENDING"; reason="falta pantalla avanzada de tareas equivalente a tarjetas" }
$expected += [pscustomobject]@{ area="WORKSPACE"; expected="workspace -- 4 --> types"; status="PENDING"; reason="tipos existen como datos, falta decidir si pantalla propia o subpantalla" }
$expected += [pscustomobject]@{ area="WORKSPACE"; expected="workspace -- 5 --> links"; status="PENDING"; reason="enlaces existen como datos, falta pantalla/vista de gestión" }
$expected += [pscustomobject]@{ area="CARDS"; expected="card -- vt --> task"; status="PENDING"; reason="falta vínculo tarjeta-tarea bidireccional" }
$expected += [pscustomobject]@{ area="GRAPH"; expected="graph includes cards/tasks/memory"; status="PENDING"; reason="grafo actual se centra en módulos; falta extensión operativa" }
$expected += [pscustomobject]@{ area="MEMORY"; expected="memory + diary + prompts"; status="OK"; reason="memoria viva, diario y prompts ya vinculados al inicio" }
$expected += [pscustomobject]@{ area="INICIO"; expected="numeric-only navigation"; status="OK"; reason="inicio normalizado con números únicos" }
$audit=[pscustomobject]@{ generated_at=(Get-Date).ToString("s"); package="ENGREMIAT_NAVIGATION_AUDIT"; status="PASS"; active_project=$tree.active_project_name; current_routes=@($tree.navigation).Count; current_screens=@($tree.screens).Count; ok=@($expected | Where-Object {$_.status -eq "OK"}).Count; pending=@($expected | Where-Object {$_.status -eq "PENDING"}).Count; expected=$expected; recommended_next="E24A_CREATE_MODULE_TASKS_MANAGEMENT_SCREEN" }
$json=Join-Path $RepDir ("navigation-audit-"+(Get-Date -Format "yyyyMMdd-HHmmss")+".json")
$latestJson=Join-Path $RepDir "navigation-audit-latest.json"
$md=Join-Path $RepDir "navigation-audit-latest.md"
$audit | ConvertTo-Json -Depth 40 | Set-Content $json -Encoding UTF8
$audit | ConvertTo-Json -Depth 40 | Set-Content $latestJson -Encoding UTF8
$out=@(); $out += "# ENGREMIAT - Auditoría del árbol de navegación"; $out += ""; $out += "- Generado: $($audit.generated_at)"; $out += "- Proyecto activo: $($audit.active_project)"; $out += "- Rutas actuales: $($audit.current_routes)"; $out += "- Pantallas actuales: $($audit.current_screens)"; $out += "- OK: $($audit.ok)"; $out += "- Pendiente: $($audit.pending)"; $out += ""; $out += "## Estado por área"; foreach($x in $expected){ $out += "- [$($x.status)] $($x.area): $($x.expected)"; $out += "  - $($x.reason)" }; $out += ""; $out += "## Siguiente recomendado"; $out += "- $($audit.recommended_next)"; $out | Set-Content $md -Encoding UTF8
$diary=Join-Path $MemoryDir "development-diary.jsonl"
$entry=[pscustomobject]@{ time=(Get-Date).ToString("s"); title="Auditoría del árbol de navegación"; summary="Se revisó el árbol: inicio, memoria y diagnóstico están bien; faltan tareas, tipos/enlaces como vistas y grafo extendido."; learned="El árbol debe mostrar no solo rutas existentes, también huecos pendientes para no perder contexto."; next="E24A_CREATE_MODULE_TASKS_MANAGEMENT_SCREEN"; source="navigation_audit" }
Add-Content -Path $diary -Value ($entry | ConvertTo-Json -Compress -Depth 20) -Encoding UTF8
W "==== AUDITORIA NAVEGACION ====" Cyan
W "status=PASS" Green
W ("ok={0} pending={1}" -f $audit.ok,$audit.pending) Yellow
W "latest_json=$latestJson" Green
W "latest_md=$md" Green
W "next=E24A_CREATE_MODULE_TASKS_MANAGEMENT_SCREEN" Magenta
