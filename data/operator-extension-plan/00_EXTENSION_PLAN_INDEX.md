# ENGREMIAT OPERATOR EXTENSION PLAN v1

Estado: PLAN DEFINIDO
Fecha: 
2026-06-19T22:59:08

## Baseline protegido
- Freeze: C:\ENGREMIAT_CORE\data\operator-navigation-freeze\operator-baseline-freeze.v1.json
- Validator: C:\ENGREMIAT_CORE\data\operator-navigation-freeze\Validate-OperatorFreeze.ps1
- Proyecto activo congelado: C:\Users\pc\Desktop\ENGREMIAT_OPERATOR\ENGREMIAT_PROJECT_p3_20260619-224903

## Orden recomendado
1. EXT04_PROJECT_REVIEW_SAFE — revisar proyecto sin tocar nada.
2. EXT01_CREATE_MODULE_SAFE — crear modulo seguro.
3. EXT02_MODULE_SELECTOR_SAFE — afinar entrada/salida de modulo.
4. EXT03_MODULE_LIBRARY_SAFE — biblioteca de modulos.
5. EXT05_OBSIDIAN_SYNC_PREVIEW — preview Obsidian.
6. EXT06_WORKER_GATE_FUTURE — worker futuro con gate.

## Regla
Antes y despues de cada extension ejecutar Validate-OperatorFreeze.ps1, salvo freeze successor documentado.
