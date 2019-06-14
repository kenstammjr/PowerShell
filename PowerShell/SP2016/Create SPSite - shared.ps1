
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
	$siteUrl = $xmlObject.SharedWebAppUrl
	$siteName = $xmlObject.SharedWebAppName
	$siteDescription = $xmlObject.SharedWebAppUrl
	$databaseServer = $xmlObject.ContentListener
	$databaseName = $xmlObject.SharedWebAppDatabaseName
	$siteOwner = $xmlObject.DefaultSiteOwner
	$webAppName = $xmlObject.SharedWebAppName
}

$webApp = Get-SPWebApplication -Identity $webAppName

New-SPContentDatabase -Name $databaseName -DatabaseServer $databaseServer -WebApplication $webApp -ErrorAction SilentlyContinue

New-SPSite `
    -Name $siteName `
    -Description $siteDescription `
    -Url $siteUrl `
    -HostHeaderWebApplication $webApp `
    -OwnerAlias $siteOwner `
    -ContentDatabase $databaseName `
	-Template STS#0