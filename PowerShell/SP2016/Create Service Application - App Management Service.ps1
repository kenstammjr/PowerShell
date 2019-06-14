
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $serviceName =  $xmlObject.AppMgmtSvcName
    $serviceDbName =  $xmlObject.AppMgmtSvcDB
    $serviceInstance =  $xmlObject.ServiceListener
    $appPool =  $xmlObject.HighSvcAppPool
}

$serviceProxy = "$serviceName Proxy"

$appMgmtApp = New-SPAppManagementServiceApplication -ApplicationPool $appPool -DatabaseServer $serviceInstance -DatabaseName $serviceDbName -Name $serviceName 
New-SPAppManagementServiceApplicationProxy -Name $serviceProxy -ServiceApplication $appMgmtApp -UseDefaultProxyGroup $true

