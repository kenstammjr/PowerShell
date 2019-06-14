
Add-PSSnapin microsoft.sharepoint.powershell

$site = Get-SPSite https://onedrive.contoso.com
$serviceContext = Get-SPServiceContext -Site $site
$userProfileConfigManager = New-Object Microsoft.Office.SharePoint.UserProfiles.UserProfileManager($serviceContext)
$user = $userProfileConfigManager.GetUserProfile("CONTOSO\joe.user")
$user.PersonalSiteInstantiationState
$user.CreatePersonalSite()

