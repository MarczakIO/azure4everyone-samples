Connect-AzAccount

Get-AzContext

Select-AzSubscription
Select-AzSubscription -Subscription "Visual Studio Enterprise – MPN"

Get-AzResourceGroup

Get-Help Get-AzResourceGroup

Get-AzResourceGroup | Format-List
Get-AzResourceGroup | Format-Table
Get-AzResourceGroup | Format-Wide

Get-AzResourceGroup | Out-GridView
Get-AzResourceGroup | Export-Csv

Get-AzResourceGroup | Select ResourceGroupName, Location

Get-AzResourceGroup | Where-Object { $_.Location -eq "westeurope" }

Get-AzResourceGroup | `
    Where-Object { $_.Location -eq "westeurope" } | `
    Select ResourceGroupName
	
New-AzResourceGroup -Name amdemo -Location 'North Europe'

