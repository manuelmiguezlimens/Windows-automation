# 🛠️ Monitorización de servicios en Windows

## 📌 Descripción
Este laboratorio implementa un script en Powershell para la monitorización de servicios críticos en sistemas Windows. El objetivo es detectar servicios detenidos y restaurarlos oara evitar incidencias mayores.

El script está pensado como una tarea de **mantenimiento preventivo** que puede ejecutarese de forma manual o programada.

---

## ⚙️ Funcionalidad

- 🔍 Comprueba el estado de servicios críticos del sistema.
- 🚨 Detecta servicios detenidos.
- 🔄 Intenta iniciar automáticamente los servicios parados.
- 📝 Genera un archivo de log con el resultado de cada acción.
- 🔔 Muestra notificaciones locales en Windows cuando se detecta una incidencia.

---

## 🧩 Servicios monitorizados
Por defecto, el script monitoriza los siguientes servicios:
- 🪟 Windows Update (`wuauserv`)
- 🖨️ Print Spooler (`Spooler`)
- 📋 Windows Event Log (`EventLog`)

> La lista de servicios puede ampliarse facilmente editando el script.

---

## ▶️ Uso
Ejecutar el script desde PowerShell:

```powershell
.\service-monitor.ps1
```
---

## ⚠️ Recomendación: 

Ejecutar el script con permisos de administrador para garantizar que pueda iniciar servicios detenidos.

## 📹 Demostración

En este mismo repositorio encontrarás un video en el que se ejecuta el script, observando lo que muestra en la consola al ejecutarse.

⏯️ [Ver video](.\Windows-automation\system-maintenance\Service-Monitor\demo.mp4)

---
## 🗂️ Logs

El script genera un archivo service-monitor.log en la misma carpeta donde
se encuentra el script.

El log incluye:

- ⏱️ Fecha y hora de ejecución

- 📊 Estado de cada servicio

- 🔄 Intentos de inicio

- ❌ Errores detectados

---

## 🔔 Alertas

Cuando un servicio se encuentra detenido o no puede iniciarse, el script muestra una notificación local en el Centro de notificaciones de Windows.

> ℹ️ Las notificaciones solo se muestran si hay un usuario con sesión iniciada.
---

## 🏢 Caso de uso real

Este script puede utilizarse como:

- 🕒 Tarea programada de mantenimiento

- 🧑‍💻 Herramienta de soporte técnico

- ♻️ Mecanismo de autorrecuperación básica de servicios
---

## 🚀 Posibles mejoras

- 📧 Envío de alertas por correo electrónico

- 📄 Exportación del estado de servicios a CSV

- ⚙️ Configuración de servicios desde un archivo externo

- 📡 Integración con sistemas de monitorización