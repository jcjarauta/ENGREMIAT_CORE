# Cierre E96 - Integracion Proyecto > Modulo > Tarjeta

## Estado
PASS

## Ruta consolidada
INICIO > Proyectos > Proyecto > Modulos > MODULE_inicio > Tarjetas

## Reglas cerradas
- Todo proyecto debe tener MODULE_inicio.
- Toda tarjeta pertenece a un modulo.
- Todo modulo pertenece a un proyecto.
- Las tarjetas PROPOSED no ejecutan.
- human_gate=SI por defecto.
- Las identidades genericas como project_id=projects deben normalizarse.

## Validado
- Launchers parse OK.
- Tabla normalizada contiene tarjetas base de inicio.
- Indice de tarjetas parse OK.
- Ruta filtrada por project_id/module_id validada.

## Siguiente recomendado
E97_CREATE_CARD_DETAIL_VIEW