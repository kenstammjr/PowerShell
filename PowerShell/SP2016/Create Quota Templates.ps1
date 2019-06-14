
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Personal - 3 GB"
$newQuotaTemplate.StorageMaximumLevel = (3000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (2000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService = [Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Small - 5 GB"
$newQuotaTemplate.StorageMaximumLevel = (5000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (3000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Medium Small - 10 GB"
$newQuotaTemplate.StorageMaximumLevel = (10000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (8000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Medium - 20 GB"
$newQuotaTemplate.StorageMaximumLevel = (20000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (18000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Medium Large - 40 GB"
$newQuotaTemplate.StorageMaximumLevel = (40000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (35000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Large - 60 GB"
$newQuotaTemplate.StorageMaximumLevel = (60000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (55000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Very Large - 80 GB"
$newQuotaTemplate.StorageMaximumLevel = (80000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (75000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Extremely Large - 100 GB"
$newQuotaTemplate.StorageMaximumLevel = (100000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (95000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()

$newQuotaTemplate = New-Object Microsoft.SharePoint.Administration.SPQuotaTemplate
$newQuotaTemplate.Name = "Crazy Large - 200 GB"
$newQuotaTemplate.StorageMaximumLevel = (200000 * 1024) * 1024 # bytes
$newQuotaTemplate.StorageWarningLevel = (195000 * 1024) * 1024 # bytes
$newQuotaTemplate.UserCodeMaximumLevel = 300
$newQuotaTemplate.UserCodeWarningLevel = 300
$contentService =[Microsoft.SharePoint.Administration.SPWebService]::ContentService
$contentService.QuotaTemplates.Add($newQuotaTemplate)
$contentService.Update()