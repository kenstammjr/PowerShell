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
    $serviceName =  $xmlObject.UpsSvcName
    $profileDbName = $xmlObject.UpsProfileDB
    $socialDbName = $xmlObject.UpsSocialDB
    $syncDbName = $xmlObject.UpsSyncDB
    $serviceInstance =  $xmlObject.ServiceInstance
    $serviceListener = $xmlObject.ServiceListener
    $mySiteUrl = $xmlObject.MySiteUrl
    $appPool =  $xmlObject.HighSvcAppPool
}

$serviceProxy = "$serviceName Proxy"

$upsSvc = New-SPProfileServiceApplication -ApplicationPool $appPool `
                                            -Name $serviceName `
                                            -ProfileDBName $profileDbName `
                                            -ProfileDBServer $serviceListener `
                                            -SocialDBName $socialDbName `
                                            -SocialDBServer $serviceListener `
                                            -ProfileSyncDBName  $syncDbName `
                                            -ProfileSyncDBServer $serviceInstance 

New-SPProfileserviceApplicationProxy -ServiceApplication $upsSvc -Name $serviceProxy –DefaultProxyGroup

#### UNCLASSIFIED ####