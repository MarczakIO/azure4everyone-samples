$rg = 'arm-introduction-demo-02'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment -ResourceGroupName $rg `
    -TemplateFile '.\02-storage-with-params.json' `
    -TemplateParameterFile '.\02-storage-with-params.parameters.json'