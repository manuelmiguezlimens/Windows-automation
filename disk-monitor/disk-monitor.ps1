<#
.SYNOPSIS
Monitorizar el espacio en discos locales y genera alertas si el espacio libre es bajo.

.DESCRIPTION
Este script comprueba el espacio disponible en los discos locales del sistema Windows.
Si algún disco tiene un porcentaje de espacio ibre inferior al umbral definido,
se genera una notificación local (toast) y se registra la información en un archivo de log.

.PARAMETER Threshold
Porcentaje mínimo de espacio libre permitido. Por defecto 15%.

.EXAMPLE
.\disk-monitor.ps1 -Threshold 15
#>

# ----- Parámetro del script -----
param(
    # Umbral mínimo de espacio libre (en porcentaje)
    [ValidateRange(1,100)]
    [int]$Threshold = 15
)

# ----- Archivo de log -----
$LogFile = "$PSScriptRoot\disk-monitor.log"     # Guardamos logs en la misma carpeta que el script

# ----- Función para escribir en log y consola -----
function Write-Log {
    param (
        [string]$Message,           # Mensaje a registrar
        [string]$color = "White"    # Color del texto en consola
    )
    
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"     # Timestamp para cada mensaje
    $entry = "$timestamp - $Message"                        # Formatear mensaje
    Write-Host $entry -ForegroundColor $color               # Mostrar mensaje en consola con color
    Add-Content -Path $LogFile -Value $entry                # Guardar en log
}

# ----- Función para mostrar notificación local -----
function Show-DiskAlert {
    param (
        [string]$Title,     # Título de la alerta
        [string]$Message    # Mensaje de la alerta
    )

    [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
    [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom.XmlDocument, ContentType = WindowsRuntime] | Out-Null

    $toastXml = @"
<toast>
    <visual>
        <binding template="ToastGeneric">
            <text>$Title</text>
            <text>$Message</text>
        </binding>
    </visual>
</toast>
"@

    $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
    $xml.LoadXml($toastXml)

    $toast = New-Object Windows.UI.Notifications.ToastNotification $xml
    $notifier = [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("Disk Monitor")

    $notifier.Show($toast)
}

# ----- Inicio del script -----
Write-Log "Inicio del monitoreo de discos. Umbral: $Threshold%" "Magenta"

# ----- Obtener discos locales -----
$disks = Get-CimInstance Win32_LogicalDisk |
         Where-Object { $_.DriveType -eq 3}

# ----- Procesar cada disco -----
foreach ($disk in $disks) {
    try{
        # Calcular espacio libre y total
        $freeGB = [math]::Round($disk.FreeSpace / 1GB, 2)
        $totalGB = [math]::Round($disk.Size / 1GB, 2)
        $freePct = [math]::Round(($disk.FreeSpace /$disk.Size) * 100, 2)

        Write-Log "Disco $($disk.DeviceID) - Libre: $freeGB GB ($freePct%) de $totalGB GB"

        # Comprobar si el espacio libre está debajo del umbral
        if ($freePct -lt $Threshold){
            $alertMsg = "Disco $($disk.DeviceID): $freePct% libre ($freeGB GB de $totalGB GB)"

            Write-Log "ALERTA: $alertMsg" "Red"
            Show-DiskAlert -Title "Alerta de espacio en disco" -Message $alertMsg
        }
    }
    catch {
        # Capturar errores por disco
        Write-Log "Error al procesar el disco $($disk.DeviceID): $_" "Red"
    }
}

# ----- Fin del script -----
Write-Log "Monitoreo de discos finalizado." "Magenta"