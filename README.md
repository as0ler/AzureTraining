# AzureTraining
Materials for the Azure Training

Include Materials needed to deploy resources in Azure. 


```
az policy definition create --name 'storage-account-blob-encryption' --display-name 'Ensure storage blob encryption' --description 'Ensures blob encryption for storage accounts' --rules 'https://raw.githubusercontent.com/as0ler/AzureTraining/master/azurepolicy/azurepolicy_encryption.rules.json' --params 'https://raw.githubusercontent.com/as0ler/AzureTraining/master/azurepolicy/azurepolicy_encryption.parameteres.json' --mode All
```


```
az policy assignment create --name ”Blob Encryption --scope “/subscriptions/<subscriptionid>” --policy "storage-account-blob-encryption"
```
