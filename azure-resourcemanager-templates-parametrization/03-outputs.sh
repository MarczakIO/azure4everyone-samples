group='arm-03'

az group create -g $group -l northeurope

az group deployment create -g $group --template-file 03-outputs.json