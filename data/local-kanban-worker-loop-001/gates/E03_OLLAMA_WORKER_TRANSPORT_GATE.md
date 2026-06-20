# E03 · Ollama worker transport gate

## Objetivo

Preparar el paso desde worker mock local hacia worker real Ollama local, manteniendo gate humano explícito.

## Estado detectado

- ollama_available: True
- dispatcher: C:\ENGREMIAT_CORE\tools\local-kanban-worker-loop\Invoke-LocalKanbanWorkerLoop.ps1

## Modelos / salida ollama list

```text
NAME         ID              SIZE      MODIFIED   
qwen3:14b    bdbd181c33f2    9.3 GB    5 days ago    
```

## Riesgo

Ejecutar Ollama implica worker real local. Aunque no escribe archivos por sí mismo, consume recursos y genera una respuesta de IA. Por tanto requiere autorización explícita.

## Política

- No Cline/Kanban write.
- No git.
- No red externa desde Engremiat.
- No ejecución real sin autorización humana.
- La salida debe seguir siendo PROPOSAL_ONLY.

## Frase de autorización

```text
AUTORIZO_OLLAMA_WORKER_TRANSPORT_REAL_CARD_001_PROPOSAL_ONLY
```

## Comando que se podrá ejecutar tras autorización

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\tools\local-kanban-worker-loop\Invoke-LocalKanbanWorkerLoop.ps1 -CardId CARD-001 -Transport ollama -AuthorizeRealWorker
```

## Siguiente

Si autorizas, ejecutar E04_OLLAMA_WORKER_TRANSPORT_REAL_PROPOSAL_ONLY. Si no, mantener mock y mejorar dashboard/loop.
