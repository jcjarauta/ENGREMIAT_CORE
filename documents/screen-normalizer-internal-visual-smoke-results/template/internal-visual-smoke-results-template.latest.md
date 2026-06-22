# INTERNAL VISUAL SMOKE RESULTS TEMPLATE

package: ENGREMIAT_SCREEN_NORMALIZER_INTERNAL_VISUAL_SMOKE_RESULTS_001
stage: E01_PREPARE_VISUAL_SMOKE_RESULTS_TEMPLATE_NO_EXECUTE
status: PASS

## Uso
Abrir candidatos manualmente solo si se quiere revisar visualmente. Este paso no ejecuta ni migra nada.

## Candidatos

### PROYECTOS
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\PROYECTOS.candidate.isolated.ps1"
```

### MEMORIA_DOCUMENTACION
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\MEMORIA_DOCUMENTACION.candidate.isolated.ps1"
```

### CONTROL_ESTADO
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\CONTROL_ESTADO.candidate.isolated.ps1"
```

### LAUNCHERS_CONFIGURACION
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\LAUNCHERS_CONFIGURACION.candidate.isolated.ps1"
```

### OPERADOR_WORKERS
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\OPERADOR_WORKERS.candidate.isolated.ps1"
```

### TARJETAS
```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File "C:\ENGREMIAT_CORE\documents\screen-normalizer-internal-candidates-generation\generated\TARJETAS.candidate.isolated.ps1"
```
