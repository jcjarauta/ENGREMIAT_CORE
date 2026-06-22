# NEXT OBJECTIVE

ID: ENGREMIAT_OPERATOR_V2_ROOT_WRAPPER_008

Objetivo: crear una capa wrapper/router controlada para el root launcher antes de aplicar cambios directos en ENGREMIAT.ps1.

Motivo: ROOT_LOOP_ROUTER_007 deja el router preparado, pero no conviene integrarlo aun en la puerta estable del sistema.

Prioridades:
1. Crear wrapper experimental no invasivo fuera de ENGREMIAT.ps1.
2. Simular el bucle root con el router dry-run.
3. Probar feedback real de comandos sin romper launcher estable.
4. Comparar wrapper vs launcher actual.
5. Si el wrapper es estable, decidir si pasa a ser nueva entrada o si se integra de forma minima.

Regla: no modificar ENGREMIAT.ps1 hasta que el wrapper demuestre estabilidad visual y funcional.
