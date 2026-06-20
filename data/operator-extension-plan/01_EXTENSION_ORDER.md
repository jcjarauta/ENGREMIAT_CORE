# 01 ORDEN DE AMPLIACION PROTEGIDA

## Primero: revisar sin tocar
EXT04_PROJECT_REVIEW_SAFE debe ser el primer desarrollo porque no modifica el nucleo y nos da panel de salud del proyecto activo.

## Segundo: crear modulo
EXT01_CREATE_MODULE_SAFE debe crear modulos desde el contexto del proyecto sin tocar plantilla maestra oficial.

## Tercero: selector de modulo
EXT02_MODULE_SELECTOR_SAFE debe mejorar la navegacion de modulos manteniendo atras/refresco/ubicacion.

## Cuarto: biblioteca
EXT03_MODULE_LIBRARY_SAFE debe permitir reutilizar modulos, siempre con preview y gate antes de copiar.

## Futuro
Obsidian sync y worker deben quedar fuera del nucleo, como scripts gated.
