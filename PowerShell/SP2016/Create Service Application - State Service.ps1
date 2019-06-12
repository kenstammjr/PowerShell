#### UNCLASSIFIED ####

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $serviceName =  $xmlObject.StateSvcName
    $serviceDbName =  $xmlObject.StateSvcDB
    $serviceInstance =  $xmlObject.ServiceInstance
    $appPool =  $xmlObject.HighSvcAppPool
}

$serviceProxy = "$serviceName Proxy"

New-SPStateServiceDatabase -Name $serviceDbName -DatabaseServer $serviceDbServer
$stateSvcApp = New-SPStateServiceApplication -Name $serviceName -Database $serviceDbName  
New-SPStateServiceApplicationProxy -Name $serviceProxy -ServiceApplication $stateSvcApp -DefaultProxyGroup

#### UNCLASSIFIED ####