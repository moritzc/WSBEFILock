$StartTime = (Get-Date).AddHours(-12)
$EndTime = Get-Date
$LogName = 'Microsoft-Windows-Backup'
$EventID = 5
$Keyword = '0x8078011E'
$LogFile = "C:\Temp\WSBRecoverylog.txt"

Function WriteLog ($Message) {
    $Timestamp = (Get-Date).ToString("dd-MM-yyyy HH:mm:ss")
    $LogMessage = "$Timestamp - $Message"
    Add-Content -Path $LogFile -Value $LogMessage
}

$Events = Get-WinEvent -FilterHashtable @{
    LogName = $LogName
    ID = $EventID
    StartTime = $StartTime
    EndTime = $EndTime
} -ErrorAction SilentlyContinue | Where-Object { $_.Message -match $Keyword }

If ($Events.Count -ge 1) {
    $Message = "Backup failed with EFI lock error"
    WriteLog $Message
    
    $CurrentBackupJob = Get-WBJob -ErrorAction SilentlyContinue

    If ($CurrentBackupJob.JobState -eq 'Unknown') {
        Start-WBBackup -Policy (Get-WBPolicy) -Async
        $Message = "No backup was running. A new backup has been started."
        WriteLog $Message
    }     
    Else {
        $Message = "A backup is already running. No action taken."
        WriteLog $Message
    }
}
Else {
    $Message = "No EFI lock error. Check for other issues!"
    WriteLog $Message
}
