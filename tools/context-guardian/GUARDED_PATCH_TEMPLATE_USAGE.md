# ENGREMIAT · Plantilla obligatoria de parche protegido

## Regla
Todo parche sobre operador V2 debe usar preflight antes de escribir.

## Plantilla
Archivo: C:\ENGREMIAT_CORE\tools\context-guardian\TEMPLATE_GUARDED_PATCH_OPERATOR_V2.ps1

## Flujo obligatorio
1. Definir TARGET_PATH dentro del active_root.
2. Ejecutar Start-EngremiatGuardedWrite.ps1.
3. Si exit != 0, detener.
4. Guardar backup automático.
5. Aplicar cambio.
6. Validar parse.
7. Si falla parse, restaurar backup.

## Prohibido
- Parchar C:\ENGREMIAT_CORE\ENGREMIAT.ps1 desde flujo operador V2.
- Usar regex amplio sobre funciones largas.
- Insertar `r`n literal.
- Saltarse Context Guardian.
