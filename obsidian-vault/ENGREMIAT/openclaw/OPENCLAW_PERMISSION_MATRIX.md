# OPENCLAW PERMISSION MATRIX

| Area | Estado actual | Futuro posible | Gate requerido |
|---|---|---|---|
| Leer documentos preparados | PERMITIDO EN LAB | Si | No si son paquetes curados |
| Leer vault completo Obsidian | NO | Posible con filtro | Si |
| Leer Open WebUI KB | NO DIRECTO | Posible via export controlado | Si |
| Leer backend API local | NO | Posible read-only | Si |
| Escribir archivos | NO | Posible gated | Si explicito |
| Ejecutar comandos | NO | Posible gated | Si explicito |
| Enviar Telegram | NO | Posible gated | Si explicito |
| Usar credenciales | NO | Solo secreto gestionado | Si alto |
| Git commit/push | NO | No en esta fase | Si especifico |
| Docker/DB actions | NO | No en esta fase | Si especifico |

## Regla
Toda accion distinta de leer paquete curado requiere gate humano explicito.
