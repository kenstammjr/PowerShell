Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

# Prompt for credentials and generate managed accounts
while(1) { 
    try {  
            # Prompt for the credentials 
            $credentials = Get-Credential -Message "Input Managed Account credentials.  
            Select `“Cancel`” when finished." 
            # Create the Managed Account. 
            New-SPManagedAccount -credential $credentials 
            "Adding Account...” | Write-Host 
            # Configure Managed Account Object.  This section is included for  
            $managedaccount = Get-SPManagedAccount -Identity $credentials.UserName 
            $managedaccount.AutomaticChange = $false 
            $managedaccount.Update() 
        } catch { 
            # Display the managed accounts in SharePoint 
            "SP Managed Accounts” | Write-Host 
            Get-SPManagedAccount | Out-Host 
            # End While 
            break 
        } 
} 