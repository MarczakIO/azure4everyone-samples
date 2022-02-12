group=azure-load-balancer-introduction
az group create -g $group -l northeurope
username=adminuser
password='SecretPassword123!@#'

az network vnet create \
  -n vm-vnet \
  -g $group \
  -l northeurope \
  --address-prefixes '192.168.0.0/16' \
  --subnet-name subnet \
  --subnet-prefixes '192.168.1.0/24'
  
az vm availability-set create \
  -n vm-as \
  -l northeurope \
  -g $group

for NUM in 1 2 3
do
  az vm create \
    -n vm-eu-0$NUM \
    -g $group \
    -l northeurope \
    --size Standard_B1s \
    --image Win2019Datacenter \
    --admin-username $username \
    --admin-password $password \
    --vnet-name vm-vnet \
    --subnet subnet \
    --public-ip-address "" \
    --availability-set vm-as \
	  --nsg vm-nsg
done

for NUM in 1 2 3
do
  az vm open-port -g $group --name vm-eu-0$NUM --port 80
done

for NUM in 1 2 3
do
  az vm extension set \
    --name CustomScriptExtension \
    --vm-name vm-eu-0$NUM \
    -g $group \
    --publisher Microsoft.Compute \
    --version 1.8 \
    --settings '{"commandToExecute":"powershell Add-WindowsFeature Web-Server; powershell Add-Content -Path \"C:\\inetpub\\wwwroot\\Default.htm\" -Value $($env:computername)"}'
done



