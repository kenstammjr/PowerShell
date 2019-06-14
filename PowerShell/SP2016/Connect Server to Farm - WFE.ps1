
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
}
Connect-SPConfigurationDatabase -DatabaseName $configDB `
				-DatabaseServer $serviceInstance `
				-Passphrase (ConvertTo-SecureString $farmKey -AsPlainText -Force) `
				-LocalServerRole WebFrontEndWithDistributedCache

