# MODULAR PLATFORM MANUAL

## Qué es
ENGREMIAT_MODULAR_PLATFORM_001 es la base modular del sistema.
Su misión es permitir crecer por módulos sin tocar el core congelado.

## Cómo acoplar un módulo
1. Definir contrato.
2. Declarar identidad, versión, estado y dependencias.
3. Validar compatibilidad.
4. Generar paquete del módulo.
5. Crear evidencia o dashboard si aplica.
6. Registrar el módulo en el sistema operativo modular.

## Cómo desacoplar un módulo
1. Marcar el módulo en estado pausado, deprecated o retired.
2. Registrar la razón.
3. Conservar trazabilidad y memoria.
4. Verificar que no rompe la cadena de dependencias.
5. Mantener el inventario visible.

## Cómo actualizar un módulo
1. Crear nueva versión.
2. Registrar compatibilidad.
3. Validar sustitución.
4. Emitir reporte de cambio.
5. Mantener el historial anterior.

## Regla de oro
Nada entra en producción modular sin contrato, paquete y validación.