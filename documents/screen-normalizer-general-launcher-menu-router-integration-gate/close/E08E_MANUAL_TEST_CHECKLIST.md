# E08E manual smoke checklist

## Objetivo
Confirmar que la opcion 10 ya es visible y abre el adapter seguro.

## Pasos humanos
1. En la ventana del operador que se abrira, mira el menu GLOBAL.
2. Confirma que aparece `[10] Screen normalizer adapter`.
3. Escribe `10` y pulsa Enter.
4. Debe aparecer `==== SCREEN NORMALIZER ADAPTER ====`.
5. Debe aparecer `Modo: SAFE_READONLY_NO_DANGER`.
6. Debe indicar `ACCIONES REALES: ninguna`.

## Resultado a devolver aqui
- `E08E_OK opcion 10 visible y abre adapter seguro`
- `E08E_FAIL` + error visible o comportamiento observado

## Seguridad
No debe ejecutar git, red, navegador, AutoHotkey, portapapeles ni acciones externas.
