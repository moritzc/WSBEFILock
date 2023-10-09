# WSBEFILock
Hopefully mitigates the pesky EFI Lock error 0x8078011E that is plagueing Windows Server 2022

# Usage

  # WSBRecovery.ps1
  For use with N-Able N-Central as a self-healing task attached to a failed Windows Server Backup. Make sure to send the output file to your desired notification target

  # WSBRecovery-logging.ps1
  This is exactly the same script but logs to C:\Temp\WSBRecoverylog.txt
  This script could be attached as a task straight to the event in the Event Viewer but may cause an infinite loop that will probably mess something up. 
  My suggestion here is to schedule the script roughly 30 minutes after your regular scheduled backup. If this tends to fail again just create another instance 30 minutes later. 
