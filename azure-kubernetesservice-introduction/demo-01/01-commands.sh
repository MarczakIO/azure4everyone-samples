az aks get-credentials --resource-group aks-intro --name aks-intro
kubectl get nodes

code azure-vote.yaml
## Create app.yaml 

kubectl apply -f azure-vote.yaml
kubectl get service azure-vote-front --watch