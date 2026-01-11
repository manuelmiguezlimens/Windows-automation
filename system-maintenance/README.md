# System Maintenance Lab

Este laboratorio contiene scripts de Powershell para tareas de **mantenimiento de sistemas** en Windows.
Los scripts incluyen limpieza de archivos temporales, monitoreo de servicios críticos y control de espacio en disco.
Este laboratorio es útil para administradores de sistemas que requieren automatizar tareas repetitivas de mantenimiento y monitoreo.

---

## 📂 Estructura del repositorio

system-maintenance/

├── cleanup-temp.ps1

├── check-services.ps1

├── disk-monitor.ps1

└── README.md

## 🛠 Scripts

### 1️⃣ cleanup-temp.ps1
Elimina archivos temporales de Windows y del usuario.

**Objetivos:**
- Limpiar carpetas temporales (`C:\Windows\Temp` y `%TEMP%`).  
- Borrar archivos más antiguos que un número de días configurable.  
- Generar un log de los archivos eliminados y errores encontrados.

### 2️⃣ check-services.ps1
Verifica el estado de servicios críticos y puede reiniciarlos automáticamente.

**Objetivos:**
- Revisar si los servicios especificados están corriendo.
- Reiniciar servicios detenidos (opcional según configuración).
- Registrar los resultados en un log.

### 3️⃣ disk-monitor.ps1
Monitorea el espacio disponible en discos locales y genera alertas si algún disco está por debajo del umbral.

**Objetivos:**
- Revisar porcentaje de espacio libre en todos los discos locales.
- Generar alerta si el espacio libre es menor que el umbral definido.
- Registrar resultados en un log.

---

## 📌 Recomendaciones

- Ejecutar los scripts como Administrador.
- Revisar los logs generados para confirmar las acciones realizadas.
- Probar primero en un entorno de prueba antes de usar en producción.

---

## 🔗 Autor

Manuel Míguez Liméns – Administrador de Sistemas / Entusiasta de Automatización

[GitHub](https://github.com/manuelmiguezlimens) || [LinkedIn](https://www.linkedin.com/in/manuelmiguezlimens/)
