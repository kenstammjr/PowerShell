
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue


CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $serviceName =  $xmlObject.SecureStoreSvcName
    $serviceDbName =  $xmlObject.SecureStoreSvcDB
    $serviceInstance =  $xmlObject.ServiceListener
    $appPool =  $xmlObject.HighSvcAppPool
}

$serviceProxy = "$serviceName Proxy"
# $passPhrase = "!@QWASZX12qwaszx"

$secureStoreApp      = New-SPSecureStoreServiceApplication -ApplicationPool $appPool -DatabaseServer $serviceDbServer -DatabaseName $serviceDbName -Name $serviceName -AuditingEnabled:$false
$secureStoreAppProxy = New-SPSecureStoreServiceApplicationProxy -Name $serviceProxy -ServiceApplication $secureStoreApp -DefaultProxyGroup
# Update-SPSecureStoreMasterKey -ServiceApplicationProxy $secureStoreAppProxy -PassPhrase (ConvertTo-SecureString $passPhrase -AsPlainText -Force) 