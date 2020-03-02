echo "" > 02-storage.json
echo "" > 02-storage.parameters.json

# replace files with code before running the rest

group='arm-parameter-files'

az group create -g $group -l northeurope

az group deployment create \
    -g $group \
    --template-file 02-storage.json \
    --parameters @02-storage.parameters.json

az group deployment create \
    -g $group \
    --template-file 02-storage.json \
    --parameters @02-storage.parameters.json \
    --parameters storageAccountSKU=Standard_GRS
    