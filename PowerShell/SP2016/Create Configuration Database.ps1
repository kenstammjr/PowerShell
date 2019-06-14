
Add-PSSnapin Microsoft.SharePoint.Powershell

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $serviceInstance =  $xmlObject.ServiceInstance
    $configDB =  $xmlObject.ConfigDB
    $farmKey =  $xmlObject.FarmKey
    $adminContentDB =  $xmlObject.AdminContentDB
    $farmAccount = $xmlObject.FarmAccount
    $farmPassword = $xmlObject.FarmPassword
}

#$credentials = Get-Credential -Message "Enter SharePoint Farm Account"

$password = ConvertTo-SecureString $farmPassword -AsPlainText -Force
$account = New-Object System.Management.Automation.PSCredential $farmAccount, $password

New-SPConfigurationDatabase -DatabaseName $configDB `
				-DatabaseServer $serviceInstance `
				-AdministrationContentDatabaseName $adminContentDB `
				-Passphrase (ConvertTo-SecureString $farmKey -AsPlainText -Force) `
				-FarmCredentials $account `
				-SkipRegisterAsDistributedCacheHost `
				-LocalServerRole Application