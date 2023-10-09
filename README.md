# WSBEFILock
Hopefully mitigates the pesky EFI Lock error 0x8078011E that is plagueing Windows Server 2022 where the Backup just fails with the error

  `The backup operation that started at 'XXXX' has failed with following error code '0x8078011E' (Windows Backup failed to get an exclusive lock on the EFI system partition (ESP). This may happen if another application is using files on the ESP. Please retry the operation.). Please review the event details for a solution, and then rerun the backup operation once the issue is resolved. `

# Usage

  ## WSBRecovery.ps1
  For use with remote monitoring Software as a self-healing task attached to a failed Windows Server Backup (Or scheduled. Whatever fits your needs). Make sure to send the output file to your desired notification target

  ## WSBRecovery-logging.ps1
  This is exactly the same script but logs to C:\Temp\WSBRecoverylog.txt. Feel free to change it by adjusting the $LogFile variable.
  
  This script could be attached as a task straight to the event in the Event Viewer but may cause an infinite loop that will probably mess something up. 
  My suggestion here is to schedule the script roughly 30 minutes after your regular scheduled backup. If this tends to fail again just create another instance 30 minutes later. 
