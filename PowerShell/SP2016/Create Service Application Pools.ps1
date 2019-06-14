
Add-PSSnapin Microsoft.SharePoint.PowerShell -ErrorAction SilentlyContinue

CLS

if ($scriptFolder -eq $null){
		Write-Host "The script folder variable is null.  Run the [Set Script Folder.ps1} file first!"
		break
}
[xml]$file = Get-Content "$($scriptFolder)Properties.xml"

$xmlObjects = $file.SelectNodes("/Property")

foreach($xmlObject in $xmlObjects){
    $lowSvcAppPool =  $xmlObject.LowSvcAppPool
    $lowSvcAppPoolAcct =  $xmlObject.LowSvcAppAccount
    $highSvcAppPool =  $xmlObject.HighSvcAppPool
    $highSvcAppPoolAcct =  $xmlObject.HighSvcAppAccount
}

New-SPServiceApplicationPool -Name $highSvcAppPool -Account $highSvcAppPoolAcct
New-SPServiceApplicationPool -Name $lowSvcAppPool -Account  $lowSvcAppPoolAcct

