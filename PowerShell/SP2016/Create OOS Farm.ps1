
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

New-OfficeWebAppsFarm `
     -InternalUrl "https://oos.contoso.com" `
     -ExternalUrl "https://oos.contoso.com" `
     -SSLOffload `
     -EditingEnabled `
     -CertificateName "oos.contoso.com"

New-OfficeWebAppsMachine -MachineToJoin "https://contoso.com"

Get-OfficeWebAppsFarm > C:\farmspecs.txt

# Remove-OfficeWebAppsMachine

# connect SharePoint to OOS farm
 
New-SPWOPIBinding -ServerName "oos.contoso.com" -AllowHTTP
Set-SPWOPIZone -Zone "external-https"
Remove-SPWOPIBinding -All

# Verify that the farm was created successfully. Browse to the OOS FQDN on any OOS server
https://oos.contoso.com/hosting/discovery

## If receiving an error, confirm this is being run from an OOS server

(Get-OfficeWebAppsFarm).Machines  ## Gives server names, roles and health status of OOS farm
Get-OfficeWebAppsMachine

$farm = Get-OfficeWebAppsFarm 
$farm.CertificateName 


## update certificate - run one one server in OOS farm
Set-OfficeWebAppsFarm -CertificateName "oos.contoso.com"


## Add HTTP Activation for .NET Framework 4.5 WCF Services (needs to be done on each OOS server)
Import-Module ServerManager
Add-WindowsFeature NET-WCF-HTTP-Activation45

## restart the OOS servers for the cert name change to take effect.
## after restart, confirm in IIS the proper certificate is bound to the HTTPS web site

# Default ULS log file location
# C:\ProgramData\Microsoft\OfficeWebApps\Data\Logs\ULS

# To get OWA version
# (Invoke-WebRequest http://oos.contoso.com/m/met/participant.svc/jsonannonymous/broadcastping).Headers["X-OfficeVersion"]

$Farm = Get-SPFarm
$Farm.Properties.Add("WopiLegacySoapSupport", "<URL>/x/_vti_bin/ExcelServiceInternal.asmx");
$Farm.Update(); 

Add-WindowsFeature Web-Server,Web-Mgmt-Tools,Web-Mgmt-Console,Web-WebServer,Web-Common-Http,Web-Default-Doc,Web-Static-Content,Web-Performance,Web-Stat-Compression,Web-Dyn-Compression,Web-Security,Web-Filtering,Web-Windows-Auth,Web-App-Dev,Web-Net-Ext45,Web-Asp-Net45,Web-ISAPI-Ext,Web-ISAPI-Filter,Web-Includes,NET-Framework-Features,NET-Framework-45-Features,NET-Framework-Core,NET-Framework-45-Core,NET-HTTP-Activation,NET-Non-HTTP-Activ,NET-WCF-HTTP-Activation45,Windows-Identity-Foundation,Server-Media-Foundation