# CONTROLLED ACTION INSTANCE 018 MANUAL

## Proposito
Usar la instancia 018 como primera prueba operativa de la plantilla 017.

## Flujo validado
1. Crear preview de instancia.
2. Heredar plantilla 017.
3. Mantener gate DEFER.
4. Crear dry-run.
5. Crear execution plan sin apply.
6. Crear receipts.
7. Crear postcheck.
8. Cerrar con evidencias.

## Regla de uso
No ejecutar accion real desde esta instancia sin decision humana explicita.

## Estado seguro
```text
gate=DEFER
apply_executed=false
auto_apply=false
remote_execution=false
git_write=false
```

## Interpretacion humana
La instancia 018 demuestra que ENGREMIAT puede convertir una plantilla en un flujo real trazable sin perder control humano.
