$rg = 'arm-introduction-03'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment -ResourceGroupName $rg `
    -TemplateFile '.\03-storage-param-sku.json' `
    -TemplateParameterFile '.\03-storage-param-sku.parameters.json' 