# ENGREMIAT · Superficie de decisión preview

## Resultado
Se crea una superficie humana de decisión para escoger qué construir o dónde trabajar.

## Acciones
- `CREATE_MASTER_VAULT` · Construir boveda maestra · `G01_CORE`
- `CREATE_PROJECT_SPACE` · Construir project space · `G03_PROJECTS_MODULES`
- `CREATE_MODULE_SPACE` · Construir modulo relacionado · `G03_PROJECTS_MODULES`
- `RELATE_MODULE_TO_VAULT` · Relacionar modulo con boveda concreta · `G04_MEMORY_VISUAL`
- `OPEN_WORK_SURFACE` · Elegir donde trabajar · `G02_HUMAN_CONTROL`

## Regla
El dashboard decide intención y ruta; la construcción real sigue en preview hasta gate explícito.

## Siguiente
E05 debe preparar el plan de oficialización de la arquitectura agrupada.
