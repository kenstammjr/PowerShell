
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){

    $sharedWebAppName =  $xmlObject.SharedWebAppName
    $sharedWebAppPoolName =  $xmlObject.SharedWebAppName    
    $sharedWebAppPoolAccount =  $xmlObject.SharedWebAppPoolAccount
    $contentListener =  $xmlObject.ContentListener
    $defaultSiteOwner =  $xmlObject.DefaultSiteOwner
    $sharedWebAppDatabaseName =  $xmlObject.SharedWebAppDatabaseName
    $sharedWebAppUrl =  $xmlObject.SharedWebAppUrl
    $sharedWebAppVirtualDirectoryPath =  $xmlObject.VirtualDirectoryPath
}

$appPool = $sharedWebAppPoolName
$appPoolAccount = $sharedWebAppPoolAccount
$webAppName = $sharedWebAppName
$url = $sharedWebAppUrl
$port = "443"
$databaseServer = $contentListener
$databaseName = $sharedWebAppDatabaseName
$vdPath = $sharedWebAppVirtualDirectoryPath
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