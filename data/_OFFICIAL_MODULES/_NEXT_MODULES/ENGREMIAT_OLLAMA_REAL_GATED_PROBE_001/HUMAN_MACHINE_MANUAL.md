# HUMAN_MACHINE_MANUAL — ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001

## Proposito
Primera prueba real controlada de inferencia Ollama con autorizacion humana literal.

## Resultado clave
Se ejecuto una unica llamada local autorizada a /api/generate y se genero evidencia normalizada.

## Autorizacion usada
AUTORIZO_OLLAMA_REAL_INFERENCE_GATED

## Flujo
1. Registrar autorizacion.
2. Preflight readonly /api/tags.
3. Preparar payload minimo.
4. Ejecutar una llamada real gated.
5. Guardar real-inference-result.json.
6. Normalizar respuesta en normalized-real-response.json.
7. Auditar evidencia y seguridad.
8. Validar sin repetir inferencia.

## Comandos
Preflight: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001\tools\Test-OllamaProbePreflight.ps1"
Runner real gated: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001\tools\Invoke-OllamaRealGatedProbe.ps1" -Authorization "AUTORIZO_OLLAMA_REAL_INFERENCE_GATED"
Validador: powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\data\_OFFICIAL_MODULES\_NEXT_MODULES\ENGREMIAT_OLLAMA_REAL_GATED_PROBE_001\tools\Invoke-RealGatedProbeValidator.ps1"

## Seguridad
No repetir inferencia en auditoria. No convertir Ollama en dependencia del composer. El uso real futuro debe mantenerse gobernado por gates.
