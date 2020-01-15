group=azure-datafactory-selfhosted-ir
rm clouddrive/$group.json
az group delete -g $group
