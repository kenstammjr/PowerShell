
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$site = New-Object Microsoft.SharePoint.Administration.SPSiteAdministration('https://contoso.com')
$site.ClearMaintenanceMode()