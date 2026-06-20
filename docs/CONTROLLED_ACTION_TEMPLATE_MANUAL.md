# CONTROLLED ACTION TEMPLATE MANUAL

## Proposito
Usar ENGREMIAT_CONTROLLED_ACTION_TEMPLATE_017 como plantilla reusable para crear acciones controladas con scope, gate humano, dry-run, execution plan, receipt, postcheck y cierre.

## Regla principal
La maquina prepara, valida, registra y propone. El humano decide.

## Seguridad por defecto
- gate=DEFER
- apply_executed=false
- auto_apply=false
- remote_execution=false
- git_write=false salvo autorizacion explicita
- receipt obligatorio incluso si se bloquea
- postcheck obligatorio

## Flujo de uso
1. Definir nombre del nuevo objetivo.
2. Generar preview desde plantilla.
3. Revisar scope y riesgos.
4. Mantener gate DEFER salvo decision humana.
5. Ejecutar dry-run.
6. Crear execution plan.
7. Crear receipt.
8. Crear postcheck.
9. Cerrar con close report y NEXT_OBJECTIVE.

## Condicion de aprobacion
Solo se considera gate aprobado si se cumple:

```text
decision=APPROVE
human_confirmation=true
execution_allowed=true
```

## Kanban
Kanban es superficie humana de control y seguimiento. No es motor de ejecucion.

## Uso recomendado
Usar esta plantilla antes de cualquier accion real para reducir errores, mantener trazabilidad y evitar apply libre.
