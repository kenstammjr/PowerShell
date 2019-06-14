
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

<#
Change the service account


When the server farm is first configured, the server farm account is set as the service account of the AppFabric Caching service. 
The Distributed Cache service depends on the AppFabric Caching service. To change the service account of the AppFabric Caching service to a managed account:
Create a managed account. For more information, see Configure automatic password change in SharePoint 2013.
Set the Managed account as the service account on the AppFabric Caching service. At the SharePoint Management Shell command prompt, run the following command:
#>

$farm = Get-SPFarm $cacheService = $farm.Services | where {$_.Name -eq "AppFabricCachingService"} $accnt = Get-SPManagedAccount -Identity domain_name\user_name $cacheService.ProcessIdentity.CurrentIdentityType = "SpecificUser" $cacheService.ProcessIdentity.ManagedAccount = $accnt $cacheService.ProcessIdentity.Update() $cacheService.ProcessIdentity.Deploy()

