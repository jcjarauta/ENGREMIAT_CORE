# ENGREMIAT Operator Navigation Contract v1

## Principios
- Every visible operator screen must be redrawable with empty Enter.
- Every persistent screen must show contextual help.
- Every persistent screen must provide an explicit back command.
- Quick actions may return to parent immediately, but parent must redraw full menu.
- No child command should leave parent prompt without redrawing context.
- Navigation behavior must be declared as SCREEN, ACTION, SELECTOR or FLOW.

## Clases
- SCREEN: pantalla persistente con loop, Enter refresca y b vuelve.
- ACTION: accion rapida, vuelve al padre y el padre redibuja.
- SELECTOR: pantalla de seleccion, Enter refresca y b vuelve.
- FLOW: flujo multipaso con transiciones explicitas.

## Ayuda UX obligatoria
refrescar/f5/Enter = redibujar pantalla | ? = ayuda | comandos = menu actual

## Siguiente
E03_CREATE_NAVIGATION_HELPERS_SAFE: crear helpers reutilizables sin cambiar aun todos los comandos.
