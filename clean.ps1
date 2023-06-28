# Clear Event Viewer Log
$eventLogName = "Microsoft-Windows-Windows Defender/Operational"
$eventLogExists = Get-WinEvent -ListLog * | Where-Object { $_.LogName -eq $eventLogName }

if ($eventLogExists) {
    Clear-EventLog -LogName $eventLogName -ErrorAction SilentlyContinue
} else {
    Write-Host "Event log '$eventLogName' does not exist."
}

# Delete folder contents
$folders = @(
    "C:\ProgramData\Microsoft\Windows Defender\Scans\History",
    "C:\ProgramData\Microsoft\Windows Defender\Scans\History\Service"
)

foreach ($folder in $folders) {
    if (Test-Path $folder) {
        $items = Get-ChildItem -Path $folder -Force
        foreach ($item in $items) {
            if ($item.PSIsContainer) {
                Remove-Item -Path $item.FullName -Recurse -Force -ErrorAction SilentlyContinue
            } else {
                try {
                    Remove-Item -Path $item.FullName -Force -ErrorAction Stop
                } catch {
                    # Continue silently if unable to delete file
                }
            }
        }
    }
}

# Print success message
Write-Host "Script executed successfully."
