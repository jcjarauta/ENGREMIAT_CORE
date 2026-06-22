# Card View Integration Decision

Estado: PASS

Decision: integrar tarjetas dentro de `Proyectos > Proyecto > Modulos > Tarjetas`.

Jerarquia canonica:
- PROYECTO
  - MODULO
    - TARJETA

Reglas:
- La tarjeta nunca existe suelta.
- Toda tarjeta pertenece a un modulo.
- Todo modulo pertenece a un proyecto.
- La vista dentro de modulo debe filtrar por project_id y module_id.
- La vista global puede existir solo como acceso transversal.

Next: E94B_CREATE_FILTERABLE_CARD_VIEW_FOR_PROJECT_MODULE