Install-Module AzTable

$group = ""
$storageName = ""

$account = Get-AzStorageAccount –Name $storageName -ResourceGroupName $group
$ctx = $account.Context

$tableName = "users"
New-AzStorageTable –Name $tableName –Context $ctx

$cloudTable = (Get-AzStorageTable –Name $tableName –Context $ctx).CloudTable

$partitionKey1 = "partition1"
$partitionKey2 = "partition2"

# add four rows 
Add-AzTableRow `
    -table $cloudTable `
    -partitionKey $partitionKey1 `
    -rowKey ("CA") -property @{"username"="Chris";"userid"=1}

Add-AzTableRow `
    -table $cloudTable `
    -partitionKey $partitionKey2 `
    -rowKey ("NM") -property @{"username"="Jessie";"userid"=2}

Add-AzTableRow `
    -table $cloudTable `
    -partitionKey $partitionKey1 `
    -rowKey ("WA") -property @{"username"="Christine";"userid"=3}

Add-AzTableRow `
    -table $cloudTable `
    -partitionKey $partitionKey2 `
    -rowKey ("TX") -property @{"username"="Steven";"userid"=4}
	
Get-AzTableRow -table $cloudTable | ft

Get-AzTableRow -table $cloudTable -partitionKey $partitionKey1 | ft

Get-AzTableRow -table $cloudTable `
    -columnName "username" `
    -value "Chris" `
    -operator Equal
	
Get-AzTableRow `
    -table $cloudTable `
    -customFilter "(userid eq 1)"
	
	
