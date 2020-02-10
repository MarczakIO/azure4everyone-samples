group=my-vm
az group create -g $group -l northeurope
username=adminuser
password='SecretPassword'$RANDOM
az vm create \
  -n vm-win10pro \
  -g $group \
  -l northeurope \
  --image MicrosoftWindowsDesktop:Windows-10:rs5-pro:latest \
  --admin-username $username \
  --admin-password $password \
  --size Standard_DS2_v2 \
  --nsg-rule rdp

az vm list \
  -g $group -d \
  --query "[].{name:name,ip:publicIps,user:osProfile.adminUsername,password:'$password'}" \
  -o jsonc > vm.json

cat vm.json