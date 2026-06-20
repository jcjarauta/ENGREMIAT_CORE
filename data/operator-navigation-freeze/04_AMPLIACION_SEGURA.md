# 04 AMPLIACION SEGURA

## Estrategia
- Ampliar por scripts separados siempre que sea posible.
- El router solo debe delegar; la logica vive fuera.
- Una frontera tecnica por bloque.
- Primero readonly, despues escritura controlada.
- Cada escritura deja reporte JSON.
- Cada cambio de UX actualiza documentacion freeze.

## Puntos de extension recomendados
- Biblioteca de modulos como script separado.
- Creacion de modulos como script separado.
- Revision de proyecto como script separado.
- Importacion/exportacion Obsidian como script separado.
- Worker futuro como flujo gated separado.

## Criterio de aceptacion
Una ampliacion solo se acepta si Validate-OperatorFreeze.ps1 sigue dando PASS o si se crea freeze successor justificado.
