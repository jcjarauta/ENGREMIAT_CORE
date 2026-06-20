# HUMAN_MACHINE_MANUAL — ENGREMIAT_MODEL_ADAPTER_STANDARD_001

Estándar común para adaptadores de modelo. No llama a modelos reales por defecto. Modos: DRY_RUN, MOCK, REAL_GATED. INFER requiere gate humano. Flujo: model request -> prompt envelope -> mock/adapter -> normalized output -> evidence.
