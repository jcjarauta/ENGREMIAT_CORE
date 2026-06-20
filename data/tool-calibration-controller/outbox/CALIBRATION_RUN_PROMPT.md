# CALIBRATION_RUN_PROMPT

Objetivo: validar si el Knowledge/bundle responde de forma accionable, no generica.

Criterios:
1. decision no vacia.
2. import_order_ok claro.
3. missing_context concreto o ninguno.
4. risks concretos.
5. first_safe_action distinta de acciones ya cerradas.
6. next_block exacto y ejecutable como nombre de paquete.

Restricciones:
- analysis_only=true
- git=false
- network=false
- worker_real_execution=false
- auto_apply=false
- no modificar bundles originales

Formato de respuesta:
decision:
quality_score_0_100:
generic_response: true|false
repeats_closed_step: true|false
missing_context:
risks:
first_safe_action:
next_block:
recommendation: ACCEPT|REDUCE|REFINE|NO_GO
