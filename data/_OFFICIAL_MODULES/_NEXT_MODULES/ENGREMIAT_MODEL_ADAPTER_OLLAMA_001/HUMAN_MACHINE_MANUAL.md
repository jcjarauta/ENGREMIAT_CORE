# HUMAN_MACHINE_MANUAL — ENGREMIAT_MODEL_ADAPTER_OLLAMA_001

## Proposito
Adaptador concreto de Ollama sobre ENGREMIAT_MODEL_ADAPTER_STANDARD_001. No depende del composer core. No ejecuta inferencia real por defecto.

## Flujo
1. MODEL_REQUEST estandar.
2. Mapping a OLLAMA_PAYLOAD.
3. Mock adapter sin endpoint real.
4. Availability check readonly local /api/tags.
5. Gate de inferencia real preparado y bloqueado por defecto.
6. Pipeline dry-run: mock + availability + gate blocked.
7. Validador global.

## Comandos
Mock: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001\tools\Invoke-OllamaAdapterMock.ps1"
Availability readonly: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001\tools\Test-OllamaLocalAvailability.ps1"
Gate blocked: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001\tools\Invoke-OllamaRealInferenceGated.ps1"
Pipeline: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001\tools\Invoke-OllamaAdapterDryRunPipeline.ps1"
Validator: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_MODEL_ADAPTER_OLLAMA_001\tools\Invoke-OllamaAdapterValidator.ps1"

## Seguridad
Sin inferencia real por defecto. Sin endpoint /api/generate sin autorizacion literal. Gate requerido: AUTORIZO_OLLAMA_REAL_INFERENCE_GATED.
