<#
.SYNOPSIS
Monitoriza servicios críticos y reinicia los que estén detenidos.

.DESCRIPTION
Este script comprueba el estado de servicios críticos de Windows.
Si un servicio está detendo, intenta reiniciarlo y registra el ressultado en un archivo de log.
Muestra notificación local en caso de que existan incidencias.

.EXAMPLE
.\service-monitor.ps1
#>

# ----- Archivo de log -----
$LogFile = "$PSScriptRoot\service-monitor.log"

# ----- Servicios a monitorizar -----
$services = @(
    "wuauserv",     # Windows Update
    "Spooler",      # Print Spooler
    "EventLog"      # Windows Event Log
)

# ----- Funcion para escribir en log y consola -----
function Write-Log {
    param (
        [string]$Message,
        [string]$Color = "white"
    )

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $entry = "$timestamp - $Message"

    Write-Host $entry -ForegroundColor $Color
    Add-Content -Path $LogFile -Value $entry
    
}

# ----- Funcion para mostrar notificación local -----
function  Show-ServiceAlert {
    param (
        [string]$Message
    )
    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

    $toastXml = @"
<toast>
    <visual>
        <binding template="ToastGeneric">
            <text>Alerta de servicios</text>
            <text>$Message</text>
        </binding>
    </visual>
</toast>
"@

    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $xml.LoadXml($toastXml)

    $toast = New-Object Windows.UI.Notifications.ToastNotification $xml
    $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Service Monitor")

    $notifier.Show($toast)
}

# ----- Inicio del script -----
Write-Log "Inicio del monitoreo de servicios." "Magenta"

# ----- Comprobar cada servicio -----
foreach ($serviceName in $services) {
    try {
        $service = Get-Service -Name $serviceName -ErrorAction Stop

        if ($service.Status -ne "Running") {
            Write-Log "Servicio detenido: $serviceName. Intentando reiniciar..."

            try {
                Start-Service -Name $serviceName -ErrorAction Stop
                Write-Log "Servicio iniciado correctamente: $serviceName" "Green"
                Show-ServiceAlert "El servicio $serviceName estaba detenido y fue iniciado correctamente"
            }
            catch {
                Write-Log "ERROR al iniciar el servicio $serviceName : $_" "Red"
                Show-ServiceAlert "ERROR al iniciar el servicio $serviceName"
            }
        }
        else {
            Write-Log "Servicio en ejecucion: $serviceName"
        }
    }
    catch {
        Write-Log "No se pudo obtener el servicio $serviceName : $_ " "Red"
        Show-ServiceAlert "No se pudo verificar el servicio $serviceName"
    }
}

# ----- Fin del script -----
Write-Log "Monitoreo de servicios finalizado." "Magenta"