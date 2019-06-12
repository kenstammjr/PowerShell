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
    $serviceName =  $xmlObject.MmsSvcName
    $serviceDbName =  $xmlObject.MmsSvcDB
    $serviceInstance =  $xmlObject.ServiceListener
    $appPool =  $xmlObject.LowSvcAppPool
}

$serviceProxy = "$serviceName Proxy"

New-SPMetadataServiceApplication -Name $serviceName `
    -DatabaseServer $serviceDbServer `
    -DatabaseName $serviceDbName `
    -ApplicationPool $appPool 

New-SPMetadataServiceApplicationProxy -Name $serviceProxy `
    -ServiceApplication $serviceName `
    -DefaultProxyGroup

Set-SPMetadataServiceApplicationProxy -Identity $serviceProxy `
    -DefaultSiteCollectionTaxonomy:$true `
    -DefaultKeywordTaxonomy:$true `
    -ContentTypePushdownEnabled:$true 

#### UNCLASSIFIED ####