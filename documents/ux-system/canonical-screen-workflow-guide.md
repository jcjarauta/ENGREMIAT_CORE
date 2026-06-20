# Modelo canonico de pantalla y dinamica de trabajo

Fecha: 2026-06-20T09:56:25

## Objetivo
Crear una norma reutilizable para que todos los centros de ENGREMIAT escalen sin convertirse en listas largas, reduciendo friccion humana y manteniendo navegacion clara.

## Plantilla visual canonica
1. Titulo canonico de pantalla.
2. Ruta desde INICIO.
3. Rol de la pantalla.
4. Principio operativo.
5. Estado breve si aplica.
6. Acciones agrupadas por bloques.
7. Navegacion estandar: Enter refresca, b vuelve, ? ayuda.
8. Prompt con nombre de pantalla.

## Criterios para pasar de listado a pantalla propia
- Mas de 7 opciones visibles.
- Mezcla de mas de 3 tipos de trabajo.
- Flujo con estado propio.
- Opcion que representa un dominio estable: Data Intake, Dossiers, Convocatorias, Workers, Exportaciones.
- Acciones con distintos riesgos o permisos.

## Dinamica de normalizacion
1. No romper legacy funcional.
2. Crear launcher paralelo normalizado.
3. Definir submenus conceptuales.
4. Cablear primero el flujo validado.
5. Probar parse y smoke estatico.
6. Hacer prueba humana.
7. Solo entonces plantear reemplazo del acceso principal.

## Norma de handlers
Cada submenu se cablea en una fase independiente. Si falla, se reescribe el launcher normalizado completo desde base estable o se restaura backup.

## Aplicacion inmediata
Centro Documental se normaliza por bloques: Memoria viva, Dossiers, Convocatorias y fichas, Contexto worker, Exportaciones, Carpetas, Estado y ayuda.
