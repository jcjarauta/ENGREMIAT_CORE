# GUIDED NAVIGATION REPAIR PLAN

status: PASS
decision: REPAIR_SHARED_HELP_CONTRACT_IN_ISOLATED_CANDIDATES
screens_to_repair: 5
help_failures: 5
enter_refresh_failures: 2

## Repair targets

### OPERADOR_WORKERS
- path: C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\OPERADOR_WORKERS.candidate.isolated.ps1
- failed_checks: enter_refresh, help_question_mark
- actions: repair_question_mark_help_contract, repair_enter_empty_refresh_contract

### LAUNCHERS_CONFIGURACION
- path: C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\LAUNCHERS_CONFIGURACION.candidate.isolated.ps1
- failed_checks: enter_refresh, help_question_mark
- actions: repair_question_mark_help_contract, repair_enter_empty_refresh_contract

### TARJETAS
- path: C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\TARJETAS.candidate.isolated.ps1
- failed_checks: help_question_mark
- actions: repair_question_mark_help_contract

### CONTROL_ESTADO
- path: C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\CONTROL_ESTADO.candidate.isolated.ps1
- failed_checks: help_question_mark
- actions: repair_question_mark_help_contract

### MEMORIA_DOCUMENTACION
- path: C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\MEMORIA_DOCUMENTACION.candidate.isolated.ps1
- failed_checks: help_question_mark
- actions: repair_question_mark_help_contract

## Next
- E10_BACKUP_AND_REPAIR_ISOLATED_CANDIDATE_HELP_REFRESH_CONTRACTS