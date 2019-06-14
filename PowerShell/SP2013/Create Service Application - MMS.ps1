
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$appPool = "LSAPool"
$serviceName = "Managed Metadata Service"
$serviceDbServer = “SQLSvrInstanceName"
$serviceProxy = "$serviceName Proxy"
$serviceDbName = "SP13_MMS"

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