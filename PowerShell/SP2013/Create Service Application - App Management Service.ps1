
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$appPool = "HSAPool"
$serviceName = "App Management Service"
$serviceDbServer = “SQLSvrInstanceName"
$serviceProxy = "$serviceName Proxy"
$serviceDbName = "SP13_AppManagementService"

$appMgmtApp = New-SPAppManagementServiceApplication -ApplicationPool $appPool -DatabaseServer $serviceDbServer -DatabaseName $serviceDbName -Name $serviceName 
New-SPAppManagementServiceApplicationProxy -Name $serviceProxy -ServiceApplication $appMgmtApp 