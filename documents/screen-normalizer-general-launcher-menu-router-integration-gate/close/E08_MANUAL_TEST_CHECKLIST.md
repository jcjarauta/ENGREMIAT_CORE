# E08 manual smoke checklist

## Objetivo
Probar manualmente que la opcion 10 del operador abre el adapter seguro.

## Pasos humanos
1. En la ventana del operador, pulsa `10` y Enter.
2. Debe aparecer `==== SCREEN NORMALIZER ADAPTER ====`.
3. Debe aparecer `Modo: SAFE_READONLY_NO_DANGER`.
4. Debe mostrar cierres/reportes locales si existen.
5. Debe indicar `ACCIONES REALES: ninguna`.
6. Si vuelve al menu o termina sin error, la prueba es valida.

## Resultado a devolver aqui
Pega una de estas frases:
- `E08_OK opcion 10 abre adapter seguro`
- `E08_FAIL` y el texto del error visible

## Seguridad
No debe ejecutar git, red, navegador, AutoHotkey, portapapeles ni acciones externas.
