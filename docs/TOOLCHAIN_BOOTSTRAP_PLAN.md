TOOLCHAIN_BOOTSTRAP_PLAN

Objective: 
ENGREMIAT_OPEN_SOURCE_TOOLCHAIN_BOOTSTRAP_003
Stage: E01
Mode: READINESS_ONLY_NO_INSTALL

Herramientas revisadas:
- winget
- git
- gh
- node
- npm
- ollama
- cline
- docker
- graphviz/dot
- sqlite3

Regla de seguridad: esta fase no instala nada. Solo detecta estado real y prepara plan.

Prioridad recomendada:
1. Node.js LTS y npm
2. Git
3. Ollama runtime sin descarga de modelos
4. Cline CLI sin auto-apply
5. Graphviz opcional
6. SQLite opcional
7. GitHub CLI opcional/gated
8. OpenClaw diferido, solo tras gates

Siguiente etapa: E02_INSTALACION_CORE_MINIMA
