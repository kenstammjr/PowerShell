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
    $searchAppName =  $xmlObject.SearchSvcName
    $dbName =  $xmlObject.SearchSvcDB
    $dbServer =  $xmlObject.SearchInstance
    $indexLocation = $xmlObject.SearchIndexLocation
    $searchAppPoolName =  $xmlObject.SearchSvcAppPool
    $searchAppPoolAccount =  $xmlObject.SearchSvcAppAccount
    $searchCrawlers =  $xmlObject.SearchCrawlers
    $searchIndexers =  $xmlObject.SearchIndexers
    $lsaPool = $xmlObject.LowSvcAppPool
}

$crawlers = $searchCrawlers.Split("{,}")
$indexers = $searchIndexers.Split("{,}")

$crawlAccount = Get-Credential -Message "Default Content Access Account Credentials (SOCRS\ent-pcca-svc)"

#$password = ConvertTo-SecureString $farmPassword -AsPlainText -Force
#$account = New-Object System.Management.Automation.PSCredential $farmAccount, $password

$searchProxy = "$searchAppName Proxy"
$adminAppPool = Get-SPServiceApplicationPool -Identity $lsaPool
$SearchProxy = "$searchAppName Proxy"

# Create Search Application Pool
New-SPServiceApplicationPool -Name $searchAppPoolName -Account $searchAppPoolAccount -ErrorAction SilentlyContinue
$appPool = Get-SPServiceApplicationPool -Identity $searchAppPoolName

# Start the Search Service Instances on each of the Search Servers
foreach($serverName in $crawlers){
    Start-SPEnterpriseSearchServiceInstance -Identity $serverName
    Start-SPEnterpriseSearchQueryAndSiteSettingsServiceInstance -Identity $serverName
}
foreach($serverName in $indexers){
    Start-SPEnterpriseSearchServiceInstance -Identity $serverName
    Start-SPEnterpriseSearchQueryAndSiteSettingsServiceInstance -Identity $serverName
}

# Wait for Services to Provision
while(Get-SPEnterpriseSearchServiceInstance | ?{$_.status -eq "Provisioning"}){
    Start-Sleep 2
}

# Confirm that Everything Provisioned Correctly
foreach($serverName in $crawlers){
    if(!((Get-SPEnterpriseSearchServiceInstance -Identity $serverName).status -eq "Online")){
        throw("The Search Instance on $serverName failed to Provision. Run Get-SPEnterpriseSearchServiceInstance to View the Status of all Search Service Instances")
    }
}
# Confirm that Everything Provisioned Correctly
foreach($serverName in $indexers){
    if(!((Get-SPEnterpriseSearchServiceInstance -Identity $serverName).status -eq "Online")){
        throw("The Search Instance on $serverName failed to Provision. Run Get-SPEnterpriseSearchServiceInstance to View the Status of all Search Service Instances")
    }
}

# Create Search Service Application and Application Proxy
New-SPEnterpriseSearchServiceApplication -Name $searchAppName -ApplicationPool $searchAppPoolName -DatabaseName $dbName -DatabaseServer $dbServer -AdminApplicationPool $adminAppPool
Start-Sleep 10
New-SPEnterpriseSearchServiceApplicationProxy -Partitioned -Name $searchProxy -SearchApplication $searchAppName
Start-Sleep 10
Set-SPEnterpriseSearchServiceApplication -Identity $searchAppName -DefaultContentAccessAccountName $crawlAccount.UserName -DefaultContentAccessAccountPassword $crawlAccount.Password
$searchServiceApp = Get-SPEnterpriseSearchServiceApplication -Identity $searchAppName


Get-SPEnterpriseSearchServiceApplicationProxy
#Get-SPEnterpriseSearchTopology -SearchApplication $searchServiceApp
#Get-SPEnterpriseSearchServiceInstance -Identity $serverName

# Create the Topology Object
$newTopology = New-SPEnterpriseSearchTopology -SearchApplication $searchServiceApp

# Define Search Topology
foreach($serverName in $crawlers){
    $serverInstance = Get-SPEnterpriseSearchServiceInstance -Identity $serverName
    New-SPEnterpriseSearchCrawlComponent -SearchTopology $newTopology -SearchServiceInstance $serverInstance
    New-SPEnterpriseSearchContentProcessingComponent -SearchTopology $newTopology -SearchServiceInstance $serverInstance
    New-SPEnterpriseSearchAdminComponent -SearchTopology $newTopology -SearchServiceInstance $serverInstance
    New-SPEnterpriseSearchAnalyticsProcessingComponent -SearchTopology $newTopology -SearchServiceInstance $serverInstance
}

foreach($serverName in $indexers){
    $serverInstance = Get-SPEnterpriseSearchServiceInstance -Identity $serverName
    New-SPEnterpriseSearchIndexComponent -SearchTopology $newTopology -SearchServiceInstance $serverInstance -RootDirectory $indexLocation -IndexPartition 0
    New-SPEnterpriseSearchQueryProcessingComponent -SearchTopology $newTopology -SearchServiceInstance $serverInstance
}


# Set the Topology
Start-Sleep 2
Set-SPEnterpriseSearchTopology -Identity $newTopology
Get-SPEnterpriseSearchTopology -SearchApplication $searchServiceApp


#### UNCLASSIFIED ####