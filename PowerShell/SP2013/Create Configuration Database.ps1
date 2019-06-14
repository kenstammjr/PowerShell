
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction Ignore

# Database Server Name
$dbServer = “SQLSvrInstanceName"

# Configuration Database Name
$configDB = "SP13_ConfigDB"

# Farm Encryption Key (SharePoint enforces a minimum key complexity)
$passPhrase = "C0nToS0sPF@rm!"

# Connect the local server to the specified SharePoint Farm
Connect-SPConfigurationDatabase -DatabaseServer $dbServer `
    -DatabaseName $configDB `
    -Passphrase (ConvertTo-SecureString $passPhrase –AsPlaintext –Force) `
    –SkipRegisterAsDistributedCacheHost