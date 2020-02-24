group='arm-04'

az group create -g $group -l northeurope

az group deployment create -g $group --template-file 04-outputs.json --name demo1
az group deployment create -g $group --template-file 04-outputs.json --name demo2

az group deployment list \
    -g $group \
    --query "[].properties.outputs.{
        resourceGroup    : rg.value,
        uniqueStringRG   : uniqueStringRG.value
        deployment       : deployment.value,
        uniqueStringDepl : uniqueStringDeployment.value
    }" \
    -o table