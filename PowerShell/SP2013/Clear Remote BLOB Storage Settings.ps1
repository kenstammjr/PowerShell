
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue 

$webApps = Get-SPWebApplication 
foreach ($wa in $webApps){ 
	foreach ($cdb in $wa.ContentDatabases){ 
		if ($cdb.RemoteBlobStorageSettings.Installed() -and !$cdb.RemoteBlobStorageSettings.Enabled){
			$cdb.RemoteBlobStorageSettings.Disable() 
			Write-Host "Rbs Disabled on content database $($cdb.Name)" -ForegroundColor Yellow
		} 
	} 
} 
Write-Host "" 
Write-Host "Script Complete." -ForegroundColor Green