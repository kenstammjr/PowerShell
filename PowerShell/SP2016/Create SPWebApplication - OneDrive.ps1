
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){

    $oneDriveWebAppName =  $xmlObject.OneDriveWebAppName
    $oneDriveWebAppPoolName =  $xmlObject.OneDriveWebAppName    
    $oneDriveWebAppPoolAccount =  $xmlObject.OneDriveWebAppPoolAccount
    $contentListener =  $xmlObject.ContentListener
    $defaultSiteOwner =  $xmlObject.DefaultSiteOwner
    $oneDriveWebAppDatabaseName =  $xmlObject.OneDriveWebAppDatabaseName
    $oneDriveWebAppUrl =  $xmlObject.OneDriveWebAppUrl
    $oneDriveWebAppVirtualDirectoryPath =  $xmlObject.VirtualDirectoryPath
}

$appPool = $oneDriveWebAppPoolName
$appPoolAccount = $oneDriveWebAppPoolAccount
$webAppName = $oneDriveWebAppName
$url = $oneDriveWebAppUrl
$port = "443"
$databaseServer = $contentListener
$databaseName = $oneDriveWebAppDatabaseName
$vdPath = $oneDriveWebAppVirtualDirectoryPath
$authProvider = New-SPAuthenticationProvider -DisableKerberos:$false

New-SPWebApplication `
    -Name $webAppName `
    -ApplicationPool $appPool `
    -ApplicationPoolAccount $appPoolAccount `
    -Port $port `
    -DatabaseServer $databaseServer `
    -DatabaseName $databaseName `
    -Url $url `
    -Path $vdPath `
    -AuthenticationProvider $authProvider `
    -HostHeader $webAppName `
    -SecureSocketsLayer