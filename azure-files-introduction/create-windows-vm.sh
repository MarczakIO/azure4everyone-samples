group=azure-files-tutorial
name=my-windows-vm
az group create -g $group -l northeurope
password=Adm1nPasSword$RANDOM

az vm create \
  -n $name \
  -g $group \
  -l eastus2 \
  --image Win2019Datacenter \
  --admin-username amdemoadmin \
  --admin-password $password \
  --nsg-rule rdp

az vm show \
  -g $group \
  -n $name \
  -d \
  --query "{name:name,publicIps:publicIps,user:osProfile.adminUsername,password:'$password'}" \
  -o jsonc > clouddrive/$name.json

cat clouddrive/$name.json