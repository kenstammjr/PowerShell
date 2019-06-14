
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

# 1. To check the existing memory allocation for the Distributed Cache service on a server, 
#    run the following command at the SharePoint Management Shell command prompt

Use-CacheCluster Get-AFCacheHostConfiguration -ComputerName $env:COMPUTERNAME -CachePort "22233" 

# 2. Stop the Distributed Cache service on all cache hosts. To stop the Distributed Cache service, go to Services on Server in Central Administration, and Stop the Distributed Cache service on all cache hosts in the farm.
# 3. To reconfigure the cache size of the Distributed Cache service, run the following command one time only on any cache host at the SharePoint Management Shell command prompt:

Update-SPDistributedCacheSize -CacheSizeInMB CacheSize 