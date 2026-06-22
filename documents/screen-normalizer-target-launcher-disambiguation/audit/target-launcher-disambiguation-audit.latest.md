# TARGET LAUNCHER DISAMBIGUATION

package: ENGREMIAT_SCREEN_NORMALIZER_TARGET_LAUNCHER_DISAMBIGUATION_001
stage: E01_AUDIT_CONTROL_ESTADO_LAUNCHER_CANDIDATES_READONLY
status: PASS

target: CONTROL_ESTADO
decision: TARGET_REAL_RECOMMENDED_REVIEW_BEFORE_APPLY
recommended_target_launcher: C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1

## Matches

### ENGREMIAT-LAUNCHER-ACTUAL.ps1
- score: 9
- kind: LIKELY_TARGET_HUMAN_SCREEN
- path: C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-LAUNCHER-ACTUAL.ps1
- reasons: parse_ok, control_estado_terms, human_screen_header, interactive_screen_loop, enter_refresh, launcher_aux_signal, tool_or_test_signal

### ENGREMIAT-INICIO-NORMALIZED.ps1
- score: 7
- kind: POSSIBLE_TARGET_REVIEW
- path: C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-INICIO-NORMALIZED.ps1
- reasons: parse_ok, control_estado_terms, human_screen_header, interactive_screen_loop, m_visible, enter_refresh, help_present, launcher_aux_signal, tool_or_test_signal, root_inicio_not_internal_target