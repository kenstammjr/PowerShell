#### UNCLASSIFIED ####

Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $superUser =  $xmlObject.SuperUserAccount
    $superReader =  $xmlObject.SuperReaderAccount
}

$wa = Get-SPWebApplication

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

#### UNCLASSIFIED ####