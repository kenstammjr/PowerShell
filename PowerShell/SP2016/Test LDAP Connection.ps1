CLS

$serverName + "SP16_SEARCHSVR_01"
$port = 389
$userName = "CONTOSO\sp16.ups.svc" 
$password = 'P@ssw0rd' 

#Load the assemblies 
[System.Reflection.Assembly]::LoadWithPartialName("System.DirectoryServices.Protocols") 
[System.Reflection.Assembly]::LoadWithPartialName("System.Net") 
 
#Connects to Server on the standard port 
$dn = "$serverName"+":"+"$port" 
$c = New-Object System.DirectoryServices.Protocols.LdapConnection "$dn" 
$c.SessionOptions.SecureSocketLayer = $false; 
$c.SessionOptions.ProtocolVersion = 3 

# Pick Authentication type: 
# Anonymous, Basic, Digest, DPA (Distributed Password Authentication), 
# External, Kerberos, Msn, Negotiate, Ntlm, Sicily 
$c.AuthType = [System.DirectoryServices.Protocols.AuthType]::Ntlm
 
#$credentials = Get-Credential -Message "Enter SharePoint UPS Account"
$credentials = new-object "System.Net.NetworkCredential" -ArgumentList $userName, (ConvertTo-SecureString $password -AsPlainText -Force) 
 
# Bind with the network credentials. Depending on the type of server, 
# the username will take different forms. Authentication type is controlled 
# above with the AuthType 
Try { 
 
    $c.Bind($credentials); 
    Write-Verbose "Successfully bound to LDAP!" -Verbose 
    return $true 
} catch { 
    Write-host $_.Exception.Message 
    return $false 
} 