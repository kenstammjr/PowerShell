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

    $highSvcAppAccount =  $xmlObject.HighSvcAppAccount
    $lowSvcAppAccount =  $xmlObject.LowSvcAppAccount
    $searchSvcAppAccount =  $xmlObject.SearchSvcAppAccount
    $SearchSvcCrawlAccount =  $xmlObject.SearchSvcCrawlAccount
    $sharedWebAppPoolAccount =  $xmlObject.SharedWebAppPoolAccount
    $oneDriveWebAppPoolAccount =  $xmlObject.OneDriveWebAppPoolAccount

    $highSvcAppAccountPassword =  $xmlObject.HighSvcAppAccountPassword
    $lowSvcAppAccountPassword =  $xmlObject.LowSvcAppAccountPassword
    $searchSvcAppAccountPassword =  $xmlObject.SearchSvcAppAccountPassword
    $searchSvcCrawlAccountPassword =  $xmlObject.SearchSvcCrawlAccountPassword
    $sharedWebAppPoolAccountPassword =  $xmlObject.SharedWebAppPoolAccountPassword
    $oneDriveWebAppPoolAccountPassword =  $xmlObject.OneDriveWebAppPoolAccountPassword
}

# Add High Service App Account
$password = ConvertTo-SecureString $highSvcAppAccountPassword -AsPlainText -Force
$account = New-Object system.management.automation.pscredential $highSvcAppAccount, $password
New-SPManagedAccount $account

# Add Low Service App Account
$password = ConvertTo-SecureString $lowSvcAppAccountPassword -AsPlainText -Force
$account = New-Object system.management.automation.pscredential $lowSvcAppAccount, $password
New-SPManagedAccount $account

# Add Search Service App Account
$password = ConvertTo-SecureString $searchSvcAppAccountPassword -AsPlainText -Force
$account = New-Object system.management.automation.pscredential $searchSvcAppAccount, $password
New-SPManagedAccount $account

# Add Search Service Crawler Account
$password = ConvertTo-SecureString $searchSvcCrawlAccountPassword -AsPlainText -Force
$account = New-Object system.management.automation.pscredential $SearchSvcCrawlAccount, $password
New-SPManagedAccount $account

# Add Shared Web App Pool Account
$password = ConvertTo-SecureString $sharedWebAppPoolAccountPassword -AsPlainText -Force
$account = New-Object system.management.automation.pscredential $sharedWebAppPoolAccount $password
New-SPManagedAccount $account

# Add One Drive Web App Pool Account
$password = ConvertTo-SecureString $oneDriveWebAppPoolAccountPassword -AsPlainText -Force
$account = New-Object system.management.automation.pscredential $oneDriveWebAppPoolAccount $password
New-SPManagedAccount $account

#### UNCLASSIFIED #### 