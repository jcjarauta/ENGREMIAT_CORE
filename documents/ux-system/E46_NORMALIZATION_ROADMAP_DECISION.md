# Decision E46: sustituir legacy o continuar roadmap

Fecha: 2026-06-20T10:19:59

## Decision
Continuar el roadmap de normalizacion antes de sustituir entradas legacy principales.

## Motivo
- Centro Documental normalizado validado.
- Data Intake normalizado validado.
- Conexion Centro Documental -> Data Intake normalizado validada.
- Handler real TXT/MD validado.
- Legacy debe conservarse como respaldo mientras normalizamos mas pantallas.

## Norma operativa
Cada pantalla nueva debe tener: header limpio, ruta, rol, principio, paleta UX, numeros locales, b vuelve, Enter refresca y ? ayuda.

## Siguiente
E47_SELECT_NEXT_ROADMAP_SCREEN_AFTER_DATA_INTAKE: seleccionar la siguiente pantalla del roadmap, saltando Data Intake porque ya fue normalizada.
