# NEXT_OBJECTIVE · ENGREMIAT_OPERATOR_V2_CONTEXT_GUARDIAN_ENFORCEMENT_002

## Objetivo
Convertir Context Guardian en gate obligatorio antes de modificar registry, engine, UI o launchers del operador V2.

## Resultado esperado
Ningun script de parche deberia poder tocar archivos fuera del active_root resuelto.

## Pasos propuestos
1. Crear Invoke-EngremiatContextGuardedPatch.ps1.
2. Validar active_root, active_registry y active_engine antes de cada escritura.
3. Bloquear rutas protegidas con NO_GO_CONTEXT_MISMATCH.
4. Generar report de preflight por parche.
5. Integrarlo como plantilla base para siguientes bloques.

## Siguiente paso ejecutable
E01_CREATE_CONTEXT_GUARDED_PATCH_WRAPPER_READONLY_FIRST
