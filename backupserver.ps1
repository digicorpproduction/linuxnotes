# Define variables
$serverName = "ms67099.mycompany.com"
$backupLocation = "C:\Backups\" + $serverName + "_" + (Get-Date -Format "yyyyMMdd_HHmmss")

# Create backup folder if it doesn't exist
New-Item -ItemType Directory -Path $backupLocation -Force

# Backup all configurations using Export-Clixml cmdlet
Export-Clixml -Path "$backupLocation\AllConfigurations.xml" -InputObject (Get-Item WSMan:\localhost\*)

# Backup all Event Logs using Get-EventLog cmdlet
Get-EventLog -LogName * | Export-Csv "$backupLocation\EventLogs.csv" -NoTypeInformation

# Backup all IIS website configurations using Export-IISConfiguration cmdlet
Export-IISConfiguration -PhysicalPath "IIS:\Sites" -DestinationPath "$backupLocation\IISConfig.zip"

# Display message when backup is complete
Write-Host "Backup complete. Files saved to $backupLocation"
