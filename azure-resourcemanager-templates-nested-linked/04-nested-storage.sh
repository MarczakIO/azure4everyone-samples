# code 04-nested-storage.json

demo=04-nested-storage

az group create \
    -n $demo \
    -l northeurope

az group deployment create \
    -g $demo \
    --template-file $demo.json \
    --query "properties.outputs" \
    --output jsonc