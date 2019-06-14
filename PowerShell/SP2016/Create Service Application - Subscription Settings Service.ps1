
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $serviceName =  $xmlObject.SubscriptionSettingsSvcName
    $serviceDbName =  $xmlObject.SubscriptionSettingsSvcDB
    $serviceInstance =  $xmlObject.ServiceInstance
    $appPool =  $xmlObject.HighSvcAppPool
}

$subSettingsApp = New-SPSubscriptionSettingsServiceApplication -Name $serviceName -DatabaseName $serviceDbName –ApplicationPool $appPool
New-SPSubscriptionSettingsServiceApplicationProxy –ServiceApplication $subSettingsApp 

Get-SPServiceInstance | where {$_.TypeName –eq “Microsoft SharePoint Foundation Subscription Settings Service”} | Start-SPServiceInstance

