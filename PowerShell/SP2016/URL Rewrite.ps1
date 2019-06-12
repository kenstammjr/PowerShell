#### UNCLASSIFIED ####

Set-SPSite (Get-SPSite 'http://contoso.com') -URL 'https://contoso.com' 

$site = Get-SPSite 'https://contos.com'
$uri = New-Object System.Uri("https://contoso.com")
$site.Rename($uri)
((Get-SPSite https://contoso.com).ContentDatabase).RefreshSitesInConfigurationDatabase()

$site.GetUrls()
$site.RemoveUrl($uri)
$site.ContentDatabase

#### UNCLASSIFIED ####

