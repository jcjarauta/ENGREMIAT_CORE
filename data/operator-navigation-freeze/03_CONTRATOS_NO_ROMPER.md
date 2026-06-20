# 03 CONTRATOS NO ROMPER

## Contratos duros
- No romper GLOBAL -> PROYECTO -> MODULO.
- No eliminar barra UBICACION.
- No eliminar Enter vacio como refresco.
- No eliminar atras/volver.
- No usar plantillas genericas como oficiales.
- No romper creacion de proyecto desde plantilla maestra oficial.
- No romper existencia de MODULE_inicio.
- No mezclar ampliaciones grandes en el nucleo estable.

## Archivos sensibles
- Start-EngremiatDesktopOperator.ps1
- eng-router.ps1
- eng-context.ps1
- eng-new-project-safe.ps1
- operator-state.v1.json

## Regla tecnica
Si una ampliacion necesita tocar un archivo sensible, debe crear backup, validar parse antes/despues y generar freeze successor si cambia contrato.
