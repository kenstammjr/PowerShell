
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $serviceDbName =  $xmlObject.SessionStateSvcDB
    $serviceInstance =  $xmlObject.ServiceInstance
}

Enable-SPSessionStateService -DatabaseServer $serviceInstance -DatabaseName $serviceDbName 
