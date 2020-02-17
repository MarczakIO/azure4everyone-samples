$rg = 'arm-introduction-04'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment -ResourceGroupName $rg `
    -TemplateFile '.\04-storage-function.json' `
    -TemplateParameterFile '.\04-storage-function.parameters.json' 