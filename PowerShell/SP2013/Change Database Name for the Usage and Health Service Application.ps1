Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$serviceDbName =  "DatabaseName"
$serviceInstance =  "DatabaseServer"

Get-SPUsageApplication | Set-SPUsageApplication -DatabaseServer $serviceInstance -DatabaseName $serviceDbName
