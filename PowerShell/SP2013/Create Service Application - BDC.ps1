
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$appPool = "LSAPool"
$serviceName = "Business Data Connectivity Service"
$serviceDbServer = “SQLSvrInstanceName"
$serviceProxy = "$serviceName Proxy"
$serviceDbName = "SP13_BDC"

$bdc = New-SPBusinessDataCatalogServiceApplication –ApplicationPool $appPool –DatabaseName $serviceDbName –DatabaseServer $serviceDbServer –Name $serviceName 