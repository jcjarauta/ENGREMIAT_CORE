# RELATION_MODEL

| Relacion | Significado | Ejemplo |
|---|---|---|
| contains | Una entidad contiene otra | Objective contains Stage |
| depends_on | Una entidad depende de otra | Step depends_on Step anterior |
| produces | Una accion produce un artefacto | Step produces Artifact |
| fixes | Una reparacion corrige un error | Step fixes Error |
| blocks | Un problema bloquea avance | Error blocks Step |
| authorizes | Un gate autoriza una accion | Gate authorizes Apply |
| validates | Una evidencia valida una accion | Report validates Step |
| supersedes | Una version sustituye otra | Repair supersedes Script anterior |
