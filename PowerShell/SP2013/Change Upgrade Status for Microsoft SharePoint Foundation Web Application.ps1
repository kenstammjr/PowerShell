
Add-PSSnapin Microsoft.SharePoint.PowerShell

$webappsvc = Get-SPServiceInstance -server $env:COMPUTERNAME | ? { $_.TypeName -eq "Microsoft SharePoint Foundation Web Application" }
$instance = Get-SPServiceInstance $webappsvc.Id
Write-Output "Status = $($instance.status)"
Write-Output "NeedsUpgrade = $($instance.needsupgrade)"
if ($instance.needsupgrade){
    $instance.NeedsUpgrade = $false
    Write-Output "NeedsUpgrade = $($instance.needsupgrade)"
}