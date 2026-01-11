# Cleanup Temp Lab

Este laboratorio contiene un script de Powershell para la **limpieza de archivos temporales** en Windows.
El objetivo es eliminar archivos antiguos de las carpetas temporales del usuario y del sistema, facilitando el mantenimiento y liberando espacio en disco.

---

## 📂 Contenido de la carpeta

cleanup-temp/

├── cleanup-temp.ps1    # Script principal de limpieza

├── README.md           # Este archivo

└── demo.mp4            # Video demostrando el funcionamiento (opcional)

---

## 🛠 Descripción del Script

**cleanup-temp.ps1** realiza lo siguiente:

- Limpia las carpetas temporales:

    - `%TEMP` (usuario actual)
    - `C:\Windows\Temp` (sistema)

- Elimina archivos más antiguos que el numero de días especificado en el parámetro `-Days`.
- Genera un **log** (`cleanup-temp.log`) con los archivos eliminados y errores.
- Muestra mensajes en consola con colores

    - <span style="color: green;">Verde</span> → archivo eliminado
    - <span style="color: red;">Rojo</span> → error
    - <span style="color: cyan;">Cian</span> → inicio y fin de carpeta
    - <span style="color: magenta;">Magenta</span> → finalización total

---

## ⚡ Uso

Abrir PowerShell **como administrador** y ejecutar:

```powershell
.\cleanup-temp.ps1 -Days 30
```

### Parametros

| Parámetro | Descripción                                           | Valor por defecto |
| --------- | ----------------------------------------------------- | ----------------- |
| `-Days`   | Elimina archivos más antiguos que este número de días | 30                |

---

## 📋 Logs

- El script genera un archivo de log en la misma carpeta que el script: `cleanup-temp.log`
- Contiene:

    - Archivos eliminados.
    - Errores de eliminación.
    - Estado de cada carpeta temporal procesada.

Ejemplo de entrada en el log:

```
2026-01-11 15:30:21 - Archivo eliminado: C:\Users\Juan\AppData\Local\Temp\tempfile.tmp
2026-01-11 15:30:21 - Limpieza completada en C:\Users\Juan\AppData\Local\Temp
```

---

## 🎥 Demostración

Si quieres ver cómo funciona:

[![Ver vídeo](./thumbnail.png)](./demo.mp4)

El video muestra el script ejecutándose en PowerShell y eliminando archivos temporales antiguos.

---

## ⚠️ Recomendaciones

- Ejecutar como **Administrador**.
- Probar primero en un entorno de prueba para evitar eliminar archivos importantes.
- Revisar el log después de la ejecución.
- Puede integrarse en tareas programadas (_Task Scheduler_) para automatización regular.

---

## 🔗 Autor

Manuel Míguez Liméns – Administrador de Sistemas / Entusiasta de Automatización

[GitHub](https://github.com/manuelmiguezlimens) || [LinkedIn](https://www.linkedin.com/in/manuelmiguezlimens/)