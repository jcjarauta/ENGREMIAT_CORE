# 02 JERARQUIA Y NAVEGACION

## Niveles
1. GLOBAL: entrada del operador, apertura/creacion/listado/estado.
2. PROYECTO: contexto de proyecto activo, modulos y biblioteca.
3. MODULO: contexto de modulo activo y acciones futuras.

## GLOBAL
- [1] Abrir proyecto
- [2] Nuevo proyecto desde plantilla maestra oficial
- [3] Ver proyectos con historicos y activo
- [4] Estado compacto
- [q] Salir

## PROYECTO
- [1] Entrar en modulo
- [2] Crear modulo
- [3] Biblioteca modulos
- [4] Revisar proyecto
- [a] Atras

## MODULO
- Debe conservar ruta de retorno a PROYECTO.
- Debe mostrar modulo activo y ruta.
- Las acciones futuras se agregan sin romper comandos base.
