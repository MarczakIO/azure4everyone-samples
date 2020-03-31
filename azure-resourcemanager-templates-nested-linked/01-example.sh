# code 01-example.json

demo=01-example
az group create \
    -n $demo \
    -l northeurope
az deployment group create \
    -g $demo \
    --template-file $demo.json \
    --query "properties.outputs" \
    --output jsonc