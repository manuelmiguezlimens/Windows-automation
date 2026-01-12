<#
.SYNOPSIS
Limpia carpetas temporales de Windows y usuario eliminando archivos antiguos.

.DESCRIPTION
Este script recorre las carpetas temporales del sistema (%TEMP%) y de Windows (C:\Windows\Temp),
elimina archivos que tengan más días de los especificdos en el parámetro -Days y genera un log.

.PARAMETER Days
Número de días para eliminar archivos más antiguos que este valor. Por defecto 30.

.EXAMPLE
.\cleanup-temp.ps1 -Days 30
#>

# ----- Parámetro del script -----
param(
    [ValidateRange(1,365)]
    [int]$days = 30  # Número de días para considerar archivos antiguos
)

# ----- Archivo de log -----
$LogFile = "$PSScriptRoot\cleanup-temp.log"     # Guardamos logs en la misma carpeta que el script

# ----- Función para escribir en log y consola -----
function Write-Log {
    param ([string]$Message, [string]$color = "White")

    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"     # Timestamp para cada mensaje
    $entry = "$timestamp - $Message"                        # Formatear mensaje
    Write-Host $entry -ForegroundColor $color               # Mostrar mensaje en consola con color
    Add-Content -Path $LogFile -Value $entry                # Guardar en log
    
}

# ----- Carpetas temporales a limpiar -----
$folders = @(
    "$env:TEMP",       # Carpeta temporal del usuario actual
    "C:\Windows\Temp"  # Carpeta temporal del sistema
)

# ----- Recorrer cada carpeta -----
foreach ($folder in $folders) {
    Write-Log "Iniciando limpieza en $folder" "Cyan"

    # Verificar que la carpeta exista
    if (-Not (Test-Path $folder)) {
        Write-Log "Carpeta no encontrada: $folder" "Yellow"
        continue
    }

    try {
        # Obtener archivos más antiguos que el parámetro Days
        $files = Get-ChildItem -Path $folder -Recurse -File -ErrorAction SilentlyContinue |
        Where-Object { $_.LastWriteTime -lt (Get-Date).AddDays(-$days) }

        # ----- Eliminar archivos uno por uno -----
        foreach ($file in $files){
            try {
                Remove-Item -Path $file.FullName -Force -ErrorAction Stop
                Write-Log "Archivo eliminado: $($file.FullName)" "Green"
            }
            catch {
                # Capturar errores individuales de cada archivo
                Write-Log "Error al eliminar $($file.FullName): $_" "Red"
            }
        }
    }
    catch {
        # Capturar errores al procesar la carpeta completa
        Write-Log "Error al procesar la carpeta $folder : $_" "Red"
    }

    Write-Log "Limpieza completada en $folder" "Cyan"
}


Write-Log "Limpieza de archivos temporales finalizada." "Magenta"
