# Norma canonica: numeracion local por pantalla

Fecha: 2026-06-20T10:03:28

## Decision
Cada pantalla normalizada usa numeros propios, consecutivos y simples.

## Reglas
- La pantalla empieza en [1].
- No se muestran numeros legacy en pantallas normalizadas.
- El numero legacy se conserva solo como metadata interna si hace falta.
- b = volver.
- Enter = refrescar.
- ? = ayuda contextual.
- q solo aparece en raiz si aplica.
- Si una pantalla necesita mas de 7 acciones, se divide en subpantallas.

## Ejemplo
Antes: [14] ficha, [15] dossier, [16] asistente, [17] Data Intake.
Despues: [1] ficha, [2] dossier, [3] asistente, [4] Data Intake.

## Aplicacion
Centro Documental normalizado queda actualizado con numeros locales.
