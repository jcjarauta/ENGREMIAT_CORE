# SCREEN_MASTER_TEMPLATE.v1

## Objetivo
Toda pantalla ENGREMIAT debe exponer comandos comunes para evitar navegación rota.

## Comandos comunes
- `Enter` = refrescar / redibujar pantalla actual.
- `b` = volver o salir según contexto.
- `q` = volver o salir según contexto.
- `m` = crear tarjeta de mantenimiento contextual.
- `?` = ayuda contextual.

## Regla clave
La tarjeta de mantenimiento nunca debe bloquear el flow: debe permitir cancelar con `b`, `q`, `c`, `cancelar`, `cancel` o `salir`.

## Patrón recomendado
1. Header muestra título, ruta, rol y comandos comunes.
2. Read-Host guarda en variable clara: `$cmd`.
3. `if([string]::IsNullOrWhiteSpace($cmd)){ continue }` refresca.
4. `switch($cmd.Trim().ToLowerInvariant())` enruta.
5. `m` llama a tarjeta contextual con `screen_id` y `route`.
6. `b/q` usan `return` si están dentro de pantalla/función.

## Anti-patrón detectado
No comprimir el router en una sola línea: impide insertar comandos de forma segura.

## Next
E07_VALIDATE_SCREEN_TEMPLATE_AGAINST_CANDIDATE_SCREENS
