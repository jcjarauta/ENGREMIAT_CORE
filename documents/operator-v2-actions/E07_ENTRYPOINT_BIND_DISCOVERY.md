# E07 EntryPoint Bind Discovery

Estado: PASS
Bridge: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-entrypoint-bridge.ps1
Adapter: 
C:\Users\pc\Desktop\ENGREMIAT_OPERADOR_V2\engine\screen-actions-router-adapter.ps1
Best candidate: 
C:\ENGREMIAT_CORE\ENGREMIAT.ps1

## Top candidates
- score=11 path=C:\ENGREMIAT_CORE\ENGREMIAT.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123351\snapshots\data__ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123351\snapshots\launcher_actual__ENGREMIAT-LAUNCHER-ACTUAL.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123351\snapshots\master__ENGREMIAT.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123351\snapshots\memoria__ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\data__ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\launcher_actual__ENGREMIAT-LAUNCHER-ACTUAL.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\master__ENGREMIAT.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\freezers\ENGREMIAT_STABLE_FREEZER_BEFORE_CHILD_NORMALIZATION_20260621-123459\snapshots\memoria__ENGREMIAT-MEMORY-DOCUMENTATION-CENTER-NORMALIZED.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\eng-router.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\tools\desktop-terminal-operator\Start-EngremiatDesktopOperator.ps1 why=name,input_loop,menu_tokens,screen_or_switch
- score=11 path=C:\ENGREMIAT_CORE\tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1 why=name,input_loop,menu_tokens,screen_or_switch

## Siguiente paso
E08 aplicar guarded write solo sobre el candidato elegido, insertando llamada a Invoke-EngOperatorInputWithActionsBridge antes del fallback legacy.
