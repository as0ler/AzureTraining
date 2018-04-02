# AzureTraining
Materials for the Azure Training

Include Materials needed to deploy resources in Azure. 

## Monitor Alert
1. To Create a monitor alert execute the command listed above:

Powershell:
```
New-AzureRmResourceGroupDeployment -Name "HealthCheck" -ResourceGroupname "training" -TemplateUri "https://raw.githubus
ercontent.com/as0ler/AzureTraining/master/monitor-servicehealth-alert/azuredeploy.json"
```

Bash:
```
azure group deployment create <my-resource-group> <my-deployment-name> --template-uri https://raw.githubusercontent.com/azure/azure-quickstart-templates/master/monitor-servicehealth-alert/azuredeploy.json
```

2. Check Monitor to see the new Service Health Alert.
