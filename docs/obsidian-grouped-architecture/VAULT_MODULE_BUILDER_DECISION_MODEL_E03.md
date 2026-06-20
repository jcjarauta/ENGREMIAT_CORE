# ENGREMIAT · Modelo de decisión constructor de bóvedas/módulos

## Decisión
El humano no gestiona carpetas: decide intención, relación y superficie de trabajo. ENGREMIAT crea estructura agrupada, enlaces, gates y evidencias.

## Decisiones humanas principales
- `CREATE_MASTER_VAULT` · Construir boveda maestra · grupo por defecto: `G01_CORE`
- `CREATE_PROJECT_SPACE` · Construir project space · grupo por defecto: `G03_PROJECTS_MODULES`
- `CREATE_MODULE_SPACE` · Construir modulo relacionado · grupo por defecto: `G03_PROJECTS_MODULES`
- `RELATE_MODULE_TO_VAULT` · Relacionar modulo con boveda concreta · grupo por defecto: `G04_MEMORY_VISUAL`
- `OPEN_WORK_SURFACE` · Elegir donde trabajar · grupo por defecto: `G02_HUMAN_CONTROL`

## Superficies de trabajo
- `CONTROL_HUB`
- `GROUPED_CANVAS`
- `PROJECT_CANVAS`
- `ACTIVE_PROJECTS`
- `PENDING_GATES`
- `ACTIVE_CARDS`
- `RECENT_EVIDENCE`
- `WORKER_PROPOSALS`
- `MODULE_INDEX`
- `PROJECT_INDEX`

## Guardas
- preview_only=true por defecto
- worker_execution=false
- kanban_write=false
- clien_write=false
- git_write=false
- Obsidian organiza y visualiza, no ejecuta.

## Siguiente
E04 debe crear una superficie dashboard preview para elegir estas opciones desde control humano.
