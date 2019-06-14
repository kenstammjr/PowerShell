
Add-PSSnapin microsoft.sharepoint.powershell

# Configure the SharePoint root certificate as a trusted certificate on every server in the SharePoint farm.  
# This improves performance and prevents one category of untrusted certificate errors.  
# See article https://support.microsoft.com/kb/2625048?wa=wsignin1.0 for more information on why this is done.

$certLocation = "D:\Maintenance\Certificates\SharePointRootAuthority.cer"

$rootCert = (Get-SPCertificateAuthority).RootCertificate
$rootCert.Export("Cert") | Set-Content $certLocation -Encoding byte

function Import-509Certificate {
  param([String]$certPath,[String]$certRootStore,[String]$certStore)
  $pfx = new-object System.Security.Cryptography.X509Certificates.X509Certificate2
  $pfx.import($CertPath)
 
  $store = new-object System.Security.Cryptography.X509Certificates.X509Store($certStore,$certRootStore)
  $store.open(“MaxAllowed”)
  $store.add($pfx)
  $store.close()
}

Import-509Certificate -certPath $CertLocation -certRootStore "LocalMachine" -certStore "Root"
