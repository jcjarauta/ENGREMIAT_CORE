# Gate decision mutation contract - no execution

## Objetivo
Permitir que una decision humana cambie solo el estado del gate, sin ejecutar el blueprint.

## Mutaciones permitidas
- APPROVE_BLUEPRINT -> gate APPROVED, blueprint NOT_EXECUTED
- BLOCK_BLUEPRINT -> gate BLOCKED, blueprint NOT_EXECUTED
- REQUEST_CHANGES -> gate CHANGES_REQUESTED, blueprint NOT_EXECUTED

## Prohibido
- worker real
- ejecutar blueprint
- modificar codigo
- Git
- red/API
- navegador/AutoHotkey
- borrar archivos

## Siguiente
E107_CREATE_GATE_MUTATION_VALIDATOR_NO_EXECUTION