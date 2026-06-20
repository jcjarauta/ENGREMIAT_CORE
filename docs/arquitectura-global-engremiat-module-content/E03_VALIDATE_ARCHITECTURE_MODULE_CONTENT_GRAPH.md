# ENGREMIAT - E03 validar contenido arquitectura global

## Resultado
- Module: `
MODULE_arquitectura_global_engremiat
`
- Readiness: 
70
- Decision: `
NO_GO_REPAIR_ARCHITECTURE_CONTENT_GRAPH
`
- Failed checks: 
5
- Layer notes: 
6
- Canvas nodes: 
10
- Canvas edges: 
9

## Checks
- content_dir_exists: OK
- module_index_exists: OK
- content_map_exists: OK
- boundaries_exists: OK
- flows_exists: OK
- decisions_exists: OK
- canvas_exists: OK
- module_canvas_exists: OK
- status_exists: OK
- six_layer_notes_exist: OK
- layer_notes_have_required_tags: OK
- module_index_links_content_map: FAIL
- module_index_links_boundaries: FAIL
- module_index_links_flows: FAIL
- module_index_links_decisions: FAIL
- module_index_links_global_canvas: FAIL
- content_map_has_layers_section: OK
- content_map_has_boundaries_section: OK
- content_map_has_flows_section: OK
- content_map_has_decisions_section: OK
- architecture_canvas_valid_minimum: OK
- architecture_canvas_links_key_notes: OK
- no_unsafe_file_uri_syntax_in_module_notes: OK

## Siguiente
REPAIR_ARCHITECTURE_MODULE_CONTENT_GRAPH
