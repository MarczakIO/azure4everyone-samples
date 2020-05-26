group=azure-files-tutorial
name=my-linux-vm
az group create -g $group -l northeurope

az vm create \
    --name $name \
    --resource-group $group \
    --image UbuntuLTS \
    --generate-ssh-keys \
    --admin-username amdemoadmin

az vm show \
  -g $group \
  -n $name \
  -d \
  --query "{name:name,publicIps:publicIps,user:osProfile.adminUsername}" \
  -o jsonc > clouddrive/$name.json

cat clouddrive/$name.json