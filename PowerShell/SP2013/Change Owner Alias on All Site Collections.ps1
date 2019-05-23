Add-PSSnapin Microsoft.SharePoint.PowerShell -erroraction SilentlyContinue

foreach ($webApp in Get-SPWebApplication) {
    foreach ($site in $webApp.Sites) {
        Set-SPSite -Identity $site.Url -OwnerAlias "i:0#.w|CONTOSO\john.doe"
        Write-Host $site.Url
    }
}
