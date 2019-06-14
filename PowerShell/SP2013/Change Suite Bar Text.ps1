
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$webApp = Get-SPWebApplication "https://contoso.com"
$webApp.SuiteBarBrandingElementHtml = '<span style="margin-left:19px">CONTOSO</span>'
$webApp.Update()