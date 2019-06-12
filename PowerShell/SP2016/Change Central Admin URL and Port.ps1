
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

Get-SPGet-SPWebApplication -IncludeCentralAdministration

Set-SPCentralAdministration -Port 443

Set-SPAlternateURL -Identity "https://sps" -Url "https://spca.contoso.com"


Import-Module WebAdministration 

# Name of Web Site in IIS we want to modify the bindings for 
$iisSiteName = "SharePoint Central Administration v4" 
 
# Host header 
$iisHostHeader = "spca.contoso.com" 
 
# Friendly Name of certificate 
$certName = $iisHostHeader 

# Remove the existing binding as we cannot update SSLFlags for an existing binging via PoSH 
Get-WebBinding -Name $iisSiteName | Remove-WebBinding 

# Create new binding with correct SSLFlags, 1 == SNI 
New-WebBinding -Name $iisSiteName -HostHeader $iisHostHeader -Protocol "https" -Port 443 -SslFlags 1 

# Grab the Certificate 
$cert = Get-ChildItem -Path "Cert:\LocalMachine\My" | where-Object {$_.FriendlyName -like $certName} 
 
# Update the binding with the certificate 
$cert | New-Item -Path "IIS:\SslBindings\!443!$iisHostHeader" 


