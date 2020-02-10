git clone https://github.com/Azure-Samples/azure-voting-app-redis.git
cd azure-voting-app-redis
docker-compose up -d
docker images
docker ps
## http://localhost:8080
docker-compose down


$group='aks-intro-demo'
$acr="acr$(Get-Random)"
az group create --name $group --location northeurope
az acr create --resource-group $group --name $acr --sku Basic
az acr login --name $acr
az acr list --resource-group $group --query "[].{acrLoginServer:loginServer}" --output table
docker tag azure-vote-front <acrLoginServer>/azure-vote-front:v1
docker push <acrLoginServer>/azure-vote-front:v1
az acr repository list --name $acr --output table
az acr repository show-tags --name $acr --repository azure-vote-front --output table

az aks install-cli

$aks='aks-demo-01'
az aks update --resource-group $group --name $aks --attach-acr $acr
az aks get-credentials --resource-group $group --name $aks

## Edit azure-vote-all-in-one-redis.yaml

kubectl apply -f azure-vote-all-in-one-redis.yaml
