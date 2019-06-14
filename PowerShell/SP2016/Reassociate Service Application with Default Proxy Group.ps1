
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

Get-SPServiceApplicationProxy | % {Add-SPServiceApplicationProxyGroupMember (Get-SPServiceApplicationProxyGroup -Default) -Member $_}
