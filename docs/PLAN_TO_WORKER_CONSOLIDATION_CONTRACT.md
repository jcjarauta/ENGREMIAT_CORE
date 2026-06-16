PLAN_TO_WORKER_CONSOLIDATION_CONTRACT

Objective: ENGREMIAT_PLAN_TO_WORKER_APP_CONSOLIDATION_002

Purpose: consolidate Plan To Worker as a local-first hub for human input, canonical normalization, worker adapter endpoints, system-consumable output and graph output for human vision.

Core layers: input layer, normalization layer, decision layer, worker adapter layer, system output layer, graph output layer, human dashboard layer, memory/event layer.

Responsibilities: receive structured plans, validate inputs, produce canonical work items, prepare file endpoints for Cline/Ollama/OpenClaw/generic workers, expose system outputs, generate graph outputs, preserve evidence and keep human gates.

Boundaries: no external network, no real worker execution, no automatic apply, no git write, no commit, no push, no fetch, no merge, no browser automation, no clipboard automation, no secrets.

Human rule: the system prepares and validates; the human decides; workers propose; evidence gates progress.

Definition of done E01: contract, io-map, worker-adapter-boundaries, graph-output-contract, validator and smoke report exist and validate locally.
