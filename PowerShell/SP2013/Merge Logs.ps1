Add-PSSnapin microsoft.sharepoint.powershell

Merge-SPLogFile -Path "D:\Logs\FarmMergedLog.log" -Overwrite

Merge-SPLogFile -Path "D:\Logs\FarmMergedLog.log" -Overwrite -Level High

Merge-SPLogFile -Path "D:\Logs\FarmMergedLog.log" -Overwrite -Message "*permission changed*"

Merge-SPLogFile -Path "D:\Logs\FarmMergedLog.log" -Overwrite -Area Search

Merge-SPLogFile -Path "D:\Logs\FarmMergedLog.log" -Overwrite -ContextFilter "user=contoso?joeuser"

Merge-SPLogFile -Path "D:\Logs\FarmMergedLog.log" -Overwrite -StartTime "04/13/20 06:45" -EndTime "04/13/20 06:48"