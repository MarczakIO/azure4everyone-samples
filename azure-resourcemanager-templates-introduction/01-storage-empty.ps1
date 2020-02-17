$rg = 'arm-introduction-demo-01'
New-AzResourceGroup -Name $rg -Location northeurope -Force

New-AzResourceGroupDeployment -ResourceGroupName $rg -TemplateFile '01-storage-empty.json' 