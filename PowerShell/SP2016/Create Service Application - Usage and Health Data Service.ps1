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
    $serviceName =  $xmlObject.UsageSvcName
    $serviceDbName =  $xmlObject.UsageSvcDB
    $serviceInstance =  $xmlObject.ServiceInstance
}

New-SPUsageApplication –Name $serviceName -DatabaseName $serviceDbName -DatabaseServer $serviceInstance
$serviceProxy = Get-SPServiceApplicationProxy | where {$_.TypeName -like “*Usage and Health*”}
$serviceProxy.Provision()

#### UNCLASSIFIED ####