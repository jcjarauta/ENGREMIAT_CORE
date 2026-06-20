# Siguiente pantalla a normalizar

Fecha: 2026-06-20T10:06:50

## Seleccion
- Target: tools\launcher\ENGREMIAT-DATA-INTAKE-CENTER.ps1
- Normalizado propuesto: ENGREMIAT-DATA-INTAKE-CENTER-NORMALIZED.ps1
- Prioridad: HIGH_PRIORITY
- Parse OK: True

## Motivo
- Opciones visibles: 5
- Numeros legacy detectados: 2
- Read-Host detectados: 2

## Opciones detectadas
- [1].Value}};return 'No definido'}
- [15] Memoria y documentacion > [17] Data Intake / Entrada de datos y fichas' DarkGray;W 'Rol: productor y normalizador local de fichas estructuradas' Gray;if($sub){W $sub Yellow};W ''}
- [1] -eq 'No definido'){$pending+=$kv[0]}};if($criteria.Count -eq 0){$pending+='criterios'};if($docs.Count -eq 0){$pending+='documentacion_requerida'};$found=@($entity,$territory,$deadline,$amount,$objective,$beneficiaries,$summary)|Where-Object{$_ -ne 'No definido'};$confidence=if($found.Count -ge 6 -and $criteria.Count -gt 0 -and $docs.Count -gt 0){'medium'}elseif($found.Count -ge 3){'low'}else{'none'};$src=[ordered]@{source_id='intake-'+$mode+'-'+$stamp;source_type=$mode;source_path=$sourceFile;created_at=(Get-Date).ToString('s');status='normalized';human_review_required=($pending.Count -gt 0);title=[IO.Path]::GetFileNameWithoutExtension($sourceFile);raw_text_length=$raw.Length};$profile=[ordered]@{profile_id='grant-call-profile-from-'+$mode+'-latest';profile_type='grant_call';schema='ENGREMIAT_NORMALIZED_PROFILE_CONTRACT_V1';created_at=(Get-Date).ToString('s');status=if($pending.Count -eq 0){'ready'}else{'pending_review'};human_review_required=($pending.Count -gt 0);confidence=$confidence;source=$src;titulo=[IO.Path]::GetFileNameWithoutExtension($sourceFile);convocatoria_nombre=[IO.Path]::GetFileNameWithoutExtension($sourceFile);entidad_convocante=$entity;entity=$entity;territorio=$territory;territory=$territory;fecha_limite=$deadline;deadline=$deadline;importe_maximo=$amount;amount=$amount;objetivo_convocatoria=$objective;beneficiarios=$beneficiaries;criterios=$criteria;criteria=$criteria;documentacion_requerida=$docs;required_documents=$docs;resumen=$summary;summary=$summary;encaje_engremiat='Ficha generada por Data Intake local.';pending_fields=$pending;metadata=[ordered]@{producer='ENGREMIAT-DATA-INTAKE-CENTER';local_first=$true;network_used=$false;external_ai_used=$false}};$sourcePath=Join-Path $Base ('profiles\intake-source-'+$mode+'-latest.json');$profilePath=Join-Path $Base ('normalized\grant-call-profile-from-'+$mode+'-latest.json');$active=Join-Path $Core 'documents\grants\grant-call-profile-latest.json';J $src $sourcePath;J $profile $profilePath;Copy-Item $profilePath $active -Force;Header 'TXT/MD IMPORTADO Y NORMALIZADO';W ('OK fuente_registrada=True modo='+$mode+' confidence='+$confidence+' pendientes='+$pending.Count) Green;W $profilePath Cyan}
- [3].')|Set-Content $t -Encoding UTF8;Start-Process notepad.exe $t;Header 'TXT/MD PENDIENTE';W 'PENDING plantilla_txt_creada=True' Yellow;P;return};$f=$files|Select-Object -First 1;$raw=Get-Content $f.FullName -Raw;if($raw -match 'PEGA AQUI EL TEXTO' -or $raw.Trim().Length -lt 80){Start-Process notepad.exe $f.FullName;Header 'TXT/MD INSUFICIENTE';W 'PENDING pega_texto_y_guarda=True' Yellow;P;return};NormalizeTextSource $f.FullName $raw 'txt_md';P}
- [1] activar ficha demo completa';W '[2] crear/abrir ficha manual editable';W '[3] importar TXT/MD desde inbox y normalizar';W '[4] importar JSON desde inbox como ficha activa';W '[5] abrir carpeta inbox de entradas';W '[6] abrir carpeta normalized de fichas';W '[7] ver estado de Data Intake';W '[8] abrir contratos Data Intake';W '[b] volver al Centro Documental';W '';W '[Enter] refrescar | b = volver | ? = ayuda' DarkGray;W '';$op=Read-Host 'DATA_INTAKE';switch($op){'1'{DemoProfile};'2'{ManualProfile};'3'{ImportTxtMd};'4'{ImportJson};'5'{OpenInbox};'6'{OpenNormalized};'7'{Status};'8'{OpenContracts};'b'{return};'?'{Header 'AYUDA';W 'Data Intake produce fichas. Centro Documental las consume. No se usa red, IA externa ni scraping.';P};''{continue};default{W 'Opcion no reconocida' Yellow;Start-Sleep -Milliseconds 700}}}}

## Metodo
1. Crear blueprint paralelo.
2. Reescribir pantalla normalizada con header canonico.
3. Numeracion local desde [1].
4. Un submenu/frontera por fase.
5. Mantener legacy funcional hasta validacion humana.

## Siguiente
E34_CREATE_PARALLEL_NORMALIZED_SCREEN_BLUEPRINT
