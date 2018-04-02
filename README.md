# AzureTraining
Materials for the Azure Training

Include Materials needed to deploy resources in Azure. 

## Azure Policies

* Step 1: Define a policy to restrict the region where resources are deployed. 
1. Navigate to Azure Policy.
2. Go to Assignments blade.
3. Select Assign Policy.
4. Configure the policy "Allowed Locations". Apply the policy to only a specific resource group. 
5. Try the policy.

* Step 2: Define a Custom Policy.

  * Execute the command above in a Cloud shell.
```
az policy definition create --name 'storage-account-blob-encryption' --display-name 'Ensure storage blob encryption' --description 'Ensures blob encryption for storage accounts' --rules 'https://raw.githubusercontent.com/as0ler/AzureTraining/master/azurepolicy/azurepolicy_encryption.rules.json' --params 'https://raw.githubusercontent.com/as0ler/AzureTraining/master/azurepolicy/azurepolicy_encryption.parameteres.json' --mode All
```

  * Create the assignment
```
az policy assignment create --name "Blob Encryption" --scope "/subscriptions/<subscription id>" --policy "storage-account-blob-encryption”
```

* Step 3: Create a custom policy to permit only a deploy in a specific subnet.

  * Reference:  https://docs.microsoft.com/en-us/azure/virtual-network/resource-groups-networking
  * Type: Microsoft.Network/networkInterfaces
  * field: Microsoft.Network/networkInterfaces/ipconfigurations[\*].subnet.id

azurepolicy.template.json
```
{
	"if": {
		"allOf": [
			{
				"field": "type",
				"equals": ""
			},
			{
				"not": {
					"field": "",
					"equals": "<subNetId>"
				}
			}
		]
	},
	"then": {
		"effect": ""
	}
}
```  

  * To list subnet id's:
```
az network vnet subnet list --resource-group "training" --vnet-name "allowedVnet"
```


* Clouddrive: to mount a drive to Cloudshell using a Storage Account:
```
clouddrive mount -s "<subscription id>" -g "<resource group>" -n "<storage account name>" -f "test"
```

* Files:
  * azurepolicy_encryption.json: Custom policy definition.  az policy definition create --name
  * azurepolicy_encryption.parameteres.json: Parameterers to config the policy.
  * azurepolicy_encryption.rules.json: Rules of the custom policy.
  * azurepolicy.network.parameters.json: Parameter configuration to use in step 3.
  * azurepolicy.template.json: Template JSON for a policy
