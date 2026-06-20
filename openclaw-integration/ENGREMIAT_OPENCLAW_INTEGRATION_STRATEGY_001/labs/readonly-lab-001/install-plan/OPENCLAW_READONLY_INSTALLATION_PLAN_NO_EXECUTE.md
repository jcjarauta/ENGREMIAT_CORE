# OPENCLAW READONLY INSTALLATION PLAN - NO EXECUTE

## Objetivo
Preparar una instalacion futura de OpenClaw en modo laboratorio aislado READ_ONLY sin ejecutarla todavia.

## Decision tecnica recomendada
Primera prueba preferida: entorno aislado Docker o carpeta dedicada, con volumen minimo de entrada read-only y sin credenciales.

## Carpeta de laboratorio
C:\ENGREMIAT_CORE\openclaw-integration\ENGREMIAT_OPENCLAW_INTEGRATION_STRATEGY_001\labs\readonly-lab-001

## Entradas permitidas
Solo documentos curados dentro de labs/readonly-lab-001/input.

## Salidas permitidas futuras
Solo texto de resultado o evidencia manual en labs/readonly-lab-001/evidence.

## Prohibiciones
No repo completo. No .env. No tokens. No Telegram real. No APIs externas. No escritura automatica. No shell desde OpenClaw. No skills externas.

## Pasos futuros propuestos
1. Validar que Docker/Node estan disponibles si hiciera falta.
2. Crear carpeta aislada de input.
3. Copiar paquete read-only minimo.
4. Preparar comando de instalacion, pero no ejecutarlo.
5. Pedir confirmacion humana adicional antes de instalar.

## Siguiente gate requerido
Antes de instalar, el humano debera autorizar explicitamente: AUTORIZO_INSTALAR_OPENCLAW_READONLY_LAB_001_SIN_SECRETOS_SIN_TELEGRAM
