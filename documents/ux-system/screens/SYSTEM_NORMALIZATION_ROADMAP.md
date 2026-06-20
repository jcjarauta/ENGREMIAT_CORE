# Roadmap de normalizacion de pantallas

Fecha: 2026-06-20T10:06:18

## Patron de referencia
Centro Documental normalizado: pantalla con ruta, rol, principio, numeros locales, subpantallas por dominio y handlers por fase.

## Inventario
- Launchers analizados: 18
- Alta prioridad: 5
- Media prioridad: 11
- Referencia normalizada: 1

## Criterios usados
- Mas de 7 opciones visibles.
- Numeros legacy visibles mayores de 9.
- Falta de ruta, rol o principio.
- Falta de Enter/refresco, b volver o ayuda.
- Varios Read-Host en un mismo archivo.

## Secuencia recomendada
- 1. tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER.ps1 [HIGH_PRIORITY]
- 2. tools\launcher\ENGREMIAT-INICIO.ps1 [HIGH_PRIORITY]
- 3. tools\launcher\ENGREMIAT-MEMORY-DOCUMENTATION-CENTER.ps1 [HIGH_PRIORITY]
- 4. tools\launcher\ENGREMIAT-NAVIGATION-VIEWER.ps1 [HIGH_PRIORITY]
- 5. tools\launcher\ENGREMIAT-PROJECT-DIARY-ADD.ps1 [HIGH_PRIORITY]
- 6. tools\launcher\ENGREMIAT-INICIO-STATUS.ps1 [MEDIUM_PRIORITY]
- 7. tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1 [MEDIUM_PRIORITY]
- 8. tools\launcher\ENGREMIAT-NAVIGATION-AUDIT.ps1 [MEDIUM_PRIORITY]
- 9. tools\launcher\ENGREMIAT-NAVIGATION-SAFE.ps1 [MEDIUM_PRIORITY]
- 10. tools\launcher\ENGREMIAT-NAVIGATION-TREE.ps1 [MEDIUM_PRIORITY]
- 11. tools\launcher\ENGREMIAT-PROJECT-MEMORY.ps1 [MEDIUM_PRIORITY]
- 12. tools\launcher\ENGREMIAT-PROJECT-MEMORY-GENERATE.ps1 [MEDIUM_PRIORITY]
- 13. tools\launcher\ENGREMIAT-PROJECT-MEMORY-SAFE.ps1 [MEDIUM_PRIORITY]
- 14. tools\launcher\ENGREMIAT-SELECT-MODULE-CARDS.ps1 [MEDIUM_PRIORITY]
- 15. tools\launcher\ENGREMIAT-SELECT-MODULE-SAFE.ps1 [MEDIUM_PRIORITY]
- 16. tools\launcher\ENGREMIAT-SELECT-MODULE-WORKSPACE.ps1 [MEDIUM_PRIORITY]

## Siguiente
E33_SELECT_FIRST_SYSTEM_SCREEN_TO_NORMALIZE: elegir el primer launcher candidato y preparar blueprint paralelo.
