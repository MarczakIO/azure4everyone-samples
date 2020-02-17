$rg = 'arm-introduction-02'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment -ResourceGroupName $rg `
    -TemplateFile '.\02-storage-param-name.json' `
    -StorageName 'amdemostorageintro02'