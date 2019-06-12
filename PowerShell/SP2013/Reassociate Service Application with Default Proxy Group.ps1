#
# Reassociate_Servive_Application_with_Default_Proxy_Group.ps1
#

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

Get-SPServiceApplicationProxy | % {Add-SPServiceApplicationProxyGroupMember (Get-SPServiceApplicationProxyGroup -Default) -Member $_}
