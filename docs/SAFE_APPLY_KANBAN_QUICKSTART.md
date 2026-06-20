# SAFE APPLY KANBAN QUICKSTART

1. Revisar scope: data/apply-scope-102/apply-scope-model.json
2. Validar rollback: .\tools\eng-rollback-pack-validate.ps1
3. Validar postcheck: .\tools\eng-postcheck-runner.ps1
4. Revisar autorizacion humana: dashboard/human-authorization/index.html
5. Si no hay autorizacion explicita, aceptar NO_GO seguro.
6. Para apply futuro, frase requerida: AUTORIZO_APPLY_LOCAL_CONTROLADO
7. Para Kanban futuro, frase requerida: AUTORIZO_KANBAN_WRITE_CONTROLADO

Regla rapida: si hay duda, DEFER o NO_GO seguro.
