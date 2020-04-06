#create VM

az account list

az group create --location westus --name MyRG

az vm create -n myVM -g MyRG --image UbuntuLTS --generate-ssh-keys

ssh username@ipaddress

exit

az group delete --name MyRG --no-wait

# token

response=$(curl http://localhost:50342/oauth2/token --data "resource=https://management.azure.com/" -H Metadata:true -s)
access_token=$(echo $response | python -c 'import sys, json; print (json.load(sys.stdin)["access_token"])')
echo The access token is $access_token

# call api

az rest --uri https://graph.microsoft.com/v1.0/me/