# GRAPHITI_READY_PLAN

## Objetivo
Preparar una futura ingestion de memoria de desarrollo en Graphiti, Memgraph o Neo4j sin activarla todavia.

## Entrada tecnica
- `ENGREMIAT_MEMORY/graph/export/nodes.jsonl`
- `ENGREMIAT_MEMORY/graph/export/edges.jsonl`

## Entidades temporales
Objective, Stage, Block, Step, Artifact, Error, Decision, Gate, Worker, Evidence, Page, Map, Demo.

## Eventos de desarrollo
- step_created
- artifact_produced
- error_fixed
- gate_authorized
- evidence_validated
- objective_closed

## Politica actual
NO_GO para ingestion real. Sin red, sin contenedores, sin base de datos.
