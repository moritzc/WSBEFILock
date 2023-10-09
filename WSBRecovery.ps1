$StartTime = (Get-Date).AddHours(-18)
$EndTime = Get-Date
$LogName = 'Microsoft-Windows-Backup'
$EventID = 5
$Keyword = '0x8078011E'

$Events = Get-WinEvent -FilterHashtable @{
    LogName = $LogName
    ID = $EventID
    StartTime = $StartTime
    EndTime = $EndTime
} -ErrorAction SilentlyContinue | Where-Object { $_.Message -match $Keyword }

If ($Events.Count -ge 1) {
    Write-Output "Backup failed with EFI lock error"
	$CurrentBackupJob = Get-WBJob -ErrorAction SilentlyContinue

	If ($CurrentBackupJob.JobState -eq 'Unknown') {
		Start-WBBackup -Policy (Get-WBPolicy) -Async
		Write-Output "No backup was running. A new backup has been started."
	} 	
	Else {
		Write-Output "A backup is already running. No action taken."
	}
}

Else {Write-Output "No EFI lock error. Check for other issues!"}