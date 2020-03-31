# code 05-web.json
# code 05-main.json

demo=05-web
az group create \
    -n $demo \
    -l northeurope

storage=storage$RANDOM$RANDOM
az storage account create \
    -n $storage \
    -g $demo \
    -l northeurope

container=linkedtemplates
az storage container create \
    -n $container \
    --account-name $storage \
    --auth-mode login

az storage blob upload \
    --account-name $storage \
    --container-name $container \
    --name $demo.json \
    --file $demo.json \
    --auth-mode login

expiretime=$(date -u -d '30 minutes' +%Y-%m-%dT%H:%MZ)
connection=$(az storage account show-connection-string \
  -g $demo \
  --name $storage \
  --query connectionString)
token=$(az storage container generate-sas \
  --name $container \
  --expiry $expiretime \
  --permissions r \
  --output tsv \
  --connection-string $connection)

url=$(az storage blob url \
  --container-name $container \
  --name $demo.json \
  --output tsv \
  --connection-string $connection)

echo LINKED TEMPLATE URL: $url
echo SAS TOKEN: $token

az deployment group create \
    -g $demo \
    --template-file 05-main.json \
    --query "properties.outputs" \
    --output jsonc \
    --parameters templateUri=$url \
    --parameters templateSas=$token
