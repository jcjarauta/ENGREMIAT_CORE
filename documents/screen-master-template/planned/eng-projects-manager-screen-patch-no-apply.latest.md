# E17B repair projects manager screen patch NO_APPLY

## Decision
GO_PROJECTS_MANAGER_PATCH_READY_NO_APPLY

## Target
- original: 
C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-projects-manager.ps1
- candidate: 
C:\ENGREMIAT_CORE\documents\screen-master-template\planned\eng-projects-manager.screen-master-candidate.latest.ps1
- readhost_line: 
25
- command_var: 
a

## Previous candidate parse errors
- Token 'Cyan"
    if($active.Count -eq 0){W "' inesperado en la expresión o la instrucción.
- Falta la cadena en el terminador: ".
- Falta el paréntesis de cierre ')' en la subexpresión.
- Falta la llave de cierre "}" en el bloque de instrucciones o la definición de tipo.
- Falta la llave de cierre "}" en el bloque de instrucciones o la definición de tipo.
- Falta un bloque Catch o Finally en la instrucción Try.

## New candidate parse errors

## Checks
- source_parse: True
- candidate_parse: True
- inserted_router: True
- inserted_route: True
- has_function: True
- has_help_function: True
- has_m_router: True
- has_help_router: True
- has_cancel: True
- has_project_options: True
- has_noapply_markers: True

## Gate para aplicar
`
AUTORIZO_APLICAR_PLANTILLA_MASTER_A_PROJECTS_MANAGER
`

## Next
E18_APPLY_PROJECTS_MANAGER_SCREEN_TEMPLATE_WITH_GATE
