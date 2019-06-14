
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$wa = Get-SPWebApplication
# If using custom claims
#	$superUser = "i:05.t|samlprovider|superUser@contoso.com" # email address on super user account "sp-superUser-svc"
#	$superReader = "i:05.t|samlprovider|superReader@contoso.com" # email address on super reader account "sp-superReader-svc"
# else if using windows claims
	$superUser = "i:0#.w|CONTOSO\sp13.superuser.svc"
	$superReader = "i:0#.w|CONTOSO\sp13.superreader.svcsvc"

foreach($a in $wa){
    $a.Properties["portalsuperuseraccount"] = $superUser
    $a.Properties["portalsuperreaderaccount"] = $superReader

    $zonepolicies = $a.ZonePolicies("Default")

    $fullPolicy = $zonepolicies.Add($superUser, "Super User")
    $readPolicy = $zonepolicies.Add($superReader, "Super Reader")

    $fullControl = $a.PolicyRoles.GetSpecialRole("FullControl")
    $fullRead = $a.PolicyRoles.GetSpecialRole("FullRead")

    $fullPolicy.PolicyRoleBindings.Add($fullControl)
    $readPolicy.PolicyRoleBindings.Add($fullRead)

    $a.Update()
}