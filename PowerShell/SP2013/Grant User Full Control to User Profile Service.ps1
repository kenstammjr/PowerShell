Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$user = "CONTOSO\john.doe"

$ups = Get-SPServiceApplication | ? { $_.Name -eq "User Profile Service" }
$principal = New-SPClaimsPrincipal $user  -IdentityType WindowsSamAccountName
$servApp = Get-SPServiceApplication -Identity $ups.Id
$security = Get-SPServiceApplicationSecurity $servApp -Admin
Grant-SPObjectSecurity $security $principal "Full Control"
Set-SPServiceApplicationSecurity $servApp $security -Admin
(Get-SPServiceApplicationSecurity $servApp -Admin).AccessRules