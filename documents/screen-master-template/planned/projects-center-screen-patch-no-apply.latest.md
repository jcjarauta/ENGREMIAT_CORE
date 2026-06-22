# E21 projects center screen patch NO_APPLY

## Decision
NO_GO_PROJECTS_CENTER_PATCH_NEEDS_REPAIR

## Target
- original: 
C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-PROJECTS-CENTER-NORMALIZED.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\projects-center.screen-master-candidate.latest.ps1
- readhost_line: 
19
- readhost_text: 
function ProjectList(){while($true){Header;$items=GetProjects;if($items.Count -eq 0){W 'No hay proyectos en C:\ENGREMIAT_CORE\projects' Yellow}else{$i=0;foreach($p in $items){$i++;$ProjectIdValue=SafeId $p.FullName;W ('['+$i+'] '+$ProjectIdValue+'  '+$p.Name) White}};W '';W 'numero = abrir proyecto | b = volver | Enter = refrescar' DarkGray;$c=Read-Host 'PROYECTOS';if([string]::IsNullOrWhiteSpace($c)){continue};if($c.ToLower() -eq 'b'){break};$n=0;if([int]::TryParse($c,[ref]$n) -and $n -ge 1 -and $n -le $items.Count){ProjectActions $items[$n-1].FullName}else{W 'Comando no reconocido' Yellow;Start-Sleep -Milliseconds 700}}}
- patch_mode: 
READHOST_UNKNOWN_SHAPE

## Previous candidate parse errors

## New candidate parse errors

## Checks
- source_parse: True
- candidate_parse: True
- inserted_route: True
- inserted_router: True
- mode_supported: False
- has_function: True
- has_help_function: True
- has_m_router: False
- has_help_router: False
- has_q_router: False
- has_cancel: True
- has_screen_markers: True

## Gate para aplicar
`
AUTORIZO_APLICAR_PLANTILLA_MASTER_A_PROJECTS_CENTER
`

## Next
E22_APPLY_PROJECTS_CENTER_SCREEN_TEMPLATE_WITH_GATE
